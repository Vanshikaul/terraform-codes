provider "google" {
  project = var.project_id
  region  = var.region
}

# Create VPC Network
resource "google_compute_network" "vpc_network" {
  name = "custom-vpc"
}

# Allow SSH
resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Static IP Addresses
resource "google_compute_address" "static_ips" {
  for_each = toset(["master", "ansible", "data-0", "data-1"])
  name     = "${each.key}-static-ip"
  region   = var.region
}

# VM Definitions
resource "google_compute_instance" "instances" {
  for_each     = tomap({ "master" = var.master_machine_type, "ansible" = var.ansible_machine_type, "data-0" = var.data_machine_type, "data-1" = var.data_machine_type })
  name         = "${each.key}-vm"
  machine_type = each.value
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
      nat_ip = google_compute_address.static_ips[each.key].address
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(pathexpand(var.ssh_public_key_path))}"
  }
}
