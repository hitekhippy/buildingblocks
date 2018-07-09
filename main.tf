// Configure the Google Cloud provider
provider "google" {
  project     = "meetup-site"
  region      = "us-central1"
  zone        = "us-central1-a"
  credentials = "${file("creds.json")}"
}

// Create a new instance
resource "google_compute_instance" "www" {
  name         = "tf-www-nginx"
  machine_type = "f1-micro"
  tags         = ["http-tag"]

  boot_disk {
    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-8"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "35.232.208.22"
    }
  }

  // update new instance and install dependencies needed from public repos
  metadata_startup_script = "apt-get -y update && apt-get -y install nginx"
}
