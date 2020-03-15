resource "aws_iam_role" "ptfe_instance" {
  name = "${var.name_prefix}ptfe-instance"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF

  tags = var.common_tags
}

data "aws_iam_policy_document" "ptfe_instance" {
  
  statement {
    sid = "S3Access"
    actions = [
      "s3:*"
    ]
    resources = [
      "arn:aws:s3:::${var.ptfe_s3_bucket}"
    ]
  }

  statement {
    sid = "AsgLifecycleHook"
    actions = [
      "autoscaling:CompleteLifecycleAction"
    ]
    resources = [
      aws_autoscaling_group.ptfe.arn
    ]
  }

}

resource "aws_iam_role_policy" "ptfe_instance" {
  name = "${var.name_prefix}ptfe-policy"
  role = aws_iam_role.ptfe_instance.id

  policy = data.aws_iam_policy_document.ptfe_instance.json
}

resource "aws_iam_instance_profile" "ptfe_instance" {
  name = "${var.name_prefix}ptfe-instance"
  role = aws_iam_role.ptfe_instance.name
}