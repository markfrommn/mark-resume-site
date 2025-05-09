#!/bin/sh

#
# Run non-local bind.
# Assume the interfacee with the default route is the IP we want
#

defif=`ip route | egrep default | awk '{ print $5 }' `
myip=`ip address show dev $defif | egrep 'inet ' | awk '{ print $2}' | awk -F/ '{print $1}' `

hugo server  --bind=${myip} --baseURL=http://${myip}:1313 --disableFastRender --noHTTPCache
