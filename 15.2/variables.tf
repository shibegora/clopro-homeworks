variable "cloud_id" {
  type        = string
  description = "ID of the Yandex Cloud. Get it with: yc resource-manager cloud list"
}

variable "folder_id" {
  type        = string
  description = "ID of the folder in Yandex Cloud. Get it with: yc resource-manager folder list"
}

variable "zone" {
  type = object({
    zone-a = string
    zone-b = string
  })
  default = {
    zone-a = "ru-central1-a"
    zone-b = "ru-central1-b"
  }
  description = "Availability zones for resources"
}

variable "cidr" {
  type = object({
    cidr0 = list(string)
    cidr1 = list(string)
  })
  default = {
    cidr0 = ["192.168.10.0/24"]
    cidr1 = ["192.168.20.0/24"]
  }
  description = "CIDR blocks for subnets"
}

variable "vpc_name" {
  type = object({
    net     = string
    public  = string
    private = string
  })
  default = {
    net     = "devops-hw-network"
    public  = "public-subnet-a"
    private = "private-subnet-b"
  }
  description = "Names for VPC network and subnets"
}

variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Family of the OS image for VMs (Ubuntu 20.04 LTS)"
}

variable "platform_id" {
  type        = string
  default     = "standard-v3"
  description = "The type of hardware platform for the VMs"
}

variable "user_vm" {
  type        = string
  description = "Username to create on the VM instance for SSH access"
}

variable "ssh_public_key" {
  type        = string
  description = "Public part of the SSH key for VM access"
}

variable "service_account_id" {
  type        = string
  description = "ID of the service account used for managing resources"
}

variable "bucket_name" {
  type        = string
  description = "Unique name for the Yandex Object Storage bucket"
}

variable "object_key" {
  type        = string
  description = "Key (name) of the object to store in the bucket"
}