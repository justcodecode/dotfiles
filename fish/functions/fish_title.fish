function fish_title
    if [ $_ = 'fish' ]
        set -l realhome ~
        echo $PWD | sed -e "s|^$realhome|~|"
    else
        echo $_
    end
end
