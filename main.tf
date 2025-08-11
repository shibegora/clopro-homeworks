resource "yandex_vpc_network" "my_network" {
  name = var.vpc_name
}

resource "yandex_vpc_route_table" "private_rt" {
  network_id = yandex_vpc_network.my_network.id
  name       = var.private_rt_name
  static_route {
    destination_prefix = var.private_dest_addr_pref
    next_hop_address   = var.each_vm["vm3"].ip_address
  }
}

resource "yandex_vpc_subnet" "public" {
  name           = var.public_cidr_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = var.public_cidr
}

resource "yandex_vpc_subnet" "private" {
  name           = var.private_cidr_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.my_network.id
  route_table_id = yandex_vpc_route_table.private_rt.id
  v4_cidr_blocks = var.private_cidr
}

resource "yandex_compute_instance" "my_network_instances" {
  for_each = var.each_vm

  name        = each.value.vm_name
  hostname    = each.value.vm_name
  platform_id = each.value.platform_id
  zone        = var.default_zone

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = each.value.os_family
      type     = each.value.type
      size     = each.value.disk_volume
    }
  }

  scheduling_policy {
    preemptible = each.value.scheduling_policy
  }

  network_interface {
    subnet_id  = local.subnet_map[each.value.subnet_name]
    nat        = each.value.network_interface
    ip_address = each.value.ip_address
  }

  metadata = merge(
    var.metadata,
    {
      user-data          = local.cloud_init_configs[each.key]
      serial-port-enable = 1
    }
  )
}