resource "aws_internet_gateway" "dev_igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "dev_igw"
  }
}
