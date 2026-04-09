resource "aws_secretsmanager_secret" "db_url" {
  name                    = "${var.project_name}/${var.environment}/database-url"
  recovery_window_in_days = var.environment == "prod" ? 30 : 0

  tags = {
    Name = "${var.project_name}-db-url"
  }
}

resource "aws_secretsmanager_secret_version" "db_url" {
  secret_id = aws_secretsmanager_secret.db_url.id
  secret_string = format(
    "postgresql://%s:%s@%s:5432/%s",
    var.db_username,
    random_password.db.result,
    aws_db_instance.main.address,
    var.db_name
  )

  depends_on = [aws_db_instance.main]
}
