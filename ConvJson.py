import json,sys

args=sys.argv
InfileName=args[1]

#File Open
with open(InfileName,'r') as f:
    ociaudit= json.load(f)

    for i in range(len(ociaudit['data'])):     

        #Remove opc-principal Object
        if 'opc-principal' in ociaudit['data'][i]['request-headers']:
            del  ociaudit['data'][i]['request-headers']['opc-principal']

with open(InfileName,'w') as fw:
    json.dump(ociaudit,fw,indent=2)


#Old Nated Convert
'''
    #Loop records of data objects in OCI log
    for i in range(len(ociaudit['data'])):     
        #Get each key in data objects
        keyList=ociaudit['data'][i].keys()
        #Loop keys
        for n in range(len(keyList)):
            #Check a key have nested key
            if isinstance(ociaudit['data'][i][keyList[n]],dict):
                #Get nested keys in the key
                NestKey= ociaudit['data'][i][keyList[n]].keys()
                for o in range(len(NestKey)):
                    #Insert into Key&Value in the layer of data object, Delete nested keys
                    KeyName = keyList[n] + '_' + NestKey[o]
                    KeyValue= ociaudit['data'][i][keyList[n]][NestKey[o]]
                    if KeyValue is None:
                        KeyValue = " "
                    ociaudit['data'][i][KeyName] =  "".join(KeyValue)
                    del  ociaudit['data'][i][keyList[n]][NestKey[o]]
                    aa = max(range(len(NestKey)))
                    if o == max(range(len(NestKey))):
                        del  ociaudit['data'][i][keyList[n]]
'''

