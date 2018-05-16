provider "aws" { region = "us-east-2" }

resource "aws_launch_configuration" "footprints" {
    image_id = "ami-916f59f4"
    instance_type = "t2.micro"
    key_name = "Footprints"
    security_groups = ["${aws_security_group.footprints_security_group.id}"]

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_security_group" "footprints_security_group" {
  name = "Footprints Security Group"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "footprints_autoscaling" {
  launch_configuration = "${aws_launch_configuration.footprints.id}"
  availability_zones = ["us-east-2a", "us-east-2b", "us-east-2c"]

  min_size = 1
  max_size = 1

  tag {
    key = "footprints"
    value = "terraform-asg-footprints"
    propagate_at_launch = true
  }
}
