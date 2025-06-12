import boto3
import json
import sys

client = boto3.client('ssm', region_name='us-west-2')
response = client.get_parameter(Name=sys.argv[1], WithDecryption=True)
print(response['Parameter']['Value'])
