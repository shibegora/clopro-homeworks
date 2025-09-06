variable "cloud_id" {
  type        = string
  description = "ID of the Yandex Cloud"
}

variable "folder_id" {
  type        = string
  description = "ID of the folder in Yandex Cloud"
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