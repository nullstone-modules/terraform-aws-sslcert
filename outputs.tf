output "certificate_arn" {
  value = var.enabled ? aws_acm_certificate.this.arn : ""
}
