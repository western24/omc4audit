#!/bin/bash

#$1 = STARTDATE
#$2 = ENDDATE
#$3 = Compartmentid.ini File
#$4 = omc4oci.ini

#ODU Parameter Read from $4
#OMCINSTANCE, OMCUSER, OMCPASS,ODUDIR
. $4

#Check Arguments
if [ $# -ne 4 ]; then
 echo "Run formart 'You need 4 variables" 1>&2
 exit 1
fi

#TimeZone -> JST
STARTDATE=`date -d "$1" '+%Y-%m-%dT%T'+09:00`
ENDDATE=`date -d "$2" '+%Y-%m-%dT%T'+09:00`
INFILENAME=$3

COMPARTMENTID=()
i=0
SCRIPT_DIR=$(cd $(dirname $0); pwd)
echo "Access OCI audit between $1 and $2"

#Read Compartment ID
while IFS= read -r line; do
    i=$(($i+1))
    COMPARTMENTID[i]="$line"

    #Load audit from OCI
    oci audit event list --all --start-time=${STARTDATE} --end-time=${ENDDATE} --compartment-id ${COMPARTMENTID[i]} > ${COMPARTMENTID[i]}.json
    
    #Check File Size    
    if [ `stat -c %s ${COMPARTMENTID[i]}.json` -ne 0 ]; then

        echo "-- Start to upload ${COMPARTMENTID[i]} --"

        #Trim Objects from Json file
        echo "--Triming JSON--"
        env1="${SCRIPT_DIR}/${COMPARTMENTID[i]}.json"
        python3 ConvJson.py ${env1}

        #Upload to OMC
        echo "--Uploading to OMC--"
        ${ODUDIR}/odu-client upload -D ${OMCINSTANCE} -P ${OMCPASS} -U ${OMCUSER} -u ${UPLOADNAME}  -s "OCI Audit" ${env1}    
    else
        echo "${COMPARTMENTID[i]} is no data"
    fi    

done < $INFILENAME
echo "-- OMC4OCI END --"


