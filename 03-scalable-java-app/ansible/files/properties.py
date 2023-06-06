import boto3
import json

region = 'us-west-2'
parameter_store = '/dev/petclinic/rds_endpoint'
secret_name = "/dev/petclinic/db"
file_path = "/opt/application.properties"
consul_file_path = "/etc/consul.d/config.hcl"

ssm = boto3.client('ssm', region_name=region)

rds_endpoint = ssm.get_parameter(Name=parameter_store)['Parameter']['Value']

secrets_client = boto3.client('secretsmanager')

response = secrets_client.get_secret_value(SecretId=secret_name)

secret_value = response['SecretString']

database_details = json.loads(secret_value)

with open(file_path, 'r') as f:
    file_contents = f.read()

with open(consul_file_path, 'r') as f:
    consul_file = f.read()

file_contents = file_contents.replace("spring.datasource.url=jdbc:mysql://localhost:3306/petclinic", f"spring.datasource.url={rds_endpoint}")
file_contents = file_contents.replace("spring.datasource.username=petclinic", f"spring.datasource.username={database_details['username']}")
file_contents = file_contents.replace("spring.datasource.password=petclinic", f"spring.datasource.password={database_details['password']}")
consul_file = consul_file.replace("encrypt = \"{{ encrypt }}\"", f"encrypt={database_details['consul']}")


with open(file_path, 'w') as f:
    f.write(file_contents)

with open(consul_file_path, 'a') as f:
    f.write(consul_file)
