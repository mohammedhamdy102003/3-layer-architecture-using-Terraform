resource "aws_s3_bucket" "vendor_bucket" {
  bucket = "vendor-data-bucket-example"
  tags = { Name = "vendor-s3" }
}