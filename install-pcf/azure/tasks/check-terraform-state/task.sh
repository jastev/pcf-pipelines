#!/bin/bash

set -ex

# Copyright 2017-Present Pivotal Software, Inc. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

function getBlobFiles ()
{
  blobs=$(az storage blob list --account-name ${TERRAFORM_AZURE_STORAGE_ACCOUNT_NAME} --account-key ${TERRAFORM_AZURE_STORAGE_ACCESS_KEY} -c ${TERRAFORM_AZURE_STORAGE_CONTAINER_NAME})
  files=$(echo "$blobs" | jq -r .[].name)
  return files
}

function checkFileExists(files)
{
  set +e
  echo ${files} | grep ${TERRAFORM_AZURE_STATEFILE_NAME}
  if [ "$?" -gt "0" ]; then
    echo "Existing ${TERRAFORM_AZURE_STATEFILE_NAME}.tfstate file not found. Proper access to storage available to initialize in create-infrastructure."
  else
    echo "Existing ${TERRAFORM_AZURE_STATEFILE_NAME}.tfstate file found. Remove the file for this task to pass or proceed to next steps if this is desired."
    exit 1
  fi
}

(
  set -e
  getBlobFiles
  checkFileExists($files)
)

errorCode=$?
if [ $errorCode -ne 0 ]; then
  echo "az command to failed to successfully complete"
  exit $errorCode
fi
