#!/bin/bash

# скрипт для создания конфига с  переменными с путями


function _get_list_services 
{
  pTargetDir="${1}"

  pushd "${pTargetDir}" > "/dev/null"

  pServicesList=(`ls -d */ | cut -f1 -d'/'`)

  popd  > "/dev/null"
}


### set the current script path as PWD
pushd "${BASH_SOURCE%/*}" >> "/dev/null"

## parameters:

pStartSearchPathQ=${1:-"`pwd`"}
pDepConfigPath="${2}"
pNameForFindFile=${3:-"index.sh"}
pParentProjectNameQ=${4:-""}
pTextBeforeName=${5:-""}
pTextAfterName=${6:-""}


pOutputFile="./index.conf"


pCurrentFileRealpath=`realpath "${BASH_SOURCE}"`
pCurrentFileDirname=`dirname "${pCurrentFileName}"`
pushd "${pCurrentFileDirname}" >> "/dev/null"


pushd "${pStartSearchPathQ}" >> "/dev/null"

_get_list_services "${pStartSearchPathQ}"

# pServicesList was get from _get_list_services
for pServiceDirName in "${pServicesList[@]}"
do   
    pSearchResult+=("./""${pServiceDirName}")
    # echo "${pStartSearchPathQ}""/""${pServiceDirName}"
done


popd >> "/dev/null"


pPyScript="./index.py"


rm ${pOutputFile} 2> "/dev/null"


if [[ -z "${pParentProjectNameQ}" ]]
then
  pParentProjectNameQ=`python3 ${pPyScript} "$(dirname ${pStartSearchPathQ})" 3`
  echo "pParentProjectNameQ:${pParentProjectNameQ}"
  pParentProjectNameQ="p"${pParentProjectNameQ}
fi

echo -e "\n## parent directory" >> ${pOutputFile}
echo "${pParentProjectNameQ}""=\"""${pStartSearchPathQ}""\"" >> ${pOutputFile}
echo "" >> ${pOutputFile}

for pVariable in "${pSearchResult[@]}"
do

  pVariableAfterPyScript=`python3 ${pPyScript} "${pVariable}" 3`
  echo "${pParentProjectNameQ}""DirName_"${pVariableAfterPyScript}"=\"""${pVariable:2}""\"" >> ${pOutputFile}
  echo "${pParentProjectNameQ}""RelativePath_"${pVariableAfterPyScript}"=\""${pVariable:2}"\"" >> ${pOutputFile}
  echo "pFileNameAndExtantion="${pNameForFindFile} >> ${pOutputFile}
  echo "${pParentProjectNameQ}""AbsolutePath_"${pVariableAfterPyScript}"Q=\"""${pDepConfigPath}""/"${pVariable:2}""/""content""/"${pNameForFindFile}\"" >> ${pOutputFile}
  echo -e "\n" >> ${pOutputFile}
done


popd >> "/dev/null"


### return the old PWD
popd >> "/dev/null"