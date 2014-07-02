from __future__ import with_statement
from fabric.api import *
from fabric.contrib.console import confirm

### Fabric Builtin Variables

#env.hosts = ['localhost','127.0.0.1']
env.hosts = 'localhost'
disable_known_hosts = 'true'
#env.roledefs['webservers'] = ['www1', 'www2', 'www3']
#env.roledefs = {
#    'web': ['www1', 'www2', 'www3'],
#    'dns': ['ns1', 'ns2']
#}

### Use variables

fakedir = '/var/tmp'
#fakedir = '/this/directory/does/not/exist'
	

### Functions
### Invoked from cli: fab function

def hello():
    print("Hello world!")

def uname():
    run('uname -s')

def uname2():
    local("uname -a")

def query_puppet():
    run("uname -a")

# error handling example

def error_handling():
    with settings(warn_only=True):
	if local("ls -ld %s" % fakedir).failed:
	    print("eeeerrorr")
            local("ls -ld %s" % fakedir).succeeded

# Define routines to be only run locally from below this point ( where we place the @hosts decorator... )
@hosts('localhost')
def generate_ec2_running_instances_full_list():
    env.hosts = local("../aws/public_dns_running_instances.sh")
    print env.hosts
