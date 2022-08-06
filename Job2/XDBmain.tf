provider "aws" {
  region  = "us-east-1"
}

resource "aws_db_instance" "pyjen" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "parthappd"
  password             = "partha1234"
  parameter_group_name = "default.mysql5.7"
  port                 = "3306"
  final_snapshot_identifier = true
  skip_final_snapshot       = true
}

resource "kubernetes_deployment" "pyjen" {
  metadata {
    name = "pyjen"
    labels = {
      app = "pyjen"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "pyjen"
      }
    }

    template {
      metadata {
        labels = {
          app = "pyjen"
        }
      }

      spec {
        container {
          image = "devopsparth/pyjen_app:latest"
          name  = "pyjen"

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
resource "kubernetes_service" "pyjen" {
  metadata {
    name = "pyjen"
  }
  spec {
    selector = {
      app = kubernetes_deployment.pyjen.metadata.0.labels.app
    }
    port {
      port        = 8080
      target_port = 80
    }

    type = "LoadBalancer"
  }
}
