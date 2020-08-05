## Run a privileged container

Now that we can run containers, let's run a _privileged_ container.  A privileged container has root privileges on the host, but it still runs inside it's own filesystem.

Add "--privileged" to the "Hello World" command above to run it in priviledged
mode:

```
docker run -it --privileged ubuntu:18.04 echo "Hello World!"
```{{execute}}

This command still outputs the same result:

> Hello World!

## Detecting whether a container is privileged

When trying to break out of a privileged container, it's useful to know whether the container is privileged.  One easy way to determine that is to run a command that requires privilege.  For example, this command requires the NET_ADMIN capability:

```
ip link add dummy0 type dummy
```

### Create an image with the "ip" command installed

To install the ip command, we need to create an image that contains it.  Normally this would be done with a Dockerfile and the `docker build` command, but in this case, it's most expedient to use `docker commit`:

```
docker run -it --name tmp-container ubuntu:18.04 bash -c '
  apt-get update
  apt-get install -y iproute2
'
```{{execute}}

Then create an image from that container with this command:

```
docker commit tmp-container ubuntu-with-ip
```{{execute}}

We won't go into details about how those commands work, as it is beyond the
scope of this scenario.

### Run the "ip" command

Now, using the "ubuntu-with-ip" image created above...

When run without privileged mode, the "ip" command fails:

```
docker run -it ubuntu-with-ip   ip link add dummy0 type dummy
```{{execute}}

> RTNETLINK answers: Operation not permitted

However, when run in privileged mode, the "ip" command succeeds, as evidenced by no output:

```
docker run -it --privileged ubuntu-with-ip   ip link add dummy0 type dummy
```{{execute}}

You may clean up after the previous command with this one:

```
ip link delete dummy0
```{{execute}}

(This could alternatively be run in a privileged container.)
