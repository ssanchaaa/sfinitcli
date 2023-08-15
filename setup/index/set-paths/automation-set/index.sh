#!/bin/bash

# автоматика создания конфигов с путями 

### set the current script path as PWD
pushd "${BASH_SOURCE%/*}" &> "/dev/null"

function _get_list_services 
{
  pTargetDir=${1}

  pushd "${pTargetDir}" &> "/dev/null"

  pServicesList=(`ls -d */ | cut -f1 -d'/'`)

  popd  &> "/dev/null"
}

# config `repo-content``
pRepoHomeDir="${1}"
pCliName=`basename "${pRepoHomeDir}"`
pRepoContentConfig="${pRepoHomeDir}""/""${pCliName}   .git""/""${pCliName}""/""index""/""pm""/""configs""/""/""paths""/""repo""/""repo_content""/""index.conf"

source "${pRepoContentConfig}"

# var-create v1
pVarCreateScriptV1="../VarCreate/index.sh"

# var-create v1.1
pVarCreateScriptV11="../VarCreate1.1/index.sh"

# var-create v2
pVarCreateScriptV2="../VarCreate-v2/index.sh"



pLibsPathQ="${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependencies}""/""libraries""/""local"

_get_list_services "${pLibsPathQ}"

# pServicesList was get from _get_list_services
for pServiceDirName in ${pServicesList[@]}
do   
    rm -r "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""content" 2>"/dev/null"
    rm -r "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""location" 2>"/dev/null"

    mkdir "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""content"
    mkdir "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""location"

    touch "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""content""/"${pConfFileNameAndExtension}

done


# pPrefixName="pSaifasdevopsautoarm"


"${pVarCreateScriptV1}" "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}" ${pConfFileNameAndExtension}
rm "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigs}""/"${pConfFileNameAndExtension} 2>"/dev/null"
mv `dirname "${pVarCreateScriptV1}"`/index.conf "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigs}"

"${pVarCreateScriptV1}" "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_Features}" "index.conf"
rm "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_Features}""/"${pConfFileNameAndExtension} 2>"/dev/null"
mv `dirname "${pVarCreateScriptV1}"`/index.conf "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_Features}"



pLibsPathQ="${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependencies}""/""libraries""/""local"

_get_list_services "${pLibsPathQ}"

# pServicesList was get from _get_list_services
for pServiceDirName in ${pServicesList[@]}
do   
    "${pVarCreateScriptV2}" "${pLibsPathQ}/${pServiceDirName}"

    rm -r "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""content""/""index.conf" 2>"/dev/null"
    rm -r "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""location""/""index.conf" 2>"/dev/null" 

    mv `dirname "${pVarCreateScriptV2}"`"/""content""/""index.conf" "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""content"
    mv `dirname "${pVarCreateScriptV2}"`"/""location""/""index.conf" "${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}""/"${pServiceDirName}"/""location"
done

# ${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigs}

# ${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependencies}"/""libraries""/""local""/"* # _get_list_services
# ${pSaifasArmRepoContentAbsoluteDirectoryNameQ_dependenciesConfigPathsLocal}

# ${pSaifasArmRepoContentAbsoluteDirectoryNameQ_Features}



### return the old PWD
popd &> "/dev/null"
