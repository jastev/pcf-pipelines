function get_subnet_list() {
	NETWORK_LIST=$(az network vnet subnet list -g network-core --vnet-name vnet-pcf --output json | jq '.[] | select(.name == \"ert\") | .id' | tr -d '\"')
	if [ -z "$NETWORK_LIST" ]; then
		echo "ERROR: Got empty network list"
		exit 1
	else
		echo $NETWORK_LIST
		return "${NETWORK_LIST}" 
	fi
}


ERT_SUBNET_CMD=get_subnet_list
ERT_SUBNET=$(eval ${ERT_SUBNET_CMD})
