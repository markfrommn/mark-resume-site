#!/bin/sh

#
# Run non-local bind.
# Assume the interfacee with the default route is the IP we want
#

os=`uname -o`
if [ "$os" = "Darwin" ]; then
    defif=`netstat -rn -f inet | egrep default | egrep -v 'link#' | sort -k 4 | head -1 | awk '{print $4}'  `
    myip=`ifconfig en0 | egrep inet | egrep -v inet6 | awk '{print $2}'`
    echo "Derived IP $myip from interface $defif"
elif [ "$os" = "Linux" ]; then
    defif=`ip route | egrep default | awk '{ print $5 }' `
    myip=`ip address show dev $defif | egrep 'inet ' | awk '{ print $2}' | awk -F/ '{print $1}' `
    echo "Derived IP $myip from interface $defif"
else
    echo "OS type $os not yet supported by $0, falling back to 127.0.0.1."
    myip=127.0.0.1
fi

hugo server  --bind=${myip} --baseURL=http://${myip}:1313 --disableFastRender --noHTTPCache -w
