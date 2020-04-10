# OCM4OCI

## What is OMC4OCI? 
This script can export the JSON audit logs of Oracle Cloud infrastructure by OCI CLI Command and import it into Oracle Management Cloud by using OMC ODU command seamlessly. The native audit console of OCI is poor interface at the moment, so it's much better to take advantage of searching and analyzing audit logs by OMC Log Analytics.

## Requirement
OCI & OMC access account   
Configured environment working OCI CLI Command   
Python  
Bash  
JAVA

## How to use
1. Update the parameters in omc4oci.ini based on your OMC account  
2. List compartment ID in compartmentid.ini you want to extract the audit logs from OCI  
3. Unzip odu-client.zip  
4. Import content_oci4audit.zip which is a custom parser for OCI into OMC  
5. Run omc4oci.sh  

## Command
omc4oci.sh 'StartTime' 'EndTime' 'the full path of compartmentid.ini' 'the full path of omc4oci.ini'  

Example  
omc4oci.sh 2019-09-12T00:00 2019-09-05T19:00 ./compartmentid.ini ./omc4oci.ini  
omc4oci.sh 2019-09-01T10:00:10 2019-09-01T10:00:35 ./compartmentid.ini ./omc4oci.ini
