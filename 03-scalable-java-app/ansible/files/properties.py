import boto3
import json

secrets_client = boto3.client('secretsmanager')

secret_name = "rds!db-8f23e7a9-e9f8-4b50-a059-f0e310e18134"

endpoint_port= "database-1.cvgrek461osh.us-west-2.rds.amazonaws.com:3306"

response = secrets_client.get_secret_value(SecretId=secret_name)

secret_value = response['SecretString']

database_details = json.loads(secret_value)

file_path = "/home/ubuntu/application.properties"

with open(file_path, 'r') as f:
    file_contents = f.read()

file_contents = file_contents.replace("spring.datasource.url=jdbc:mysql://localhost:3306/petclinic", f"spring.datasource.url={(endpoint_port)}")
file_contents = file_contents.replace("spring.datasource.username=petclinic", f"spring.datasource.username={database_details['username']}")
file_contents = file_contents.replace("spring.datasource.password=petclinic", f"spring.datasource.password={database_details['password']}")


with open(file_path, 'w') as f:
    f.write(file_contents)
