# aws-ssl-cert

Terraform module to create an SSL Certificate using AWS Certificate Manager.

This module performs automatic validation using DNS management. 
As such, the certificate must be issued in the same AWS account where the DNS Zone is managed.
