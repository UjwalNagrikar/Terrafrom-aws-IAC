resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket-un"
}

resource "aws_s3_object" "name" {
  bucket = aws_s3_bucket.my-bucket.bucket
  source = "./myfile.txt"
  key = "mydata.txt"
}