#/bin/env bash
DEBUG=1


check_package() {
    package_name=$1
    # is package present:
    dpkg-query -W --showformat='${Status}\n' $package_name | grep "install ok installed" 1>/dev/null
    return $?
}


apt_update_done=0
packages=( "python3" "python3-venv" "libssl1.0.0" )
for package in "${packages[@]}"
do
    check_package $package
    if [ "$?" = 1 ] ; then
        echo "Apt package $package not present, installing..."
        if [ "$apt_update_done" = 0 ] ; then
            if [ "$DEBUG" = 1 ] ; then
                sudo apt-get update
            else
                sudo apt-get update 1>/dev/null
            fi
            apt_update_done=1
        fi
        if [ "$DEBUG" = 1 ] ; then
            sudo apt-get install -y $package
        else
            sudo apt-get install -y $package 1>/dev/null
        fi
    else
        echo "Apt package $package already present."
    fi
done
unset check_package


python3 -m venv e 
source e/bin/activate

pip freeze 2>&1 | grep "ansible"
if [ "$?" = 1 ] ; then
    echo "Making sure necessary pip packages are present"
    if [ "$DEBUG" = 1 ] ; then
        pip install -U pip
        pip install ansible==2.7.8 cryptography==2.4.2
    else
        pip install -U pip 1>/dev/null
        pip install ansible==2.7.8 cryptography==2.4.2 1>/dev/null
    fi
fi

echo "Finished, now you can run ansible."
