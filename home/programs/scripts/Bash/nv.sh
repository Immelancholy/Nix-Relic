#!/usr/bin/env bash

# Use the Kitty socket name to keep it unique per Kitty window
sock_basename="$(basename "${KITTY_LISTEN_ON#unix:}" 2>/dev/null)"
count_file="/run/user/1000/kitty_padding_count_${sock_basename}"

# We'll also create a lock file so multiple parallel nvim starts
# won't clobber each other's reference count.
lock_file="/run/user/1000/kitty_padding_count_${sock_basename}.lock"

increase_padding_refcount() {
  exec 9>"$lock_file"
  flock 9            # Acquire exclusive lock

  # Read current count (0 if no file)
  if [[ -f "$count_file" ]]; then
    read -r count < "$count_file"
  else
    count=0
  fi

  # If count=0 => we're the *first* nvim in this Kitty window
  if [[ "$count" -eq 0 ]]; then
    kitty @ --to "$KITTY_LISTEN_ON" set-spacing padding=0
  fi

  # Increase count
  count=$((count+1))
  echo "$count" > "$count_file"

  flock -u 9         # Release lock
}

decrease_padding_refcount() {
  exec 9>"$lock_file"
  flock 9            # Acquire exclusive lock

  # Read current count (assume 1 if no file for safety)
  if [[ -f "$count_file" ]]; then
    read -r count < "$count_file"
  else
    count=1
  fi

  # Decrease count
  count=$((count-1))
  echo "$count" > "$count_file"

  # If count=0 => no more nvim sessions => restore
  if [[ "$count" -eq 0 ]]; then
    kitty @ --to "$KITTY_LISTEN_ON" set-spacing padding=default
  fi

  flock -u 9         # Release lock
}

if [[ -n "$KITTY_LISTEN_ON" ]]; then
  increase_padding_refcount
fi

nvim "$@"

if [[ -n "$KITTY_LISTEN_ON" ]]; then
  decrease_padding_refcount
fi
