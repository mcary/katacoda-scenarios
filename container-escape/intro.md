## Overview

In this scenario, we demonstrate how to escape a privileged Docker
container to run arbitrary commands on the host.

Docker containers are generally used to isolate software software and its
dependencies running inside.  However, some people rely on this containment
without understanding its limitations.

In this scenario, we'll illustrate how a container that is run with the
"--privileged" flag can break out of its container using the cgroups
release_agent feature.

(Even without the "--privileged" flag, there may be other ways that
software running in a container could break out of it.)

## Prerequisites

This scenario assumes that you are comfortable with:

* Understanding and running shell commands
* Basic docker concepts such as images and containers

