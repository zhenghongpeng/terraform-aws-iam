provider "aws" {
  region = "us-east-1"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    sid       = "AllowFullS3Access"
    actions   = ["s3:ListAllMyBuckets"]
    resources = ["*"]
  }
}

#########################################
# IAM policy
#########################################
module "iam_policy" {
  source = "../../modules/iam-policy"

  name        = "example"
  path        = "/"
  description = "My example policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

module "iam_policy_from_data_source" {
  source = "../../modules/iam-policy"

  name        = "example_from_data_source"
  path        = "/"
  description = "My example policy"

  policy = data.aws_iam_policy_document.bucket_policy.json
}
