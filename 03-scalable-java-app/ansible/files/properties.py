import boto3
import json

def update_configurations():
    region = 'us-west-2'
    parameter_store = '/dev/petclinic/rds_endpoint'
    secret_name = "/dev/petclinic/db"
    application_properties_path = "/opt/application.properties"
    consul_config_path = "/etc/consul.d/config.hcl"

    ssm_client = boto3.client('ssm', region_name=region)
    secrets_client = boto3.client('secretsmanager', region_name=region)

    rds_endpoint = ssm_client.get_parameter(Name=parameter_store)['Parameter']['Value']
    database_details = json.loads(secrets_client.get_secret_value(SecretId=secret_name)['SecretString'])

    with open(application_properties_path, 'r') as file:
        application_file_contents = file.read()

    with open(consul_config_path, 'r') as file:
        consul_file_contents = file.read()

    application_file_contents = application_file_contents.replace("spring.datasource.url=jdbc:mysql://localhost:3306/petclinic", f"spring.datasource.url={rds_endpoint}")
    application_file_contents = application_file_contents.replace("spring.datasource.username=petclinic", f"spring.datasource.username={database_details['username']}")
    application_file_contents = application_file_contents.replace("spring.datasource.password=petclinic", f"spring.datasource.password={database_details['password']}")

    consul_file_contents = consul_file_contents.replace("encrypt = \"{{ encrypt }}\"", f"encrypt={database_details['consul']}")

    with open(application_properties_path, 'w') as file:
        file.write(application_file_contents)

    with open(consul_config_path, 'a') as file:
        file.write(consul_file_contents)

if __name__ == "__main__":
    update_configurations()
