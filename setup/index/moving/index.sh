#!/bin/bash

pDestinationArmLocation="${1}"

pCliName=`basename "${pDestinationArmLocation}"`

pDestinationArmLocationConf="${pDestinationArmLocation}"
pDestinationArmLocationSrc="${pDestinationArmLocation}"

pTempCP=~/sfautoNewCliTempForCP
mkdir -p ${pTempCP}

pushd ${pTempCP} &>"/dev/null"

wget "https://github.com/ssanchaaa/saifas_template_cli/archive/refs/heads/master.zip" >> "/dev/null"
unzip "master.zip"

popd &>"/dev/null"

mkdir -p "${pDestinationArmLocationSrc}"

if ! [ `ls "${pDestinationArmLocationSrc}" | wc -l` -eq 0 ]
then
    echo -e "\033[31mError - direcory no Empty\nPlease, clear it and try again\033[0m "
    rm -r -f ${pTempCP}
    exit -1
fi

mkdir -p "${pDestinationArmLocationSrc}""/""${pCliName}   .git""/"

pushd "${pDestinationArmLocationSrc}""/""${pCliName}   .git""/" &>"/dev/null"

echo "init commit" 2> index.md
git init
git add index.md
git commit -m "init commit. Repo with template: https://github.com/ssanchaaa/saifas_template_cli.git"

cp "${pTempCP}""/""saifas_template_cli-master""/"cli\'s_name"/""/" ./"${pCliName}" -r

git add *
git commit -m "template \"saifas_cli\" was added"


popd &> "/dev/null"


rm -r -f ${pTempCP}
