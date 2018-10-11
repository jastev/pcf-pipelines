///////////////////////////////////////////////
//////// Pivotal Customer[0] //////////////////
//////// Set Azure Provider info///////////////
///////////////////////////////////////////////

provider "azurerm" {
  arm_subscription_id = "${var.arm_subscription_id}"
  arm_client_id       = "${var.arm_client_id}"
  arm_client_secret   = "${var.arm_client_secret}"
  arm_tenant_id       = "${var.arm_tenant_id}"

  version         = "~>1.16"
}

provider "template" {
  version         = "~>1.0"
}