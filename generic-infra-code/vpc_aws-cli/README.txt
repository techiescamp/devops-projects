#create VPC, Subnets, Route tables, Security groups and Instances using AWS CLI
#step by step 

Prerequisites 
 
#You have the aws account and You can sign up and setting it up.
# You can set up configure to awscli in your machine.

If you have those two set up, then you’re good to go. Now, let’s get started 

Step 1 — Create a VPC 
To create a VPC, open up your terminal and enter the following command:

#aws ec2 create-vpc --cidr-block 10.0.0.0/16

You can decide to add a tag to your VPC to easily identify it once you start having multiple VPCs, to do this, run the command below:

#aws ec2 create-tags --resources <vpc-id> --tags Key=<tag-key>,Value=<tag-value> 
 
EXPLAIN:
 
--tags Key=<tag-key>,Value=<tag-value>: Specify the tags you want to associate with the resource
 Replace <tag-key> with the desired tag key (e.g., “Name”) and <tag-value> with the corresponding value (e.g., “MyVPC”).

show the vpcs, run the command below:

#aws ec2 describe-vpcs 

Step 2 - Create public and private subnets
To create the public subnet, run the following command:

#aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 10.0.1.0/24

Again, your terminal should respond with information about the subnet you’ve just made.
Pick out the subnet id and add a tag to it just as we’ve done for the VPC itself:

#aws ec2 create-tags --resources <subnet-id> --tags Key=<tag-key>,Value=<tag-value>

And for the private subnet:

#aws ec2 create-subnet --vpc-id <vpc-id> --cidr-block 10.0.2.0/24

And for the tag:

aws ec2 create-tags --resources <subnet-id> --tags Key=<tag-key>,Value=<tag-value> 

show the subnets, run the command below:

#aws ec2 describe-subnets  

Step 3 - Create internet gateway for the VPC
To create an internet gateway, use the following command:

#aws ec2 create-internet-gateway

You can add a tag to the internet gateway:

#aws ec2 create-tags --resources <internet-gateway-id> --tags Key=<tag-key>,Value=<tag-value> 

Then attach the internet gateway to the VPC:

#aws ec2 attach-internet-gateway --internet-gateway-id <internet-gateway-id> --vpc-id <vpc-id>

Step 4 - Create an elastic IP address for NAT gateway
Run the following command to create an elastic IP address:

#aws ec2 allocate-address --domain vpc

Step 5 - Create a NAT gateway 
To create a NAT gateway, use the following command: 

#aws ec2 create-nat-gateway --subnet-id <public-subnet-id> --allocation-id <elastic-ip-address-id>

Then add a tag to the NAT gateway:

#aws ec2 create-tags --resources <nat-gateway-id> --tags Key=<tag-key>,Value=<tag-value>

Step 6 - Create a route table for each subnet
To create a route table, use the following command:(public)

#aws ec2 create-route-table --vpc-id <vpc-id>

You can tag the first route table as public:

#aws ec2 create-tags --resources <first-route-table-id> --tags Key=<tag-key>,Value=<tag-value>

To create a route table, use the following command:(private)

#aws ec2 create-route-table --vpc-id <vpc-id>

Then tag the second route table as private:

#aws ec2 create-tags --resources <second-route-table-id> --tags Key=<tag-key>,Value=<tag-value>

Step 7 - Create routes
We’ll first attach the route table created for the public subnet to the internet gateway.
The route matches all IPv4 traffic (0.0.0.0/0) and routes it to the specified Internet gateway.
use the following command:

#aws ec2 create-route --route-table-id <public-route-table-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <internet-gateway-id>

Then attach the route table created for the private subnet to the NAT gateway. 
The route matches all IPv4 traffic (0.0.0.0/0) and routes it to the specified NAT gateway.
use the following command:

#aws ec2 create-route --route-table-id <private-route-table-id> --destination-cidr-block 0.0.0.0/0 --gateway-id <nat-gateway-id>

Step 8 - Associate route table to subnet
Associate the public route table to the public subnet.
use the following command:

#aws ec2 associate-route-table --route-table-id <public-route-table-id> --subnet-id <public-subnet-id>

Associate the private route table to the private subnet.
use the following command:

#aws ec2 associate-route-table --route-table-id <private-route-table-id> --subnet-id <private-subnet-id>

Step 9 - Create a security groups for the VPC
To create a security group with the following command:(Public)

#aws ec2 create-security-group --group-name <security-group-name> --description "<description>" --vpc-id <vpc-id>

Add a tag to the public security group:

#aws ec2 create-tags --resources <security-group-id> --tags Key=<tag-key>,Value=<tag-value>

Then we specify rules for the security group created. port 80 allows inbound HTTP access from all IPv4 addresses 
and port 22 allows inbound SSH access to instances from IPv4 IP addresses in your network.

#aws ec2 authorize-security-group-ingress --group-id <security-group-id> --protocol tcp --port 22 --cidr 0.0.0.0/0

#aws ec2 authorize-security-group-ingress --group-id <security-group-id> --protocol tcp --port 80 --cidr 0.0.0.0/0

To create a security group with the following command:(PRIVATE)

#aws ec2 create-security-group --group-name <security-group-name> --description "<description>" --vpc-id <vpc-id>

Add a tag to the private security group:

#aws ec2 create-tags --resources <security-group-id> --tags Key=<tag-key>,Value=<tag-value>

Create Two Security Groups One for Private [Edit the Inbound rules with RDP, HTTP/HTTPS, SSH and map 10.0.1.0/24 of Public in the source] 

#aws ec2 authorize-security-group-ingress --group-id <security-group-id> --protocol tcp --port 22 --cidr 10.0.1.0/24


Step 10 - Create Key-pair
use the following command:

#aws ec2 create-key-pair --key-name cli-keyPair --query 'KeyMaterial' --output text > cli-keyPair.pem


Step 11 - Run an instance
Create Two EC2s one in public and one in private subnets with proper Security Groups.
Use the following command:(public)

#aws ec2 run-instances --image-id ami-0533f2ba8a1995cf9 --instance-type t2.micro --count 1 --subnet-id <public-subnet-id> \
--security-group-ids <public security-group-id> --associate-public-ip-address --key-name cli-keyPair 

Add a tag to the instance created:

#aws ec2 create-tags --resources <instance-id> --tags Key=<tag-key>,Value=<tag-value>

Use the following command:(private)

#aws ec2 run-instances --image-id ami-0533f2ba8a1995cf9 --instance-type t2.micro --count 1 --subnet-id <private-subnet-id> \
--security-group-ids <private security-group-id>  --key-name cli-keyPair 

Add a tag to the instance created:

#aws ec2 create-tags --resources <instance-id> --tags Key=<tag-key>,Value=<tag-value>

Login into Public ec2 and check the internet connection and now login into the Private EC2 and verify the connectivity and Internet facility
and check the ssh connection from othre ec2 to private ec2 ....So if you don't get the connection,vpc is no mistake.................its worked... 

