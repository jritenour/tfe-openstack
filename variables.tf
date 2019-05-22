variable "region" {
   description = "Region name, for v3 keystone auth"
}

variable "vault_addr" {
   description = "Vault address with http/s prefix & port"
}

variable "name" {
   description = "Name of the intance(s)"
}

variable "image_name" {
   description = "Name of the image to use"
}

variable "flavor_name" {
   description = "Name of the compute flavor"
}

variable "key" {
   description = "The name of the public key to allow ssh access to the instance"
}

variable "network" {
   description = "The name of the network to attach the interface to"
}

variable "count" {
   description = "The number of instances to create"
}

variable "env" {
   description = "Environment tag"
}
