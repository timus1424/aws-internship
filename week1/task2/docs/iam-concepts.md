What is an IAM User? -> An IAM User is a digital identity created within an AWS account to represent a person or application. By itself, the user has no permissions until policies are attached directly or inherited through groups. 
Why do IAM Groups exist? ->Say we need to add 20 or 200 users, it doesn't seem feasible to manually define the permissions or access for each user. So we define it for one group- define policies for that group explicitly, then add the needed members to that group, who get access to all the policies of that group. 
What do IAM Policies do? -> IAM policies, defined the powers and functions of the IAM users. These policies are like job profiles, which tell the user about the jobs, tasks, roles/powers, etc. These policies are normally json files. Think of them as rule books. Example:  JSON Allow: Read S3 List S3  Deny: Delete Objects Upload Objects 
What do you think an IAM Role is? ->A Role is a set of permissions that someone or something can temporarily assume.

The Four Concepts Together:

		     Root User
			 │
               Creates Users & Groups
                         │
        ┌────────────────┴───────────────┐
        │                     	         │
    IAM User                         IAM Group
        │                     	         │
        └──────────────┬─────────────────┘
            	       │
    	           IAM Policy
    	       (Permission Rules)
                       │
	        Allows / Denies
	               │
     	          AWS Services


IAM Role
↓
Temporary permissions assumed
by users, applications, or AWS services.

# JSON - JavaScript Object Notation

{
    "Version": "2012-10-17",			—tells AWS the policy language version.
    "Statement": [				—Each rule is one statement.
        {
	"Effect": "Allow",			—only two values exist: Allow/Deny
            "Action": "s3:ListAllMyBuckets",	—translates too-> Service : Permission
            "Resource": "*"			— * means everything
        }
    ]
}

Internship requirement:
s3:ListAllMyBuckets
Not - PutObject, DeleteObject
In IAM, AWS follows implicit Deny
Therefore, Allowing only: ListAllMyBuckets, ListBucket 
Denies: PutObject, DeleteObject, CreateBucket, DeleteBucket.
——also called Principle of Least Privilege

Note: “s3:*" grants permission to perform all Amazon S3 actions on the specified resources, including listing buckets, creating buckets, uploading objects, downloading objects, deleting objects, modifying bucket configurations, and many other S3 operations.
