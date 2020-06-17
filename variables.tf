# Variables

variable "datadog_api_url" {
  default = "https://api.datadoghq.com/"
}

variable "datadog_api_key" {
  default = ""
}

variable "datadog_app_key" {
  default = ""
}

variable "environment" {
  description = "Fake corp environment"
  type        = string
  default     = "prod"
}

variable "critical_threshold" {
  description = "Critical CPU threshold"
  type        = string
  default     = "0.6"
}
