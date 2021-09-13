[AWX] it the open-source upstream project from which RedHat [Ansible Tower]
is dervied.  It puts a [Jenkins]-like web UI atop [Ansible], allowing
delegation and tracking of Ansible playbook invocation, composition into
workflows, and credential management.

[AWX]: https://github.com/ansible/awx
[Ansible Tower]: https://www.ansible.com/products/tower
[Jenkins]: https://www.jenkins.io/
[Ansible]: https://www.ansible.com/

This scenario installs AWX (using [Ansible Operator] for Kubernetes) so you
can poke at a running instance.

[Ansible Operator]: https://github.com/ansible/awx-operator
