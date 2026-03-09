variable "yc_token" {
  type = string
  sensitive = true
}
variable "folder_id" {
  type = string
  sensitive = true
}
variable "app_port" {
  type = number
}
variable "db_user" {
  type = string
  sensitive = true
}
variable "db_password" {
  type = string
  sensitive = true
}
variable "db_name" {
  type = string
  sensitive = true
}
variable "image_id" {
  type = string
}
variable "zone" {
  type = string
}
variable "platform_id" {
  type = string
}
variable "ssh_login" {
  type = string
  sensitive = true
}
variable "ssh_key_path" {
  type = string
  sensitive = true
}
variable "datadog_api_key" {
  type = string
  sensitive = true
}
variable "datadog_app_key" {
  type = string
  sensitive = true
}
variable "datadog_api_url" {
  type = string
  sensitive = true
}
variable "datadog_site" {
  type = string
}
