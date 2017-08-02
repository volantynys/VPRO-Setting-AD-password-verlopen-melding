#!/bin/bash

#########################################################################
#
#   This script will let the user know how many days are left until their AD password expires
#
#   Author: Jason Borchardt
#     Date: 10/15/12
#
#########################################################################

pwdPolicy=90
lastpwdMS=`dscl /Active\ Directory/intra.vpro.nl/All\ Domains/ read /Users//$USER pwdLastSet | /usr/bin/awk '/pwdLastSet:/{print $2}'`
lastpwdUNIX1=`expr $lastpwdMS / 10000000 - 1644473600`
lastpwdUNIX=`expr $lastpwdUNIX1 - 10000000000`
todayUNIX=`date +%s`
diffDays1=`expr $todayUNIX - $lastpwdUNIX`
diffDays=`expr $diffDays1 / 86400`
daysRemaining=`expr $pwdPolicy - $diffDays`
/Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper -windowType utility -title "$daysRemaining" -description "Dagen tot het wachtwoord verloopt: $daysRemaining" -icon /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/ToolbarInfo.icns -button1 "OK" -defaultButton 1