## Connect to Docker

Run this command to verify that you can access Docker.  You can click it to
have it run in the provided terminal window.

```
docker ps
```{{execute}}

You should see output like:
> CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES

If you see an error, something is wrong with the docker setup and you
should attempt to resolve it before continuing.

## Run a command in a container

Run a simple command inside a docker container to confirm that your
environment is working properly:

```
docker run -it ubuntu:18.04 echo "Hello World!"
```{{execute}}

This command will download the ubuntu:18.04 image if not present already,
which may take several seconds.  Then it will run the `echo` command inside
of a container created from that image.

At the end, it should output:

> Hello World!

## Detecting whether we are running in a container

When trying to escape a container, it is first useful to know whether we're
running inside of one.  To determine that, run this command:

```
cat /proc/1/cgroup
```{{execute}}

Notice the cgroup paths are "/".  This indicates we're not running inside
of a container.

By contrast, run the same command under docker:

```
docker run -it ubuntu:18.04 cat /proc/1/cgroup
```{{execute}}

The paths will have the form "/docker/..........".  This reveals that we
are running inside a container.
