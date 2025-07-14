#!/bin/bash

# Install Python 3 and pip
sudo yum install -y python3

# Install boto3 for AWS SDK interactions
pip3 install boto3

# Install PySpark
pip3 install pyspark

# Setup Bootstrap Logging
mkdir -p /var/log/emr-bootstrap
echo "Bootstrap completed at $(date)" > /var/log/emr-bootstrap/bootstrap.log

