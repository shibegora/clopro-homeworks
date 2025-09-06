resource "yandex_kms_symmetric_key" "encryption-key" {
  name              = "bucket-encryption-key"
  description       = "KMS key for encrypting bucket content"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
  folder_id         = var.folder_id
}

resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = var.service_account_id
  description        = "Static access key for object storage operations"
}

resource "yandex_storage_bucket" "encrypted-bucket" {
  bucket    = var.bucket_name
  folder_id = var.folder_id
  
  anonymous_access_flags {
    read = true
    list = false
  }

  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.encryption-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }

  force_destroy = false
}

resource "yandex_storage_object" "test-object" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = yandex_storage_bucket.encrypted-bucket.bucket
  key        = var.object_key
  source     = "./test.jpg"
  acl        = "public-read"

  depends_on = [yandex_storage_bucket.encrypted-bucket]
}

output "kms_key_id" {
  description = "ID созданного KMS ключа"
  value       = yandex_kms_symmetric_key.encryption-key.id
}

output "bucket_name" {
  description = "Имя созданного бакета"
  value       = yandex_storage_bucket.encrypted-bucket.bucket
}

output "bucket_url" {
  description = "Публичный URL бакета"
  value       = "https://storage.yandexcloud.net/${yandex_storage_bucket.encrypted-bucket.bucket}"
}

output "object_url" {
  description = "Публичный URL загруженной картинки"
  value       = "https://storage.yandexcloud.net/${yandex_storage_bucket.encrypted-bucket.bucket}/${var.object_key}"
}

output "access_key" {
  description = "Access key сервисного аккаунта"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  sensitive   = true
}

output "secret_key" {
  description = "Secret key сервисного аккаунта"
  value       = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  sensitive   = true
}