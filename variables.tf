/* Module Variables */

variable "environment" {
  description = "Fake corp environment"
  type        = "string"
  default     = "prod"
}

variable "critical_threshold" {
  description = "Critical CPU threshold"
  type        = "string"
  default     = "0.6"
}
