#!/bin/bash
trap 'echo "FAILED at line ${LINENO} in ${BASH_SOURCE}"' ERR
### set the current script path as PWD
pushd ${BASH_SOURCE%/*} &> "/dev/null"

function _set_variable_value
{
    sed -i "s/${1}=.*/${1}=${2}/" "${3}"
}

pDestinationHomeArmLocation=${1}
pDestinationHomeArmLocation=${pDestinationHomeArmLocation//"//"/"/"} 

pCliName=`basename "${pDestinationHomeArmLocation}"`
pDestinationArmLocation="${pDestinationHomeArmLocation}""/""${pCliName}   .git""/""${pCliName}"


pConfigPath="${pDestinationArmLocation}/index/pm/configs"

# setting `workspace`
pConfigWorkspacePath="${pConfigPath}/paths/workspace"
pConfigWorkspaceConfFile="${pConfigPath}/paths/workspace/index.conf"

if [[ ${pDestinationArmLocation} == *"/home/"* ]]
then
    _set_variable_value "pSaifasArmProjectWorkspacePath" "\${HOME}" "${pConfigWorkspaceConfFile}"
else 
    _set_variable_value "pSaifasArmProjectWorkspacePath" '"\"\""' "${pConfigWorkspaceConfFile}"
fi


# setting `project` 
pConfigProjectPath="${pConfigPath}/paths/project"
pConfigProjectConfFile="${pConfigPath}/paths/project/index.conf"

pNum=`echo ${pDestinationArmLocation} | cut -d / -f 1,2,3 | wc -m`
pResD=`dirname "${pDestinationArmLocation:${pNum}}"`
pResB=`basename ${pDestinationArmLocation:${pNum}}`

if [[ ${pDestinationArmLocation} == *"/home/"* ]]
then
    _set_variable_value "pSaifasArmProjectRelativeParentDirectoryPath" "\"${pResD//"/"/"\/"}\"" "${pConfigProjectConfFile}"
else 
    pTemp="opt\/sfauto\/"${pResD//"/"/"\/"}
    _set_variable_value "pSaifasArmProjectRelativeParentDirectoryPath" "\"${pTemp}\"" "${pConfigProjectConfFile}"
fi

_set_variable_value "pSaifasArmProjectDirectoryName" "\"${pResB//"/"/"\/"}\"" "${pConfigProjectConfFile}"


# settings `repo-root`
pConfigRepoRootPath="${pConfigPath}/paths/repo/repo_root"
pConfigRepoRootConfFile="${pConfigPath}/paths/repo/repo_root/index.conf"

_set_variable_value "pSaifasArmRepoRootDirectoryNameQ" "\".\"" "${pConfigRepoRootConfFile}"


# setting `repo-home`
pConfigRepoHomePath="${pConfigPath}/paths/repo/repo_home"
pConfigRepoHomeConfFile="${pConfigPath}/paths/repo/repo_home/index.conf"

_set_variable_value "pSaifasArmRepoHomeDirectoryName" "\".\"" "${pConfigRepoHomeConfFile}"


# setting `logs`
pConfigLogStepPath="${pConfigPath}/paths/logs"
pConfigLogStepConfFile="${pConfigPath}/paths/logs/index.conf"

_set_variable_value "pSaifasArmLogsRelativeParentDirectory" "\"${pCliName}\"" "${pConfigLogStepConfFile}"


### return the old PWD
popd &> "/dev/null"
