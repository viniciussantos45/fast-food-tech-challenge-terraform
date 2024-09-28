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
          image = var.app_image
          name  = "app"

          env {
            name  = "DB_HOST"
            value = var.db_address
          }
        }
      }
    }
  }
}
