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

# Assume Ruby 3.2.2 is installed.

# The `--no-document` skips a slow documentation build process.
gem install rails --no-document  # ~10 sec

apt-get update -q
DEBIAN_FRONTEND=noninteractive apt-get install -yq tzdata  # ~6 sec

rails new example-app # ~25 sec

cd example-app
git add .
git commit -m 'Pristine Rails application'

rails db:migrate &&
  git add db/ &&
  git commit -m 'Generate initial schema'

echo "Rails is installed!"
