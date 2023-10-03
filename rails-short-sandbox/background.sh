# Fail fast on errors.
set -e

# Redirect output of the current script.
exec > /opt/background.log 2>&1

# Say what's happening for diagnostic purposes, shown by foreground.sh.
PS4='+ Running: '
set -x

# This ruby image doesn't run everything in a shell that has RVM configured.
# So load it as if we were starting from a login shell:
. /etc/profile

# Assume Rails 3.2.2 is installed.

# The `--no-document` skips a slow documentation build process.
gem install rails --no-document  # ~10 sec

apt-get update -q
DEBIAN_FRONTEND=noninteractive apt-get install -yq tzdata  # ~6 sec

echo "Rails is installed!"
