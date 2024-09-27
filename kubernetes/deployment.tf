resource "kubernetes_deployment" "app_deployment" {
  metadata {
    name      = "app"
    namespace = "default"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "app"
      }
    }

    template {
      metadata {
        labels = {
          app = "app"
        }
      }

      spec {
        container {
          image = "seu_docker_image"
          name  = "app"

          env {
            name  = "DB_HOST"
            value = aws_db_instance.default.address
          }
        }
      }
    }
  }
}
