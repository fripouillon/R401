#!/bin/bash

# System Config
OS=$(uname -s)
if [[ "${OS}" == 'Darwin' ]]; then
    export WORKSPACE_DIR=${PWD}
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home
    export JAVAFX_VERSION=21.0.2
    export JAVAFX_HOME=/Users/lklaine/Workspaces/R4.01/javafx-sdk-${JAVAFX_VERSION}
fi
export BINARY_DIR=$(realpath $(dirname $0))

# Project config
export PROJECT_NAME=${1//"/"/""}
export PROJECT_HOME=${WORKSPACE_DIR}/${PROJECT_NAME}
export PROJECT_MAINCLASS=MyApplication

# Build Project
echo + BUILD PROJECT [${PROJECT_NAME}]
echo ------------------------------

# Source Modules
modules=".\"${PROJECT_NAME}\".\"modules\""
modules=$(jq ${modules} ${BINARY_DIR}/configs.json)
export PROJECT_MODULES=${modules//"\""}

classpath=".\"${PROJECT_NAME}\".\"classpath\""
classpath=$(jq ${classpath} ${BINARY_DIR}/configs.json)
classpath=${classpath//"\""}
export PROJECT_CLASSPATH=""
for jar in ${classpath//":"/" "}; do
    export PROJECT_CLASSPATH=${PROJECT_CLASSPATH}:${BINARY_DIR}/${jar}
done

# Test commands
echo + CLEAR BINARY DIRECTORY [${PROJECT_HOME}/bin]
rm -f ${PROJECT_HOME}/bin/*

for fxml in $(find ${PROJECT_HOME}/src -name "*.fxml"); do
    echo + COPY FXML FILE [${fxml}] TO [${PROJECT_HOME}/bin]
    cp -f ${fxml} ${PROJECT_HOME}/bin
done

for jar in ${PROJECT_CLASSPATH//":"/" "}; do
    echo + COPY JAR FILE [${jar}] TO [${PROJECT_HOME}/bin]
    cp -f ${jar} ${PROJECT_HOME}/bin
done

if [[ "${PROJECT_MODULES}" != "" ]]; then
    export MODULES_ARGS="--module-path ${JAVAFX_HOME}/lib:${PROJECT_HOME}/bin --add-modules ${PROJECT_MODULES}"
fi

echo + GENERATE JAVA CLASSES FILES [${PROJECT_HOME}/bin]
${JAVA_HOME}/bin/javac ${MODULES_ARGS} -encoding UTF-8 -Xlint:deprecation -d ${PROJECT_HOME}/bin ${PROJECT_HOME}/src/*.java

echo + RUN JAVA APPLICATION [${PROJECT_MAINCLASS}]
echo ==============================
${JAVA_HOME}/bin/java ${MODULES_ARGS} -cp ${PROJECT_HOME}/bin ${PROJECT_MAINCLASS}
 