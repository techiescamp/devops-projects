import boto3
import json
import sys

client = boto3.client('ssm', region_name='us-east-1')
response = client.get_parameter(Name=sys.argv[1], WithDecryption=True)
print(response['Parameter']['Value'])
