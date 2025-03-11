#!/bin/bash

# System Config
OS=$(uname -s)
if [[ "${OS}" == 'Darwin' ]]; then
    export WORKSPACE_DIR=${PWD}
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home
    export TOMCAT_VERSION=10.1.19
    export TOMCAT_HOME=/Users/lklaine/Workspaces/R4.01/apache-tomcat-${TOMCAT_VERSION}
fi
export BINARY_DIR=$(realpath $(dirname $0))

if [[ "$1" != "" ]]; then
    if [[ "$2" != "--no-restart" ]]; then
        echo + TOMCAT STOP
        /usr/local/apache-tomcat-${TOMCAT_VERSION}/bin/shutdown.sh
    fi

    echo ==============================
    
    export PROJECT_NAME=${1//"/"/""}
    export PROJECT_HOME=${WORKSPACE_DIR}/${PROJECT_NAME}
    export INSTALL_HOME=${TOMCAT_HOME}/webapps/${PROJECT_NAME}

    # Build Project
    echo + BUILD PROJECT [${PROJECT_NAME}]
    echo ------------------------------

    # Clear Install Path
    if [[ -d "${INSTALL_HOME}" ]]; then
        echo + CLEAR INSTALL PATH [${INSTALL_HOME}]
        rm -Rf ${INSTALL_HOME}
    fi

    # Source Modules Config
    modules=".\"${PROJECT_NAME}\".\"modules\""
    modules=$(jq ${modules} ${BINARY_DIR}/deploy.json)
    export PROJECT_MODULES=${modules//"\""}

    classpath=".\"${PROJECT_NAME}\".\"classpath\""
    classpath=$(jq ${classpath} ${BINARY_DIR}/deploy.json)
    classpath=${classpath//"\""}
    export PROJECT_CLASSPATH=""
    for jar in ${classpath//":"/" "}; do
        export PROJECT_CLASSPATH=${PROJECT_CLASSPATH}:${BINARY_DIR}/${jar}
    done

    # Build/Install Command
    echo + CREATE INSTALL PATH [${INSTALL_HOME}]
    mkdir -p ${INSTALL_HOME}/WEB-INF/classes
    mkdir -p ${INSTALL_HOME}/WEB-INF/lib

    if [ -d "${PROJECT_HOME}/www" ]; then
        echo + COPY STATIC FILES [${INSTALL_HOME}]
        cp -Rf ${PROJECT_HOME}/www/* ${INSTALL_HOME}
    fi

    for jar in ${PROJECT_CLASSPATH//":"/" "}; do
        echo + COPY JAR FILE [${jar}] TO [${INSTALL_HOME}/WEB-INF/lib]
        cp -f ${jar} ${INSTALL_HOME}/WEB-INF/lib
    done

    if [[ "${PROJECT_MODULES}" != "" ]]; then
        export MODULES_ARGS="--module-path ${INSTALL_HOME}/WEB-INF/lib --add-modules ${PROJECT_MODULES}"
    fi

    if [ -d "${PROJECT_HOME}/src" ]; then
        echo + GENERATE JAVA CLASSES FILES [${INSTALL_HOME}/WEB-INF/classes]
        ${JAVA_HOME}/bin/javac ${MODULES_ARGS} -encoding UTF-8 -Xlint:deprecation -cp ${PROJECT_CLASSPATH} -d ${INSTALL_HOME}/WEB-INF/classes ${PROJECT_HOME}/src/*.java
    fi

    if [ -d "${PROJECT_HOME}/bin" ]; then
        echo + COPY JAVA CLASSES FILES [${INSTALL_HOME}/WEB-INF/classes]
        cp -f ${PROJECT_HOME}/bin/*.class ${INSTALL_HOME}/WEB-INF/classes
    fi

    echo ==============================

    if [[ "$2" != "--no-restart" ]]; then
        echo + TOMCAT START
        /usr/local/apache-tomcat-${TOMCAT_VERSION}/bin/startup.sh
    fi
else
    echo + TOMCAT STOP
    /usr/local/apache-tomcat-${TOMCAT_VERSION}/bin/shutdown.sh

    # Clear Install Path
    for target in $(ls -d */); do
        $0 $(basename ${target}) --no-restart
    done

    echo + TOMCAT START
    /usr/local/apache-tomcat-${TOMCAT_VERSION}/bin/startup.sh
fi
