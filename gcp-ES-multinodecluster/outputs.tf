output "master_vm_ip" {
  description = "Static IP of the master node"
  value       = google_compute_address.static_ips["master"].address
}

output "data_vm_ips" {
  description = "Static IPs of data nodes"
  value       = [google_compute_address.static_ips["data-0"].address, google_compute_address.static_ips["data-1"].address]
}

output "ansible_vm_ip" {
  description = "Static IP of the ansible node"
  value       = google_compute_address.static_ips["ansible"].address
}
