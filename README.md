README

## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Network Diagram](Diagrams/elk_diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the filebeat-playbook.yml and metricbeat-playbook.yml files may be used to install only certain pieces of it, such as Filebeat.

  - [ELK Playbook File](Ansible/elk-playbook.yml)
  - [FileBeat Playbook File](Ansible/filebeat-playbook.yml)
  - [MetricBeat Playbook File](Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.
- _What aspect of security do load balancers protect?_ 
Answer: load balancers protect availability (the A in CIA).
- _What is the advantage of a jump box?_
Answer: using a jump box limits the internal networks exposure to the public internet (only the jump box has an public IP).  It controls access to the other machines by allowing connctions from specific IP addresses only.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the log files and system metrics.
- _What does Filebeat watch for?_
Answer: Filebeat watches for files which have changed and then logs those changes.
- _What does Metricbeat record?_
Answer: Metricbeat records system-level metrics including CPU usage, memory, file system, disk IO, and network IO statistics.  In addition, it also records stats for running processes.

The configuration details of each machine may be found below.

| Name     | Function | IP Address | Operating System |
|----------|----------|------------|------------------|
| Jump Box | Gateway  | 10.0.0.1   | Linux            |
| Web-1    | Webserver| 10.0.0.5   | Linux            |
| Web-2    | Webserver| 10.0.0.6   | Linux        |
| Web-3    | Webserver| 10.0.0.7   | Linux            |
| Elk      | Elastic Search, Logstash and Kibana| 10.1.0.4   | Linux         |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
- 99.231.116.134

Machines within the network can only be accessed by the ansible container within the Jump Box.
- 10.0.0.5
- 10.0.0.6
- 10.0.0.7
- 10.1.0.4

A summary of the access policies in place can be found in the table below.

| Name     | Publicly Accessible | Allowed IP Addresses |
|----------|---------------------|----------------------|
| Jump Box | Yes              | 99.231.116.134         |
| Elk      | Yes              | 99.231.116.134         |
| Web-1    | No               | 10.0.0.4, 10.1.0.4     |
| Web-2    | No               | 10.0.0.4, 10.1.0.4     |
| Web-3    | No               | 10.0.0.4, 10.1.0.4     |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because the chance for human error is reduced.

The playbook implements the following tasks:
- Install Docker
- Install the Python Package Manager - Pip
- Install the Pip Docker module
- Increase virtual memory
- Download the ELK Docker container and launch it
- Enable Docker on boot

The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![docker ps output](Images/docker_ps_output.PNG)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- 10.0.0.5
- 10.0.0.6
- 10.0.0.7

We have installed the following Beats on these machines:
- Filebeat
- Metricbeat

These Beats allow us to collect the following information from each machine:
- Filebeat: collects changes to various files and system logs such as `/var/logs/syslog`.
- Metricbeat: collects system metrics such as CPU utlization.

### Using the Playbooks
In order to use the playbooks, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy elk-playbook.yml, filebeat-playbook.yml, and metricbeat-playbook.yml files to /etc/ansible/.
- Copy filebeat-config.yml and metricbeat-config.yml to /etc/ansible/files/.
- Update the /etc/ansible/hosts file to include the elk vm and all hosts metricbeat and filebeat should be installed on (webservers in the example)
`[webservers]
10.0.0.5 ansible_python_interpreter=/usr/bin/python3
10.0.0.6 ansible_python_interpreter=/usr/bin/python3
10.0.0.7 ansible_python_interpreter=/usr/bin/python3 
[elk]
10.1.0.4 ansible_python_interpreter=/usr/bin/python3`
- Run the elk playbook, and navigate to http://[your.ELK-VM.External.IP]:5601/app/kibana to check that the installation worked as expected.
- Finally run the filebeat and metricbeat playbooks, and navigate to the site above and check for beat data.

* * *
**Bonus: Commands**
To obtain the playbook(s) and update the files are required, do the following:
1. Install git and clone the repository (alternately you can manually download)
`apt-get update && apt-get install git
git clone https://github.com/alexfinlay/bootcamp-project1.git`
1. Copy the files to the appropriate directories
`cp elk-playbook.yml /etc/ansible/`
`cp filebeat-playbook.yml /etc/ansible/`
`cp metricbeat-playbook.yml /etc/ansible/`
`cp filebeat-config.yml /etc/ansible/files`
`cp elk-playbook.yml /etc/ansible/`
1. Update the ansible hosts file and add the applicable hosts
`vi /etc/ansible/hosts`
1. Edit the filebeat-config.yml and metricbeat-config.yml files and set the IP address of your ELK server in the following locations:

- Filebeat line #1106
- Filebeat line #1806
`vi /etc/ansible/files/filebeat-config.yml`

- Metricbeat line #62
- Metricbeat line #95
`vi /etc/ansible/files/metricbeat-config.yml`
1. Run the ELK playbook
`ansible-playbook /etc/ansible/elk-playbook.yml`
1. Browse to the Kibana site and confirm it's up and running.  http://[your.ELK-VM.External.IP]:5601/app/kibana
1. Run the filebeat playbook
`ansible-playbook /etc/ansible/elk-playbook.yml`
1. Run the metricbeat playbook
`ansible-playbook /etc/ansible/metricbeat-playbook.yml`
* * *
------------------------------------------------------------------
## Interview Questions