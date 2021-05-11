output "certificate_arn" {
  value = try(aws_acm_certificate.this[0].arn, "")
}
