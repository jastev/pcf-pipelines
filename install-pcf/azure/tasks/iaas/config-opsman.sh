#!/bin/bash
set -ex

echo "=============================================================================================="
echo "Configuring OpsManager @ https://${OPSMAN_DOMAIN_OR_IP_ADDRESS} ..."
echo "=============================================================================================="

#Configure Opsman
om-linux --target https://${OPSMAN_DOMAIN_OR_IP_ADDRESS} -k \
  configure-authentication \
  --username "${PCF_OPSMAN_ADMIN}" \
  --password "${PCF_OPSMAN_ADMIN_PASSWORD}" \
  --decryption-passphrase "${PCF_OPSMAN_ADMIN_PASSWORD}"


if [[ ${ENABLE_OPSMAN_AAD} ]]; then
	echo "Configuring AAD SAML for OpsManager"
	om-linux --target https://${OPSMAN_DOMAIN_OR_IP_ADDRESS} -k \ 
	  configure-saml-authentication \ 
	  --saml-bosh-idp-metadata="https://login.microsoftonline.com/${AAD_OPSMAN_TENANTID}/federationmetadata/2007-06/federationmetadata.xml?appid=${AAD_OPSMAN_TENANTID}" \
	  --saml-idp-metadata="https://login.microsoftonline.com/${AAD_OPSMAN_TENANTID}/federationmetadata/2007-06/federationmetadata.xml?appid=${AAD_OPSMAN_TENANTID}" \
	  --saml-rbac-admin-group="${AAD_OPSMAN_GROUPID}" \
	  --saml-rbac-groups-attribute="http://schemas.microsoft.com/ws/2008/06/identity/claims/groups"
fi