#!/bin/sh
# 
# Licensed to the Apache Software Foundation (ASF) under one or more
# contributor license agreements.  See the NOTICE file distributed with
# this work for additional information regarding copyright ownership.
# The ASF licenses this file to You under the Apache License, Version 2.0
# (the "License"); you may not use this file except in compliance with
# the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Small shell script to show how to start the sample services.
#

JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64
JSVC=/home/tlstjddls123/Desktop/commons-daemon/jsvc

USER=tlstjddls123
DAEMON_HOME=/home/tlstjddls123/Desktop/commons-daemon
PID_FILE=$DAEMON_HOME/demon.pid
OUT_FILE=$DAEMON_HOME/daemon.out
ERR_FILE=$DAEMON_HOME/daemon.err
CLASSPATH=$DAEMON_HOME/commons-daemon-1.0.15.jar:$DAEMON_HOME/Test.jar


MAIN_CLASS=com.bagesoft.test.daemon.TestDaemon

case "$1" in

  start)
    #
    # Start Daemon
    #
    rm -f $OUT_FILE
    $JSVC \
    -user $USER \
    -java-home $JAVA_HOME \
    -pidfile $PID_FILE \
    -outfile $OUT_FILE \
    -errfile $OUT_FILE \
    -cp $CLASSPATH $MAIN_CLASS "zzzz" "gggg"
    #
    # To get a verbose JVM
    #-verbose \
    # To get a debug of jsvc.
    #-debug \
    exit $?
    ;;
  
    stop)
    #
    # Stop Daemon
    #
    $JSVC \
    -stop \
    -nodetach \
    -java-home $JAVA_HOME \
    -pidfile $PID_FILE \
    -outfile $OUT_FILE \
    -errfile $OUT_FILE \
    -cp $CLASSPATH \
    $MAIN_CLASS
    exit $?
    ;;

  *)
    echo "[Usage] TestDaemon.sh start | stop"
    exit 1;;
esac
