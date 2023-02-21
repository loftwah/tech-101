# We'll use this guid to make the names for resources we generate in this drill
# unique and avoid clashing with any resources you may already have.
resource "random_uuid" "guid" {
}

# We'll use this data block to retrieve the latest AWS Linux AMI
# AMI is the AWS Machine Image. It's the template for our virtual machine
# We use this because when starting with Terraform and AWS, you may not yet be familiar with AMI IDs
# For now, feel free to ignore this block and just trust that it fetches the latest general
# Amazon Linux AMI.
data "aws_ami" "ami" {
  most_recent = true
  filter {
    name = "name"
    values = [
      "amzn2-ami-hvm-2.0.*-x86_64-gp2",
    ]
  }
}

# In order to log into your EC2 instance, your ssh public key must be added authorized_keys file
# This is done via the AWS key pair, which we'll generate here.
resource "aws_key_pair" "ssh_keypair" {
  key_name   = "ssh-key-${random_uuid.guid.result}"
  public_key = file(var.public_key_path)
}

# This will retrieve your current public IP and add it to the security rule we'll create.
# The security rule ensures that you and only you can ssh into the new EC2 instance.
data "http" "myip" {
  url = "https://ifconfig.me/ip"
}

# This security allows ssh into EC2 instances in the default VPC (Virtual Private Cloud)
# in which you are creating your EC2 instance. It restricts ssh access to your IP only.
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_${random_uuid.guid.result}"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "allow you to ssh into the instance"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.myip.response_body}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# This resource creates an EC2 instance
# The ssh command will be displayed in the terminal after the Terraform has been applied.
resource "aws_instance" "my_ec2" {
  ami                         = data.aws_ami.ami.id
  instance_type               = "t2.micro"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh_keypair.key_name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]
}




# Outputs
output "ami" {
  value = {
    id   = data.aws_ami.ami.id
    name = data.aws_ami.ami.name
  }
}

output "my-ip" {
  description = "My public IP"
  value       = data.http.myip.response_body

}

output "ec2-connection-command" {
  description = "Use this command to ssh into your EC2 instance"
  value       = "ssh -i '${var.private_key_path}' ec2-user@${aws_instance.my_ec2.public_dns}"
}
