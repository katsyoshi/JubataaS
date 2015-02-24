#!/bin/sh

wget 'https://katsyoshi.org/download/jubatus-0.7.0.tar.xz'
DIR=`pwd`
tar xJf jubatus-0.7.0.tar.xz

if [ -d $DIR/jubatus ] ; then
    sed -i 's?=$?='${DIR}'?' ${DIR}/jubatus/share/jubatus/jubatus.profile
    cat ${DIR}/jubatus/share/jubatus/jubatus.profile
    if [ -f ${DIR}/jubatus/share/jubatus/jubatus.profile ] ; then
        sh ${DIR}/jubatus/share/jubatus/jubatus.profile
    fi

    echo $PATH
    jubaclassifier -f ${JUBATUS_HOME}/share/jubatus/example/config/classifier/arow.json &
    /sbin/pidof jubaclassifier > ${DIR}/classifier.pid
    exit 0
fi

