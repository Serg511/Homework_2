output "internal_ip_address_servers" {
  value = yandex_compute_instance.pcm-[*].network_interface.0.ip_address
}

output "external_ip_address_servers" {
  value = yandex_compute_instance.pcm-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_iscsi" {
  value = yandex_compute_instance.iscsi[*].network_interface.0.ip_address
}

output "external_ip_address_iscsi" {
  value = yandex_compute_instance.iscsi[*].network_interface.0.nat_ip_address
}

resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tpl",
 {
  iscsi-ip = yandex_compute_instance.iscsi[0].network_interface.0.nat_ip_address
  pcm-0-ip = yandex_compute_instance.pcm-[0].network_interface.0.nat_ip_address
  pcm-1-ip = yandex_compute_instance.pcm-[1].network_interface.0.nat_ip_address
  pcm-2-ip = yandex_compute_instance.pcm-[2].network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory"
}

resource "local_file" "hosts" {
 content = templatefile("hosts.tpl",
  {
   iscsi-ip = yandex_compute_instance.iscsi[0].network_interface.0.ip_address
   pcm-0-ip = yandex_compute_instance.pcm-[0].network_interface.0.ip_address
   pcm-1-ip = yandex_compute_instance.pcm-[1].network_interface.0.ip_address
   pcm-2-ip = yandex_compute_instance.pcm-[2].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/pacemaker/files/hosts"
}