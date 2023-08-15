#!/bin/bash


pArg="${PWD}"

### set the current script path as PWD
pushd "${BASH_SOURCE%/*}" &> "/dev/null"

pProjectPath="${pArg}"
pProjectPath=${pProjectPath//"//"/"/"}

pMovingScript="./moving/index.sh"
pSetConfScript="./set-conf-var/index.sh"
pSetPathScript="./set-paths/automation-set/index.sh"

sudo echo "ssanchaaa" > "/dev/null"


if [[ ${pProjectPath} == *"/home/"* ]]
then
    "${pMovingScript}" "${pProjectPath}"

    "${pSetConfScript}" "${pProjectPath}"

    "${pSetPathScript}" "${pProjectPath}"
else
    ${pMovingScript} "${pProjectPath}"

    sudo ${pSetConfScript} "${pProjectPath}"

    sudo ${pSetPathScript} "${pProjectPath}"
fi

### return the old PWD
popd &> "/dev/null"
