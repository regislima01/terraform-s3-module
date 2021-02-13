# You need to define All values default from variables on the file <hourly.tfvars ; daily.tfvars or weekly.tfvars> inside youse folder  
variable "region" {
  type = string
  description = "put your region like: us-east-1 or us-east-2 etc..."
}

variable "bucket_name" {
  description = "The name of the bucket."
  type        = string
}

variable "acl" {
    type        = string
    description = "(Optional) The canned ACL to apply. Defaults to private."
}

variable "tags_hourly" {
    type        = map(string)
    description = "(Optional) Following the costs of S3 tagging your bucket"
    default = { reports = "hourly"}
}

variable "acceleration_status" {
  description = "(Optional) Sets the accelerate configuration of an existing bucket. Can be 'Enabled' or 'Suspended'."
  type        = string
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
}

variable "request_payer" {
  type        = string
  description = " (Optional) Identifier for Request Cost-allocation of S3 Bucket"
}

variable "versioning" {
    type        = bool
    description = "(Optional) Versioning is a means of keeping multiple variants of an object in the same bucket."
}

variable "lifecycle_rule_enabled" {
    type        = bool
    description = "Enable or disable lifecycle rule from s3 bucket."
}

variable "standard_transition_days" {
  type        = number
  description = "Number of days to persist in the standard storage tier before moving to the infrequent access tier"

}

variable "glacier_transition_days" {
  type        = number
  description = "Number of days after which to move the data to the glacier storage tier"
}

variable "expiration_days" {
  type        = number
  description = "Number of days after which to expunge the objects"
}

variable "sse_algorithm" {
    type        = string
    description = "(required) The server-side encryption algorithm to use. Valid values are AES256 and aws:kms"
}

variable "kms_master_key_id" {
    type        = string
    description = "(optional) The AWS KMS master key ID used for the SSE-KMS encryption. This can only be used when you set the value of sse_algorithm as aws:kms. The default aws/s3 AWS KMS master key is used if this element is absent while the sse_algorithm is aws:kms."
}

variable "block_public_acls" {
  type        = bool
  description = "Set to `false` to disable the blocking of new public access lists on the bucket"
}

variable "block_public_policy" {
  type        = bool
  description = "Set to `false` to disable the blocking of new public policies on the bucket"
}

variable "ignore_public_acls" {
  type = bool
  description = "(optional) Set to `false` to ignoring the publics acls."  
}

variable "restrict_public_buckets" {
  type = bool
  description = "(optional) Set to `false` to ignoring the publics acls."
}

variable "enable_glacier_transition" {
  type        = bool
  description = "Enables the transition to AWS Glacier which can cause unnecessary costs for huge amount of small files"
}

variable "enable_standard_ia_transition" {
  type        = bool
  description = "Enables the transition to STANDARD_IA or ONEZONE_IA" 
}

variable "enable_current_object_expiration" {
  type        = bool
  description = " (Required) Enables the expiration of current objects"
}

variable "policy_file" {
  type = string
  description = "(optional) attach a policy to your bucket"
}
