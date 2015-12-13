#!/usr/bin/env bash
set -ev

# run a conformance test for all files in the tools/
o_pwd=$(pwd)
cd test/
mkdir -p test-files/dm3
chmod 777 test-files/dm3

for i in ../tools/*.cwl; do
 bn=`basename ${i} .cwl`

 if [ "$(cat "${i}"|egrep -e "^class:\s+CommandLineTool$")" = "" ]; then
    continue;
 fi

 echo "Testing: ${bn}"

 if [ -f ${bn}-test.yaml ]; then
     ./cwltest.py --tool "cwltool" --conformance-test --test ${bn}-test.yaml
 else
    echo "fail"
 fi

done

#PUSH_DOCKER=""
#
#if [ "${TRAVIS_PULL_REQUEST}" = "false" ]; then
#    PUSH_DOCKER="--push-image"
#fi
#
#
#echo "STAR real run indexing genome/ reads alignment"
#./cwltest.py ${PUSH_DOCKER} --tool "cwltool" --test STAR-test.yaml
#
#echo "samtools-index indexing BAM"
#./cwltest.py ${PUSH_DOCKER} --tool "cwltool" --test samtools-index-test.yaml
#
#echo "bedtools-genomecov genomecov bedGraph"
#./cwltest.py ${PUSH_DOCKER} --tool "cwltool" --test bedtools-genomecov-test.yaml


cd ${o_pwd}
