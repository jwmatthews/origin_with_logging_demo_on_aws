# Logging Demo in Origin with EC-2

A collection of Ansible playbooks to spin up an EC-2 instance and install Origin with logging enabled

### Overview
These playbooks will:
  * Create a public VPC if it does not exist
  * Create a security group if it does not exist
  * Create an instance with a specific Name if does not exist
  * Associate an elastic ip to instance
  * Configure a hostname with elastic ip through Route53
  * Setup Origin through `oc cluster up --logging` to enable logging

### Pre-Reqs
  * Ansible needs to be installed so its source code is available to Python.
    * Check to see if Ansible modules are available to Python
            $ python -c "import ansible;print(ansible.__version__)"
            2.2.2.0
    * MacOS requires Ansible to be installed from `pip` and not `brew`
          $ python -c "import ansible;print(ansible.__version__)"
          Traceback (most recent call last):
          File "<string>", line 1, in <module>
          ImportError: No module named ansible

          brew uninstall ansible
          pip install ansible

          $ python -c "import ansible;print(ansible.__version__)"
          2.2.2.0
  * Install python dependencies (This is needed for python2. Use pip2 if using python3)
     * `pip install boto boto3 six`
  * Configure a SSH Key in your AWS EC-2 account for the given region
  * Create a hosted zone in Route53
  * Set these environment variables:
    * AWS_ACCESS_KEY_ID
    * AWS_SECRET_ACCESS_KEY
    * AWS_SSH_PRIV_KEY_PATH  - Path to your private ssh key to use for the ec2 instances

### Execute
  * `cd ec2`
  * Edit the variables file `ec2/common_vars`
    * Update:
      * AWS_SSH_KEY_NAME="splice"
      * TARGET_DNS_ZONE="ec2.dog8code.com"
        * Needs to match a hosted zone entry in your Route53 account, we will create a subdomain under it for the ec2 instance
  * `./run_create_infrastructure.sh`
    * Creates our infrastructure in ec2 if it doesn't exist
  * `./run_setup_environment.sh`
    * Sets up OpenShift
  * In Web Browser
    * Visit: `https://{{ openshift_hostname }}:8443`
      * Where username is the value of `whoami` when you launched `run_setup_environment.sh`
      * Logging URL:     https://kibana-logging.{{ openshift_hostname }}

# Cleanup

To terminate the ec2 instance and cleanup the associated EBS volumes run the below
  * `cd ec2`
  * `./terminate_instance.sh`

To reset the ec2 instance back to clean origin and deployment of ASB and Service Catalog run the below
  * `cd ec2`
  * `./reset_environment.sh`



### Tested with
  * ansible 2.2.2.0 & 2.3.0.0
    * Problems were seen using ansible 2.0
