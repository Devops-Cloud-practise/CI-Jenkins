Steps to set up Jenkins Pipeline
First run vagrant file and provision all the machines ...I have used centos-sync-fix box which customised to add necessary Kernel dev packages to avoid mounting errors.

vagrant up ....( In case you get mounting errors you can coomet this line #config.vbguest.auto_update = false and apply vagrant reload which will make sure we have latest guest packages installed ....this also assumes that we must have installed guest plugins on Vagrant host...

$ vagrant.exe plugin list
vagrant-aws (0.7.2)
vagrant-share (1.1.9, system)
vagrant-vbguest (0.15.1)

Once all VMs are set up ssh to ansible machines and strt running playbooks ---
---------------------------------------------------------------------------------------------------------------
                  Setting Public key Auth for ansible to conect to hosts without password 
---------------------------------------------------------------------------------------------------------------
Note: Before running these playbooks make sure you have followed the steps given in link https://www.hashbangcode.com/article/ansible-ssh-setup-playbook
            
a. ansible-playbook -e "ansible_user=vagrant" --ask-vault-pass -bk --extra-vars "rmt_host=jenkins" /vagrant/p
lay_books/ansible_ssh_auto_set_up.yaml

b. ansible-playbook -e "ansible_user=vagrant" --ask-vault-pass -bk --extra-vars "rmt_host=jfrog" /vagrant/pla
y_books/ansible_ssh_auto_set_up.yaml

c. ansible-playbook -e "ansible_user=vagrant" --ask-vault-pass -bk --extra-vars "rmt_host=sonarcube" /vagrant
/play_books/ansible_ssh_auto_set_up.yaml

d. ansible-playbook -e "ansible_user=vagrant" --ask-vault-pass -bk --extra-vars "rmt_host=appserver" /vagrant
/play_books/ansible_ssh_auto_set_up.yaml

e. ansible-playbook --ask-vault-pass -b --extra-vars "rmt_host=appserver" /vagrant/play_books/install_jenkins
_Maven_Ansible_main.yaml
   
 rmt_host variable values must match from hosts file groups ...these in turns looks for var file ( encrypted using vault to get necessayr properties related to diff hosts...) you can refer under var/var2.yml which is exact copy of encrpted var.yaml.. make sure you diff passwords as i have used generic passwords ...
 **********************************************End setting up pub key auth***************************************************
 Now run one by one playbooks to provision the hosts ..
 
 ---------------------------------------------------------------------------------------------------------------
                  Provisioning Hosts
---------------------------------------------------------------------------------------------------------------

a. ansible-playbook --ask-vault-pass -b --extra-vars "rmt_host=jenkins" /vagrant/play_books/install_jenkins_M
aven_Ansible_main.yaml

b. ansible-playbook --ask-vault-pass -b --extra-vars "rmt_host=sonarcube" /vagrant/play_books/install_sonarcu
be_main.yaml

c. ansible-playbook --ask-vault-pass -b --extra-vars "rmt_host=jfrog" /vagrant/play_books/install_jfrog_Artif
actory_main.yaml

d. ansible-playbook --ask-vault-pass -b --extra-vars "rmt_host=appserver" /vagrant/play_books/setup_App_Serve

   
