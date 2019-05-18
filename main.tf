provider "openstack" {
  region      = "${var.region}"
}

resource "openstack_compute_instance_v2" "basic" {
  name            = "${var.name}"
  image_name        =  "${var.image_name}"
  flavor_name       = "${var.flavor_name}"
  key_pair        = "${var.key}"
  security_groups = ["default"]

  network {
    name = "${var.network}"
  }
 count = "${var.count}"
}
