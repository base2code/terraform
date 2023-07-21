# Create IAM user
resource "aws_iam_user" "s3_user" {
  name = "s3_user"
  path = "/system/"
}

# Create the IAM access key
resource "aws_iam_access_key" "s3_user_key" {
  user = aws_iam_user.s3_user.name
}

# Create S3 policy
data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = ["arn:aws:s3:::*"]
  }

  statement {
    actions = [
      "s3:ListBucket",
      "s3:GetBucketAcl",
      "s3:GetBucketPolicy",
    ]

    resources = ["arn:aws:s3:::haste-s3-bucket"] # Replace with your bucket name
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject",
    ]

    resources = ["arn:aws:s3:::haste-s3-bucket/*"] # Replace with your bucket name
  }
}

# Create the policy
resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"
  path        = "/system/"
  description = "S3 policy"
  policy      = data.aws_iam_policy_document.s3_policy.json
}

# Attach the policy to the user
resource "aws_iam_user_policy_attachment" "s3_user_policy_attachment" {
  user       = aws_iam_user.s3_user.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

# Output the access and secret key
output "access_key_id" {
  value = aws_iam_access_key.s3_user_key.id
  sensitive = true
}

output "secret_access_key" {
  value = aws_iam_access_key.s3_user_key.secret
  sensitive = true
}