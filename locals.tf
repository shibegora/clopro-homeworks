locals {
  # Cloud-init конфигурации с подстановкой SSH-ключа
  cloud_init_configs = {
    for vm_key, vm_config in var.each_vm : vm_key => templatefile(
      "${path.module}/cloud-init/vm${index(keys(var.each_vm), vm_key) + 1}.yaml",
      {
        vms_ssh_root_key = var.vms_ssh_root_key
      }
    )
  }

  # Маппинг подсетей
  subnet_map = {
    public  = yandex_vpc_subnet.public.id
    private = yandex_vpc_subnet.private.id
  }
}