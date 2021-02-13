provider "aws" {
  shared_credentials_file = "~/.aws/credentials"
  region = "us-east-1"
}

locals {
  buckets = {
    your-bucket-hourly-1234567812 = {
      acl                                     = "private",
      region                                  = "us-east-1",
      force_destroy                           = "true",
      request_payer                           = "BucketOwner",
      acceleration_status                     = "Suspended",
      versioning                              = "true",
      policy_file                             = "policies/hourly.json",
      kms_master_key_id                       = "aws:kms",
      sse_algorithm                           = "AES256",
      block_public_acls                       = "true",
      block_public_policy                     = "true",
      restrict_public_buckets                 = "true",
      ignore_public_acls                      = "true",
      lifecycle_rule_enabled                  = "true",
      enable_glacier_transition               = "true",
      enable_standard_ia_transition           = "true",
      enable_current_object_expiration        = "true",
      standard_transition_days                = 30,
      glacier_transition_days                 = 60,
      expiration_days                         = 180
    },

    your-bucket-daily-1234567812 = {
      acl                                     = "private",
      region                                  = "us-east-1",
      force_destroy                           = "true",
      request_payer                           = "BucketOwner",
      acceleration_status                     = "Suspended",
      versioning                              = "true",
      policy_file                             = "policies/daily.json",
      kms_master_key_id                       = "aws:kms",
      sse_algorithm                           = "AES256",
      block_public_acls                       = "true",
      block_public_policy                     = "true",
      restrict_public_buckets                 = "true",
      ignore_public_acls                      = "true",
      lifecycle_rule_enabled                  = "true",
      enable_glacier_transition               = "true",
      enable_standard_ia_transition           = "true",
      enable_current_object_expiration        = "true",
      standard_transition_days                = 30,
      glacier_transition_days                 = 60,
      expiration_days                         = 180
    },
    
    your-bucket-weekly-1234567812 = {
      acl                                     = "private",
      region                                  = "us-east-1",
      force_destroy                           = "true",
      request_payer                           = "BucketOwner",
      acceleration_status                     = "Suspended",
      versioning                              = "true",
      policy_file                             = "policies/weekly.json",
      kms_master_key_id                       = "aws:kms",
      sse_algorithm                           = "AES256",
      block_public_acls                       = "true",
      block_public_policy                     = "true",
      restrict_public_buckets                 = "true",
      ignore_public_acls                      = "true",
      lifecycle_rule_enabled                  = "true",
      enable_glacier_transition               = "true",
      enable_standard_ia_transition           = "true",
      enable_current_object_expiration        = "true",
      standard_transition_days                = 30,
      glacier_transition_days                 = 60,
      expiration_days                         = 180
    }
  }
}

module "bucket_s3" {
    source                              = "../s3-module"
    for_each                            = local.buckets 
    bucket_name                         = each.key
    acl                                 = each.value.acl
    region                              = each.value.region
    versioning                          = each.value.versioning
    kms_master_key_id                   = each.value.kms_master_key_id
    sse_algorithm                       = each.value.sse_algorithm
    force_destroy                       = each.value.force_destroy
    request_payer                       = each.value.request_payer     
    acceleration_status                 = each.value.acceleration_status
    restrict_public_buckets             = each.value.restrict_public_buckets
    block_public_acls                   = each.value.block_public_acls
    block_public_policy                 = each.value.block_public_policy 
    ignore_public_acls                  = each.value.ignore_public_acls 
    lifecycle_rule_enabled              = each.value.lifecycle_rule_enabled
    standard_transition_days            = each.value.standard_transition_days
    glacier_transition_days             = each.value.glacier_transition_days
    enable_glacier_transition           = each.value.enable_glacier_transition
    enable_standard_ia_transition       = each.value.enable_standard_ia_transition
    enable_current_object_expiration    = each.value.enable_current_object_expiration
    expiration_days                     = each.value.expiration_days 
    policy_file                         = file(each.value.policy_file)
}
