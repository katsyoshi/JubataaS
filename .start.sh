#!/bin/sh

wget 'https://katsyoshi.org/download/jubatus-0.7.0.tar.xz'
tar xJf jubatus-0.7.0.tar.xz
sed -i 's?=$?='`pwd`'?' jubatus/share/jubatus/jubatus.profile
source jubatus/share/jubatus/jubatus.profile

jubaclassifier -f ${JUBATUS_HOME}/share/jubatus/example/config/classifier/arow.json &
/sbin/pidof jubaclassifier > `pwd`/classifier.pid

