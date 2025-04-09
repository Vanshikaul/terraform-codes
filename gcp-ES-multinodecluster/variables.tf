variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
}

variable "zone" {
  description = "GCP Zone"
  type        = string
}

variable "master_machine_type" {
  description = "Machine type for master node"
  type        = string
  default     = "e2-medium"
}

variable "data_machine_type" {
  description = "Machine type for data nodes"
  type        = string
  default     = "e2-medium"
}

variable "ansible_machine_type" {
  description = "Machine type for ansible node"
  type        = string
  default     = "e2-small"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}
