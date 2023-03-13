import configparser
import boto3
from botocore.exceptions import ClientError


def get_secret():

    secret_name = "rds!db-8f23e7a9-e9f8-4b50-a059-f0e310e18134"
    region_name = "us-west-2"
    
    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    db_credentials = get_secret_value_response['SecretString']

    PROPERTIES_FILE_NAME = "application.properties"

    config = configparser.ConfigParser()
    config.read(PROPERTIES_FILE_NAME)

    config['database']['url'] = db_credentials['url']
    config['database']['username'] = db_credentials['username']
    config['database']['password'] = db_credentials['password']

    with open(PROPERTIES_FILE_NAME, 'w') as configfile:
        config.write(configfile)                                                                                                                                                                                                        