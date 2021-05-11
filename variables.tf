variable "enabled" {
  description = "This enables/disables creating the SSL certificate. We cannot use module count because we have aliased providers."
  type        = bool
  default     = true
}

variable "domain" {
  description = "A domain name for which the certificate should be issued. Zone ID is used to create validation records"
  type = object({
    name : string
    zone_id : string
  })
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "alternative_names" {
  description = "A list of alternative names to issue with this certificate."
  type        = list(string)
  default     = []
}
