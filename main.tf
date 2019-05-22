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

resource "openstack_compute_secgroup_v2" "secgroup" {
  name        = "ssh_http"
  description = "my security group"

  rule {
    from_port   = 22
    to_port     = 22
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }

  rule {
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr        = "0.0.0.0/0"
  }
}

resource "openstack_compute_instance_v2" "basic" {
  name            = "${var.name}-${count.index}"
  image_name        =  "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  key_pair        = "${var.key}"
  security_groups = ["ssh_http"]
  depends_on = ["openstack_compute_secgroup_v2.secgroup"]

  metadata = {
    env = "prod"
  }

  network {
    name = "${var.network}"
  }
 count = "${var.count}"
}
