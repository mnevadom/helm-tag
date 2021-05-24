#!/bin/sh
set -e

tagNr=$1
repo=$2
user=$3
pass=$4

ls

#------------------- CAT VERSION / CHART --------------------

chartYaml=dgp-app/Chart.yaml
versionValues=values-files/version-values.yaml
valuesFile=dgp-app/values.yaml

echo "chart: "
cat $chartYaml
echo "version values: "
cat $versionValues

#------------------- CHART REPLACE --------------------

echo " ---- CHART REPLACE ----"
yq w -i $chartYaml 'version' $tagNr
yq w -i $chartYaml 'appVersion' $tagNr

echo "cat new Chart.yml"
cat $chartYaml

#------------------- VALUES WITH VERSION REPLACE --------------------

echo " ---- VERSIONS REPLACE ----"
cat $versionValues >> $valuesFile

echo "cat new values.yml"
cat $chartYaml

#------------------- HELM 3 INSTALL -------------------

helm3 version

#------------------- HELM PACKAGE  --------------------

PATH_OUT=charts-versions

rm $PATH_OUT/*
echo "deploying helm version $tagNr to path $PATH_OUT"
helm3 package dgp-app/ --version $tagNr --destination $PATH_OUT

#------------------- HELM DEPLOY --------------------

FILE_CHART=$PATH_OUT/dgp-app-$tagNr.tgz
echo "Uploading file $FILE_CHART to repo $repo "


curl -u $user:$pass $repo --upload-file $FILE_CHART -v
