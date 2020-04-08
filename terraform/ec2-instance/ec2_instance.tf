resource "aws_instance" "tfe" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.tfe_instance.id]
  iam_instance_profile        = aws_iam_instance_profile.tfe_instance.name
  key_name                    = var.key_name
  associate_public_ip_address = true
  volume_tags                 = var.common_tags
  tags                        = merge({ Name = "tfe-instance" }, var.common_tags)
  user_data_base64 = base64encode(templatefile("${path.module}/templates/cloud-init.tmpl", {

    replicated_conf_b64content = base64encode(templatefile("${path.module}/templates/replicated.conf.tmpl", {
      tfe_hostname       = var.tfe_hostname
      replicated_password = var.replicated_password
    }))

    tfe_settings_b64content = base64encode(templatefile("${path.module}/templates/settings.json.tmpl", {
      tfe_enc_password = var.tfe_enc_password
      tfe_hostname     = var.tfe_hostname
      tfe_pg_dbname    = var.tfe_pg_dbname
      tfe_pg_address   = var.tfe_pg_address
      tfe_pg_password  = var.tfe_pg_password
      tfe_pg_user      = var.tfe_pg_user
      tfe_s3_bucket    = var.tfe_s3_bucket
      tfe_s3_region    = var.tfe_s3_region
    }))

    install_wrapper_b64content = base64encode(file("${path.module}/templates/install_wrap.sh"))
  }))
}
