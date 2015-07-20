#!/bin/bash
EXPECTED_ARGS=1
if [ $# -ne $EXPECTED_ARGS ]
then
  echo "Usage: create-feature-job BRANCH_NAME"
  exit 1
fi

FEATURE_NAME=$1
#USER_NAME=`git config --get user.email | sed 's/@.*//g'`
USER_NAME=`git config --get user.name`
EMAIL=`git config --get user.email`

cd C:/jenkinsJobCreate
cp -f jenkins-feature-config.xml $FEATURE_NAME.xml
sed -i -e "s/FEATURE/$FEATURE_NAME/g" -e "s/USERNAME/$USER_NAME/g" $FEATURE_NAME.xml
echo "Creating feature branch job on Jenkins..."
wget -nv --spider --post-file=$FEATURE_NAME.xml --header='Content-type: application/xml; charset=ISO-8859-1' --no-proxy --auth-no-challenge --http-user=$USER_NAME --http-password=****** http://localhost:1080/view/FeaturesCareIdCredentialManager/createItem?name=$FEATURE_NAME > /dev/null
rm $FEATURE_NAME.xml
