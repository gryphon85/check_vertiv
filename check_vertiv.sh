#!/bin/bash
# Variablen
hostname
community

sysStatus=1.3.6.1.4.1.476.1.42.3.9.20.1.20.1.2.1.4123

lgpSysMaintenanceCapacity=1.3.6.1.4.1.476.1.42.3.7.6.1.0
lgpSysMaintenanceYear=1.3.6.1.4.1.476.1.42.3.7.6.2.0
lgpSysMaintenanceMonth=1.3.6.1.4.1.476.1.42.3.7.6.3.0

function usage {
   echo ""
   echo "check_liebertcrv -H hostname -C community -O OperationType"
   echo ""
}

function systemStatus {
   systemstatus=(snmpget -v2c -c $community $hostname $sysStatus)

   if [ $systemstatus != 0 ]
   then

      echo "Systemstatus unbekannt"
      exit 3

   if [ "$systemstatus" = "Normal Operation" ]

      echo "Normal Operation"
      exit 0

   elif [ "$systemstatus" = "StartUp" ]

      echo "StartUp"
      exit 1

   elif [ "$systemstatus" = "Normal with Warning" ]

      echo "Normal with Warning"
      exit 1

   elif [ "$systemstatus" = "Normal with Alarm" ]

     echo "Normal with Alarm"
     exit 2

   elif [ "$systemtatus" = "Abnormal Operation" ]
    echo "Abnormal Operation"
    exit 2

   fi
fi

#   1: "Normal Operation"
#   2: "StartUp"
#   8: "Normal with Warning"
#   16: "Normal with Alarm"
#   32: "Abnormal Operation"

}

function maintentance {
   year=(snmpget -v2c -c $community $hostname $lgpSysMaintenanceYear) 
   month=(snmpget -v2c -c $community $hostname $lgpSysMaintenanceMonth)

   date +"%m %Y"

   echo "Nächste Wartung $month/$year"
   exit 0
}



