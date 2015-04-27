// refer to https://github.com/beltex/libsmc
// clang++ main.cpp -framework IOKit -O3

#include <iostream>
#include <vector>
#include <IOKit/IOKitLib.h>

using namespace std;

static const int SMC_KEY_SIZE = 4;

enum SMCCommand {
    kSMCUserClientOpen  = 0,
    kSMCUserClientClose = 1,
    kSMCHandleYPCEvent  = 2,
    kSMCReadKey         = 5,
    kSMCWriteKey        = 6,
    kSMCGetKeyCount     = 7,
    kSMCGetKeyFromIndex = 8,
    kSMCGetKeyInfo      = 9
};

typedef struct {
    unsigned char  major;
    unsigned char  minor;
    unsigned char  build;
    unsigned char  reserved;
    unsigned short release;
} SMCVersion;

typedef struct {
    uint16_t version;
    uint16_t length;
    uint32_t cpuPLimit;
    uint32_t gpuPLimit;
    uint32_t memPLimit;
} SMCPLimitData;

typedef struct {
    IOByteCount dataSize;
    uint32_t    dataType;
    uint8_t     dataAttributes;
} SMCKeyInfoData;

typedef struct {
    uint32_t       key;
    SMCVersion     vers;
    SMCPLimitData  pLimitData;
    SMCKeyInfoData keyInfo;
    uint8_t        result;
    uint8_t        status;
    uint8_t        data8;
    uint32_t       data32;
    uint8_t        bytes[32];
} SMCParam;

typedef struct {
    uint8_t  data[32];
    uint32_t dataType;
    uint32_t dataSize;
} SMCValue;

typedef struct {
    int current;
    int min;
    int max;
} Fan;

class SMC {
    io_connect_t conn;

public:
    SMC() {
        io_service_t service = IOServiceGetMatchingService(kIOMasterPortDefault, IOServiceMatching("AppleSMC"));

        if (service == 0) {
            cerr << "error: AppleSMC not found" << endl;
            return;
        }

        kern_return_t result = IOServiceOpen(service, mach_task_self(), 0, &conn);
        IOObjectRelease(service);
        if (result != kIOReturnSuccess) {
            cerr << "error: failed to open smc connection" << endl;
            return;
        }
    }

    ~SMC() {
        IOServiceClose(conn);
    }

    double cpu_temp() {
        const string cpuKey = "TC0P";

        SMCValue value;

        kern_return_t result = read_smc(cpuKey, &value);
        if (result == kIOReturnSuccess) {
            return ntohs(*(UInt16*)value.data) / 256.0;
        } else {
            cerr << "error: cpu temp is invalid" << endl;
            return 0.0;
        }
    }

    vector<Fan> fans() {
        vector<Fan> fans;
        SMCValue value;
        char num[2];

        for (int i = 0; i < 2; i++) {
            sprintf(num, "%d", i);
            
            fans.push_back(Fan());
            
            string key = string("F") + num + "Ac";
            kern_return_t result = read_smc(key, &value);
            if (result == kIOReturnSuccess) {
                fans[i].current = ntohs(*(UInt16*)value.data) / 4.0;
            }

            key = string("F") + num + "Mn";
            result = read_smc(key, &value);
            if (result == kIOReturnSuccess) {
                fans[i].min = ntohs(*(UInt16*)value.data) / 4.0;
            }

            key = string("F") + num + "Mx";
            result = read_smc(key, &value);
            if (result == kIOReturnSuccess) {
                fans[i].max = ntohs(*(UInt16*)value.data) / 4.0;
            }
        }

        return fans;
    }

private:
    /**
        Convert SMC key to uint32_t. This must be done to pass it to the SMC.
        :param: key The SMC key to convert
        :returns: uint32_t translation. Returns zero if key is not 4 characters in length.
    */
    uint32_t to_uint32_t(const string &key) {
        uint32_t result = 0;
        uint32_t shift = 24;

        // SMC key is expected to be 4 bytes - thus 4 chars
        if (key.length() != SMC_KEY_SIZE) {
            cerr << "key is invalid, key=" << key << endl;
            return 0;
        }

        for (unsigned i = 0; i < SMC_KEY_SIZE; ++i) {
            result += key.at(i) << shift;
            shift -= 8;
        }

        return result;
    }

    kern_return_t call_smc(SMCParam *input, SMCParam *output) {
        size_t inputSize  = sizeof(SMCParam);
        size_t outputSize = sizeof(SMCParam);

        kern_return_t result = IOConnectCallStructMethod(conn, kSMCHandleYPCEvent, input, inputSize, output, &outputSize);

        if (result != kIOReturnSuccess) {
            result = err_get_code(result);
        }

        return result;
    }

    kern_return_t read_smc(const string &key, SMCValue *value) {
        SMCParam input;
        SMCParam output;

        memset(&input, 0, sizeof(SMCParam));
        memset(&output, 0, sizeof(SMCParam));
        memset(value, 0, sizeof(SMCValue));

        // First call to AppleSMC - get key info
        input.key = to_uint32_t(key);
        input.data8 = kSMCGetKeyInfo;

        kern_return_t result = call_smc(&input, &output);
        if (result != kIOReturnSuccess || output.result != 0) {
            cerr << "error: failed to get key info" << endl;
            return result;
        }

        // Store data for return
        value->dataSize = output.keyInfo.dataSize;
        value->dataType = output.keyInfo.dataType;    
        
        // Second call to AppleSMC - now we can get the data
        input.keyInfo.dataSize = output.keyInfo.dataSize;
        input.data8 = kSMCReadKey;

        result = call_smc(&input, &output);
        if (result != kIOReturnSuccess || output.result != 0) {
            cerr << "error: failed to read key" << endl;
            return result;
        }

        memcpy(value->data, output.bytes, sizeof(output.bytes));

        return result;
    }
};

int main() {
    SMC smc;

    cout << "<?xml version=\"1.0\"?><items>";
    cout << "<item><title>CPU: " << smc.cpu_temp() << "° C</title></item>" << endl;

    vector<Fan> fans = smc.fans();
    for (int i=0; i<fans.size(); i++) {
        cout << "<item><title>Fan #"<< i << ": " << fans[i].current << " rpm" << "</title><subtitle>min: " << fans[i].min << " rpm, max: " << fans[i].max << " rpm</subtitle></item>" << endl;
    }
    
    return 0;
}



