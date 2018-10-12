///////////////////////////////////////////////
//////// Pivotal Customer[0] //////////////////
//////// MySQL PaaS ////////////////////////
///////////////////////////////////////////////

resource "azurerm_mysql_server" "test" {
  name                = "${var.env_name}-mysql"
  depends_on          = ["azurerm_subnet.ert_subnet"]
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.pcf_resource_group.name}"
  // Conditional on the mysql_paas_enable variable.
  count = "${var.mysql_paas_enable}"

  sku {
    name = "GP_Gen5_2"
    capacity = 2
    tier = "GeneralPurpose"
    family = "Gen5"
  }

  storage_profile {
    storage_mb = 102400
    backup_retention_days = 7
    geo_redundant_backup = "Enabled"
  }

  administrator_login = "${var.mysql_paas_admin_username}"
  administrator_login_password = "${var.mysql_paas_admin_password}"
  version = "5.7"
  ssl_enforcement = "Enabled"
}