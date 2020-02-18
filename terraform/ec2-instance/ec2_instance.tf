resource "aws_instance" "ptfe" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.ptfe_instance.id]
  iam_instance_profile        = aws_iam_instance_profile.ptfe_instance.name
  key_name                    = var.key_name
  associate_public_ip_address = true
  volume_tags                 = var.common_tags
  tags                        = merge({ Name = "ptfe-instance-${formatdate("YYMMDD", timestamp())}" }, var.common_tags)
  user_data_base64 = base64encode(templatefile("${path.module}/templates/cloud-init.tmpl", {

    replicated_conf_b64content = base64encode(templatefile("${path.module}/templates/replicated.conf.tmpl", {
      ptfe_hostname       = var.ptfe_hostname
      replicated_password = var.replicated_password
    }))

    ptfe_settings_b64content = base64encode(templatefile("${path.module}/templates/settings.json.tmpl", {
      ptfe_enc_password = var.ptfe_enc_password
      ptfe_hostname     = var.ptfe_hostname
      ptfe_pg_dbname    = var.ptfe_pg_dbname
      ptfe_pg_address   = var.ptfe_pg_address
      ptfe_pg_password  = var.ptfe_pg_password
      ptfe_pg_user      = var.ptfe_pg_user
      ptfe_s3_bucket    = var.ptfe_s3_bucket
      ptfe_s3_region    = var.ptfe_s3_region
    }))

    install_wrapper_b64content = base64encode(file("${path.module}/templates/install_wrap.sh"))
  }))
}
