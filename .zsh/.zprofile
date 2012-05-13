export PATH=$HOME/java/apache-maven-3.0.4/bin:$HOME/java/jdk1.7.0_03/bin:$HOME/bin:$PATH
export JDK_HOME=$HOME/java/jdk1.7.0_03/
export M2_HOME=$HOME/java/apache-maven-3.0.4

if [[ -z $DISPLAY ]] && ! [[ -e /tmp/.X11-unix/X0 ]] && (( EUID )); then
    startx
fi
