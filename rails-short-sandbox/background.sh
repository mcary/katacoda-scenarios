# Fail fast on errors.
set -e

exit

# Redirect output of the current script.
exec > /opt/background.log 2>&1

# Say what's happening for diagnostic purposes.
set -x

# Wait for vscode to start, else calling code-server will start a new
# server rather than opening a file in the existing server.
while ! [ -d /opt/.katacodacode/user-data/User/workspaceStorage/ ]; do
  date -Ins
  sleep 0.5
done

sleep 0.1 # Wait a bit more for safety.

# Open a file in the existing server.
/opt/vscode/bin/code-server example-app/src/App.js
