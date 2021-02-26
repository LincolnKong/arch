mkdir -p  /tmp/scripts/${ORACLE_SID}

cat > /tmp/scripts/${ORACLE_SID}/${ORACLE_SID}_sche_del_arch.sh

#!/bin/bash
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=${ORACLE_BASE}/product/11.2.0/db_2
export ORACLE_SID=PROD
export LD_LIBRARY_PATH=${ORACLE_HOME}/lib
export TNS_ADMIN=${ORACLE_HOME}/network/admin
export PATH=$PATH:${ORACLE_HOME}/bin:${ORACLE_HOME}/OPatch:${ORA_CRS_HOME}/bin
CLASSPATH=${ORACLE_HOME}/jlib:${ORACLE_HOME}/OPatch/jlib
SCRIPT_PATH=/tmp/scripts/${ORACLE_SID}      ##路径修改

cd $SCRIPT_PATH   
filepath1=`dirname $0`
filepath=`cd $filepath1; pwd`
mkdir -p ${filepath}/${ORACLE_SID}_log/

log=${filepath}/${ORACLE_SID}_log/sche_del_arch.log  


while true
do

sleep 10

sh ${SCRIPT_PATH}/${ORACLE_SID}_del_arch.sh 
status=$?
if [ $status -eq 0 ]
then
    echo ${log}
    echo `date +"%Y-%m-%d  %H:%M:%S"`  oracle_$ORACLE_SID delete archive success  >> ${log} 
else
   echo `date +"%Y-%m-%d  %H:%M:%S"`  oracle_$ORACLE_SID delete archive false  >> ${log} 
   exit 1  
fi
done