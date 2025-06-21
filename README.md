# AWS Infrastructure as Code (IaC) Project

This repository contains Terraform configurations for deploying AWS infrastructure resources.

## Project Structure

```
.
├── aws-ec2/           # EC2 instance configurations
├── aws-security_group/ # Security group configurations
├── aws-vpc/           # VPC and networking configurations
└── modules/           # Reusable Terraform modules
```

## Infrastructure Components

### VPC Configuration
- **VPC**: `Ujwal-VPC` with CIDR block 10.0.0.0/16
- **Subnets**:
  - Public Subnet: 10.0.0.0/24
  - Private Subnet: 10.0.2.0/24
- **Internet Gateway**: `Ujwal-IGW` for public subnet connectivity
- **Route Table**: Configured with default route to Internet Gateway

### EC2 Instances
- **Instance Type**: t2.micro
- **Key Pair**: Ujwal-SRE
- **Security Groups**: Configured with SSH (port 22) and HTTP (port 80) access
- **Public IP**: Enabled for public subnet instances

### Security Groups
- **Security Group**: `my-security-group`
  - Ingress Rules:
    - SSH (port 22) from 0.0.0.0/0
    - HTTP (port 80) from 0.0.0.0/0
  - Egress Rules:
    - All outbound traffic allowed (0.0.0.0/0)

## Prerequisites

- Terraform installed (latest version recommended)
- AWS CLI configured with appropriate credentials
- AWS account with necessary permissions

## Getting Started

1. Initialize Terraform:
   ```bash
   terraform init
   ```

2. Plan the infrastructure:
   ```bash
   terraform plan
   ```

3. Apply the infrastructure:
   ```bash
   terraform apply
   ```

## Security Considerations

- Security groups are configured to allow SSH and HTTP access from any IP (0.0.0.0/0)
- Consider restricting access to specific IP ranges in production environments
- Ensure proper IAM roles and permissions are configured

## Cleanup

To destroy all resources:
```bash
terraform destroy
```

## Contributing

Please ensure to follow best practices:
- Use variables for configurable values
- Maintain proper documentation
- Follow Terraform best practices
- Keep security in mind when modifying configurations

## License

MIT License
