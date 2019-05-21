provider "vault" {
  address = "${var.vault_addr}"
}

data "vault_generic_secret" "openstack_credentials" {
  path = "kv/openstack"
}

provider "openstack" {
  user_name = "${data.vault_generic_secret.openstack_credentials.data["user_name"]}"
  tenant_name       = "${data.vault_generic_secret.openstack_credentials.data["tenant_name"]}"
  password     = "${data.vault_generic_secret.openstack_credentials.data["password"]}"
  auth_url   = "${data.vault_generic_secret.openstack_credentials.data["auth_url"]}"
  region   = "${data.vault_generic_secret.openstack_credentials.data["region"]}"
}

resource "openstack_compute_instance_v2" "basic" {
  name            = "${var.name}-${count.index}"
  image_name        =  "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  key_pair        = "${var.key}"
  security_groups = ["default"]

  network {
    name = "${var.network}"
  }
 count = "${var.count}"
}
