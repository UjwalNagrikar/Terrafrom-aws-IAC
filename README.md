[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)


A comprehensive Terraform-based Infrastructure as Code project for deploying and managing AWS resources including VPC, EC2 instances, and security configurations.

## 🏗️ Architecture Overview

This project provisions a complete AWS infrastructure stack with:

- **Virtual Private Cloud (VPC)** with public and private subnets
- **EC2 instances** with configurable security groups
- **Internet Gateway** for public internet access
- **Route tables** for traffic routing
- **Security groups** with SSH and HTTP access
- **S3 backend** for remote state management

## 📁 Project Structure

```
.
├── aws-ec2/                 # Standalone EC2 configurations
│   ├── main.tf
│   ├── output.tf
│   └── provider.tf
├── aws-security_group/      # Security group with EC2 deployment
│   ├── main.tf
│   └── provider.tf
├── aws-vpc/                 # Complete VPC infrastructure
│   ├── main.tf
│   ├── output.tf
│   └── provider.tf
├── modules/                 # Reusable Terraform modules
│   ├── main.tf
│   ├── outputs.tf
│   └── provider.tf
├── tf-ec2-s3-backend/       # EC2 with S3 remote backend
│   ├── main.tf
│   └── provider.tf
└── README.md
```

## 🚀 Quick Start

### Prerequisites

Before you begin, ensure you have the following installed:

- [Terraform](https://www.terraform.io/downloads.html) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- An AWS account with necessary IAM permissions
- S3 bucket for remote state (for S3 backend option)

### AWS Configuration

1. **Configure AWS CLI:**
   ```bash
   aws configure
   ```

2. **Verify AWS credentials:**
   ```bash
   aws sts get-caller-identity
   ```

### Deployment Options

Choose one of the following deployment approaches:

#### Option 1: Complete VPC Infrastructure (Recommended)
```bash
cd aws-vpc/
terraform init
terraform plan
terraform apply
```

#### Option 2: Standalone EC2 Instance
```bash
cd aws-ec2/
terraform init
terraform plan
terraform apply
```

#### Option 3: EC2 with Custom Security Group
```bash
cd aws-security_group/
terraform init
terraform plan
terraform apply
```

#### Option 4: Module-based Deployment
```bash
cd modules/
terraform init
terraform plan
terraform apply
```

#### Option 5: EC2 with S3 Remote Backend (Production Ready)
```bash
cd tf-ec2-s3-backend/
terraform init
terraform plan
terraform apply
```

## 📋 Infrastructure Components

### VPC Configuration (`aws-vpc/`)
| Resource | Configuration |
|----------|---------------|
| **VPC CIDR** | 10.0.0.0/16 |
| **Public Subnet** | 10.0.0.0/24 |
| **Private Subnet** | 10.0.2.0/24 |
| **Internet Gateway** | Ujwal-IGW |
| **Availability Zone** | ap-south-1a |

### EC2 Instances
| Property | Value |
|----------|-------|
| **Instance Type** | t2.micro |
| **Key Pair** | Ujwal-SRE |
| **Public IP** | Enabled (public subnet) |
| **AMI** | Various (region-specific) |

### Security Groups
| Port | Protocol | Source | Description |
|------|----------|--------|-------------|
| 22 | TCP | 0.0.0.0/0 | SSH Access |
| 80 | TCP | 0.0.0.0/0 | HTTP Access |
| All | All | 0.0.0.0/0 | Outbound Traffic |

### S3 Backend Configuration (`tf-ec2-s3-backend/`)
| Property | Value |
|----------|-------|
| **S3 Bucket** | my-logs-un |
| **State File** | terraform.tfstate |
| **Region** | ap-south-1 |
| **Profile** | default |

## 📊 Outputs

Each module provides specific outputs:

### VPC Module Outputs
- **VPC ID**: Identifier of the created VPC
- **Public IP**: EC2 instance public IP address

### EC2 Module Outputs
- **Instance ID**: EC2 instance identifier
- **Public IP**: Instance public IP address
- **ARN**: Instance Amazon Resource Name

## 🗄️ State Management

### Local State (Default)
By default, Terraform stores state locally in a `terraform.tfstate` file. This is suitable for development and testing.

### Remote State with S3 Backend
For production environments, use the S3 backend configuration in `tf-ec2-s3-backend/`:

**Prerequisites for S3 Backend:**
1. Create an S3 bucket for state storage
2. Ensure proper IAM permissions for S3 access
3. Optionally configure DynamoDB for state locking

**S3 Backend Benefits:**
- **Remote Storage**: State file stored securely in S3
- **Team Collaboration**: Multiple team members can access the same state
- **Versioning**: S3 versioning provides state file history
- **Encryption**: State file can be encrypted at rest

**Setting up S3 Backend:**
```bash
# Create S3 bucket (if not exists)
aws s3 mb s3://my-logs-un --region ap-south-1

# Enable versioning (recommended)
aws s3api put-bucket-versioning \
    --bucket my-logs-un \
    --versioning-configuration Status=Enabled
```

## ⚠️ Important Notes

### Security Considerations
- **Open Security Groups**: Current configurations allow SSH (22) and HTTP (80) access from anywhere (0.0.0.0/0)
- **Production Hardening**: Restrict access to specific IP ranges in production environments
- **Key Management**: Ensure proper management of SSH key pairs
- **S3 Backend Security**: Ensure S3 bucket has proper access controls and encryption

### Known Issues
1. **Duplicate Resource Definitions**: Internet Gateway is defined twice in `aws-vpc/main.tf`
2. **AMI Inconsistencies**: Different AMI IDs across modules may cause deployment issues
3. **Hardcoded Values**: VPC ID is hardcoded in `aws-security_group/main.tf`
4. **S3 Backend Configuration**: Ensure S3 bucket exists before running terraform init

## 🔧 Recommended Improvements

### 1. Security Enhancements
```hcl
# Example: Restrict SSH access to specific IP
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["YOUR_IP/32"]  # Replace with your IP
}
```

### 2. Variable Configuration
Create `variables.tf` files for configurable values:
```hcl
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "allowed_cidr_blocks" {
  description = "CIDR blocks allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "s3_bucket" {
  description = "S3 bucket for terraform state"
  type        = string
  default     = "my-logs-un"
}
```

### 3. Environment-Specific Configurations
Use Terraform workspaces or separate directories for different environments:
```bash
terraform workspace new production
terraform workspace new staging
terraform workspace new development
```

### 4. Enhanced S3 Backend with DynamoDB Locking
```hcl
terraform {
  backend "s3" {
    bucket         = "my-logs-un"
    key            = "terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

## 🧹 Cleanup

To destroy all resources and avoid AWS charges:

```bash
# In the respective directory
terraform destroy
```

**⚠️ Warning**: This will permanently delete all resources. Ensure you have backups if needed.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin feature/new-feature`)
5. Create a Pull Request

### Contribution Guidelines
- Follow Terraform best practices
- Update documentation for any changes
- Test configurations before submitting
- Ensure security considerations are addressed
- Use remote state for production configurations

## 📚 Additional Resources

- [Terraform AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS VPC User Guide](https://docs.aws.amazon.com/vpc/latest/userguide/)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [AWS Security Best Practices](https://aws.amazon.com/architecture/security-identity-compliance/)
- [Terraform S3 Backend Documentation](https://www.terraform.io/docs/language/settings/backends/s3.html)

## 📞 Support

For questions or issues:
- Create an issue in this repository
- Check existing documentation
- Review AWS and Terraform documentation

---

**Note**: This project is for educational and development purposes. Please review security configurations before using in production environments. For production use, consider implementing S3 backend with DynamoDB locking for state management.
- Check existing documentation
- Review AWS and Terraform documentation

---

**Note**: This project is for educational and development purposes. Please review security configurations before using in production environments.
