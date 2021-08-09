resource "aws_acm_certificate" "this" {
  domain_name               = var.domain.name
  validation_method         = "DNS"
  subject_alternative_names = var.alternative_names
  tags                      = var.tags

  count = var.enabled ? 1 : 0
}

locals {
  dvos = [for dvo in try(aws_acm_certificate.this[0].domain_validation_options, []) : {
    name   = dvo.resource_record_name
    record = dvo.resource_record_value
    type   = dvo.resource_record_type
  }]
}

resource "aws_route53_record" "cert_validation" {
  name            = local.dvos[count.index].name
  zone_id         = var.domain.zone_id
  type            = "CNAME"
  ttl             = 60
  allow_overwrite = true
  records         = [local.dvos[count.index].record]

  count = var.enabled ? length(var.alternative_names) + 1 : 0
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this[count.index].arn
  validation_record_fqdns = aws_route53_record.cert_validation.*.fqdn

  timeouts {
    create = "5m"
  }

  count = var.enabled ? 1 : 0
}

