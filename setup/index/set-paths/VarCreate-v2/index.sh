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

rm -rf "./location" 2>> "/dev/null"
rm -rf "./content" 2>> "/dev/null"


pOutputFile="./index.conf"
mkdir "./location" &>> "/dev/null"
mkdir "./content" &>> "/dev/null"
pOutputLocation="./location/"${pOutputFile}
pOutputContent="./content/"${pOutputFile}

pushd "${pStartSearchPathQ}" &> "/dev/null"

pSearchResult=(`find  -name ${pNameForFindFile} -type f`)

# echo ${pSearchResult[@]}

popd &> "/dev/null"


pPyScript="./index.py"


rm ${pOutputLocation} &> "/dev/null"
rm ${pOutputContent} &> "/dev/null"

if [[ -z "${pParentProjectNameQ}" ]]
then
  pParentProjectNameQ=`python3 ${pPyScript} "$(dirname ${pStartSearchPathQ})" 3`
  pParentProjectNameQ="p"${pParentProjectNameQ}
fi

echo -e "\n## parent directory" >> ${pOutputLocation}
echo "${pParentProjectNameQ}""=\"""${pStartSearchPathQ}""\"" >> ${pOutputLocation}
echo "" >> ${pOutputContent}

for pVariable in ${pSearchResult[@]}
do
  pVariable=`dirname ${pVariable}`

  echo ${pVariable}
  pVariableAfterPyScript=`python3 ${pPyScript} ${pVariable} 2`
  echo "${pParentProjectNameQ}""DirName_"${pVariableAfterPyScript}"=\""`basename ${pVariable:2}`"\"" >> ${pOutputContent}
  echo "${pParentProjectNameQ}""RelativePath_"${pVariableAfterPyScript}"=\""${pVariable:2}"\"" >> ${pOutputContent}
  echo "pFileNameAndExtantion="${pNameForFindFile} >> ${pOutputContent}
  echo "${pParentProjectNameQ}""AbsolutePath_"${pVariableAfterPyScript}"Q=\"""${pStartSearchPathQ}""/"${pVariable:2}""/"${pNameForFindFile}\"" >> ${pOutputContent}
  echo -e "\n" >> ${pOutputContent}
done


### return the old PWD
popd &> "/dev/null"