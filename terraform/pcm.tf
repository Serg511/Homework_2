resource "yandex_compute_instance" "pcm-" {
  depends_on = [yandex_vpc_subnet.subnet-1]
  count = 3
  name = "pcm-${count.index}"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    user-data = "${file("./meta.txt")}"
  }
}