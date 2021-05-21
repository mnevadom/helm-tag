#!/bin/sh
set -e

tagNr=$1

ls

echo "version values: "
cat values-files/version-values.yaml

chartYaml=dgp-app/Chart.yaml
cat $chartYaml

echo " ---- CHART REPLACE ----"
yq w -i $chartYaml 'version' $tagNr
yq w -i $chartYaml 'appVersion' $tagNr

cat $chartYaml

# helm repo add nexusdgp https://admin:doG00d@nexus.dogoodpeople.net/repository/helm-dgp/
PATH_OUT=charts-versions

rm $PATH_OUT/*
echo "deploying helm version $tagNr to path $PATH_OUT"
helm package dgp-app/ --version $tagNr --destination $PATH_OUT

FILE_CHART=$PATH_OUT/dgp-app-$tagNr.tgz
echo "Uploading file $FILE_CHART to repo $REPO_URL "


curl -u admin:DoG00d $REPO_URL --upload-file $FILE_CHART -v