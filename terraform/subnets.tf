resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.0/28"
  availability_zone       = "ap-southeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-sn-1"
  }
}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "192.168.0.16/28"
  availability_zone       = "ap-southeast-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "public-sn-2"
  }
}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.0.32/28"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "private-sn1"
    }
}
    
resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "192.168.0.48/28"
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "private-sn2"
  }
}

