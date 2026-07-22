# Design Decisions

## Why single template?

Initial Plan:
Week 3
│
├── networking.yaml
│      (VPC, IGW, Route Tables)
│
├── ec2.yaml
│      (EC2 + Security Groups)
│
└── full-stack.yaml
       imports both

Larger companies work like:
production/
│
├── networking.yaml
├── security.yaml
├── database.yaml
├── compute.yaml
├── monitoring.yaml
└── main.yaml

The comapny is divided into teams and they edit their particular yaml file. 

---

## Architecture

VPC
│
├── Internet Gateway
│
├── Public Subnet A
│
├── Public Subnet B
│
├── Route Table
│
├── ALB Security Group
│
├── EC2 Security Group
│
├── Launch Template
│
├── Target Group
│
├── Application Load Balancer
│
├── Listener
│
└── Auto Scaling Group

---

# Key Concepts

1. What is Infrastructure as Code?
-> IaC means defining and managing your cloud infrastructure (servers, networks, databases) through code/configuration files instead of manually clicking through a console.

Analogy: Instead of verbally telling a contractor what to build each time, you hand them a blueprint — the blueprint is your code.

Explanation: Before IaC, setting up infrastructure meant logging into the AWS Console and manually creating resources one by one — slow, inconsistent, and hard to repeat. With IaC, you write a file that describes exactly what you want, and AWS builds it automatically. The same file run twice produces the exact same infrastructure every time — this is what your task means by "consistency and repeatability."

2. Why CloudFormation Instead of Clicking in the Console?
->
|Console (Manual)|CloudFormation (IaC)|
|----------------|--------------------|
|Click through UI each time	|Define once, deploy repeatedly|
|Easy to make mistakes	|Consistent, version-controlled|
|Hard to replicate across environments	|Same template → dev, staging, productio|
|No record of what was built	|Template is the documentation|

Bottom line: Clicking works for learning. CloudFormation is what you use in a real job where infrastructure needs to be repeatable, auditable, and scalable.

3. What is a Stack?
-> A Stack is a collection of AWS resources that CloudFormation creates, manages, and deletes together as a single unit — based on one template.

Analogy: If the template is a blueprint, the Stack is the actual building constructed from it.

Explanation: When you run a CloudFormation template, AWS creates a Stack. That Stack tracks every resource it built (EC2, VPC, RDS, etc.). If you delete the Stack, AWS automatically deletes all resources inside it — no manual cleanup needed.

4. What is a template?
-> A Template is a YAML or JSON file that declares what AWS resources you want CloudFormation to create.

Analogy: The blueprint an architect hands to a contractor — it describes exactly what to build, not how to build it step by step.

5. What are resources?
-> Resources are the actual AWS infrastructure components you want CloudFormation to create — EC2 instances, VPCs, Security Groups, RDS databases, etc.

```
yaml:
Resources:
  MyEC2Instance:
    Type: AWS::EC2::Instance
    Properties:
      InstanceType: t2.micro
      ImageId: ami-0abcdef1234567890
```
Every resource has a Type (what it is) and Properties (how it's configured). This is the core of every CloudFormation template.

6. What are parameters?
-> Parameters are inputs you define in the template that allow users to customize values at deploy time — without changing the template itself.

```
yaml:
Parameters:
  InstanceType:
    Type: String
    Default: t2.micro
    AllowedValues:
      - t2.micro
      - t2.small
    Description: EC2 instance size
```
You reference it in Resources using !Ref InstanceType. This makes one template reusable across dev, staging, and production by just changing the inputs.

7. What are Outputs?
-> Outputs are values that CloudFormation returns after a stack is successfully created — things you or other stacks might need to know.

```
yaml:
Outputs:
  InstancePublicIP:
    Description: Public IP of the EC2 instance
    Value: !GetAtt MyEC2Instance.PublicIp
```
Common outputs: public IP addresses, DNS names, resource IDs. Other stacks can also import these outputs — this is how large infrastructures are split across multiple templates that reference each other.

8. Why YAML over JSON?
-> Both work in CloudFormation. YAML is preferred because:

				YAML							JSON
Comments			✅ Supported (#)					❌ Not supported
Readability			Cleaner, less punctuation				Brackets and quotes everywhere
Human errors			Less likely						Easy to miss a comma or bracket
Industry standard for IaC	✅ Terraform, Kubernetes, GitHub Actions all use YAML				Less common in IaC tooling

examples-
- YAML: InstanceType: t2.micro
- JSON: { "InstanceType": "t2.micro" }

---
