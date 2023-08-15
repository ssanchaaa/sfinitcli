#!/bin/bash

# скрипт для создания конфига с  переменными с путями

### set the current script path as PWD
pushd "${BASH_SOURCE%/*}" &> "/dev/null"

## parameters:

pStartSearchPathQ=${1:-"`pwd`"}
pNameForFindFile=${2:-"index.sh"}
pParentProjectNameQ=${3:-""}
pTextBeforeName=${4:-""}
pTextAfterName=${5:-""}


pOutputFile="./index.conf"

pushd "${pStartSearchPathQ}" &> "/dev/null"

pSearchResult=(`find  -name ${pNameForFindFile} -type f`)


popd &> "/dev/null"


pPyScript="./index.py"


rm ${pOutputFile} &> "/dev/null"


if [[ -z "${pParentProjectNameQ}" ]]
then
  pParentProjectNameQ=`python3 ${pPyScript} "$(dirname ${pStartSearchPathQ})" 3`
  pParentProjectNameQ="p"${pParentProjectNameQ}
else
  pParentProjectNameQ=${pParentProjectNameQ}`python3 ${pPyScript} "$(dirname ${pStartSearchPathQ})" 2`
fi

echo -e "\n## parent directory" >> ${pOutputFile}
echo "${pParentProjectNameQ}""=\"""${pStartSearchPathQ}""\"" >> ${pOutputFile}
echo "" >> ${pOutputFile}

for pVariable in ${pSearchResult[@]}
do
  pVariable=`dirname ${pVariable}`

  echo ${pVariable}
  pVariableAfterPyScript=`python3 ${pPyScript} ${pVariable} 4`
  echo "${pParentProjectNameQ}""DirName_"${pVariableAfterPyScript}"=\""`basename ${pVariable:2}`"\"" >> ${pOutputFile}
  echo "${pParentProjectNameQ}""RelativePath_"${pVariableAfterPyScript}"=\""${pVariable:2}"\"" >> ${pOutputFile}
  echo "pFileNameAndExtantion="${pNameForFindFile} >> ${pOutputFile}
  echo "${pParentProjectNameQ}""AbsolutePath_"${pVariableAfterPyScript}"Q=\"""${pStartSearchPathQ}""/"${pVariable:2}""/"${pNameForFindFile}\"" >> ${pOutputFile}
  echo -e "\n" >> ${pOutputFile}
done


popd &> "/dev/null"


### return the old PWD
popd &> "/dev/null"
