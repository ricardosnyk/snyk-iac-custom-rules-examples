provider "oci" {
   auth = "InstancePrincipal"
   region = var.region
}

resource "oci_objectstorage_bucket" "valid" {
    #Required
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.bucket_namespace
    versioning = "Enabled"
}

resource "oci_objectstorage_bucket" "invalid" {
    #Required
    compartment_id = var.compartment_id
    name = var.bucket_name
    namespace = var.bucket_namespace
    versioning = "Disabled"
}

