terraform {
  required_version = ">= 0.14"
  required_providers {
    openstack = {
      source = "terraform-provider-openstack/openstack"
    }
  }
}

data "openstack_networking_network_v2" "test" {
  name = "portal-internal"
}

resource "openstack_networking_port_v2" "test" {

  name = "test"
  network_id = data.openstack_networking_network_v2.test.id
}

resource "openstack_compute_instance_v2" "test" {

  name = "test-vm"
  image_name = "Rocky-8-GenericCloud-Base-8.9-20231119.0.x86_64.qcow2"
  flavor_name = "vm.ska.cpu.general.small"
  key_pair = "slurm-app-ci"

  network {
    port = openstack_networking_port_v2.test.id
    access_network = true
  }

}

resource "local_file" "inventory" {
  content = <<-EOT
    [all]
    test-vm ansible_user=rocky ansible_host=${openstack_compute_instance_v2.test.access_ip_v4}
  EOT
  filename = "inventory/hosts"
}
