{
  clear
  let 'i = 1'
  while ! grep -q '^Rails is installed!' /opt/background.log 2> /dev/null; do
    status="$(grep '^+++ Running: ' /opt/background.log 2> /dev/null |
      tail -n 1 | sed 's/^+++ Running: \(command \)\?/Running: /')"
    if [ ${#status} -gt 40 ]; then
      status="$(echo "$status" | cut -c 1-37)..."
    fi
    ellip="$(echo ............... | sed 's/./o/'$i)"
    printf '\rInstalling Rails%s  %-40s' "$ellip" "$status"
    let 'i = i % 20 + 1'
    sleep 0.1
  done
  export LESS="${LESS}R" # Show color git diffs better
  clear &&
    echo 'Rails is installed.'
}

cd example-app
