#!/bin/bash
set -ex

echo "=============================================================================================="
echo "Configuring OpsManager @ https://${OPSMAN_DOMAIN_OR_IP_ADDRESS} ..."
echo "=============================================================================================="

#Configure Opsman
if [[ ${AUTHENTICATION_MODE} == "saml"]]; then
#if [[ ${ENABLE_OPSMAN_AAD} ]]; then
	echo "Configuring AAD SAML for OpsManager"
	om-linux --target "https://${OPSMAN_DOMAIN_OR_IP_ADDRESS}" -k \
		--username "${PCF_OPSMAN_ADMIN}" \
  		--password "${PCF_OPSMAN_ADMIN_PASSWORD}" \
	  configure-saml-authentication \
	  	--saml-bosh-idp-metadata "https://login.microsoftonline.com/${OPSMAN_AAD_TENANTID}/federationmetadata/2007-06/federationmetadata.xml?appid=${OPSMAN_AAD_APPID}" \
	  	--saml-idp-metadata "https://login.microsoftonline.com/${OPSMAN_AAD_TENANTID}/federationmetadata/2007-06/federationmetadata.xml?appid=${OPSMAN_AAD_APPID}" \
		--saml-rbac-admin-group "${OPSMAN_AAD_ADMIN_GROUPID}" \
	  	--saml-rbac-groups-attribute "http://schemas.microsoft.com/ws/2008/06/identity/claims/groups" \
		--decryption-passphrase "${PCF_OPSMAN_ADMIN_PASSWORD}"

elif [[ ${AUTHENTICATION_MODE} == "internal"]]; then
	om-linux --target https://${OPSMAN_DOMAIN_OR_IP_ADDRESS} -k \
		configure-authentication \
		--username "${PCF_OPSMAN_ADMIN}" \
		--password "${PCF_OPSMAN_ADMIN_PASSWORD}" \
		--decryption-passphrase "${PCF_OPSMAN_ADMIN_PASSWORD}"
fi