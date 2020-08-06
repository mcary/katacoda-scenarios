Running containers in privileged mode gives them the ability to run
arbitrary commands on the host.  Make sure you are not relying on the
container to contain processes run in a privileged container.

If you must give a container some privileges, give the container as narrow
a set of capabilities as possible, using the docker ["--cap-add" and
"--cap-drop"|https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities]
options.

These steps are based on [Escaping Docker Privileged
Containers|https://medium.com/better-programming/escaping-docker-privileged-containers-a7ae7d17f5a1]
by Vickie Li.
