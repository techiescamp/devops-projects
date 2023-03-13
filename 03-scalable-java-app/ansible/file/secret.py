import boto3
import json

# Define the Secrets Manager client
secrets_client = boto3.client('secretsmanager')

# Define the name of the secret containing the database details
secret_name = "rds!db-8f23e7a9-e9f8-4b50-a059-f0e310e18134"

endpoint_port= "database-1.cvgrek461osh.us-west-2.rds.amazonaws.com:3306"

# Retrieve the secret value
response = secrets_client.get_secret_value(SecretId=secret_name)

# Parse the secret value as a JSON object
secret_value = response['SecretString']

# Parse the JSON object to retrieve the database details
database_details = json.loads(secret_value)

# Define the path to the application.properties file
file_path = "/opt/application.properties"

# Open the file in read mode
with open(file_path, 'r') as f:
    # Read the contents of the file into a string
    file_contents = f.read()

# Replace the database details in the string
file_contents = file_contents.replace("spring.datasource.url=jdbc:mysql://localhost:3306/petclinic", f"spring.datasource.url={(endpoint_port)}")
file_contents = file_contents.replace("spring.datasource.username=petclinic", f"spring.datasource.username={database_details['username']}")
file_contents = file_contents.replace("spring.datasource.password=petclinic", f"spring.datasource.password={database_details['password']}")

# Open the file in write mode
with open(file_path, 'w') as f:
    # Write the updated contents of the file to the file
    f.write(file_contents)
