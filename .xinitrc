#!/bin/sh

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ] && [ -n "$XDG_RUNTIME_DIR" ] && \
    [ "$XDG_RUNTIME_DIR" = "/run/user/`id -u`" ] && \
    [ -S "$XDG_RUNTIME_DIR/bus" ]; then
  # We are under systemd-logind or something remarkably similar, and
  # a user-session socket has already been set up.
  #
  # Be nice to non-libdbus, non-sd-bus implementations by using
  # that as the session bus address in the environment. The check for
  # XDG_RUNTIME_DIR = "/run/user/`id -u`" is because we know that
  # form of the address, from systemd-logind, doesn't need escaping,
  # whereas arbitrary addresses might.
  DBUS_SESSION_BUS_ADDRESS="unix:path=$XDG_RUNTIME_DIR/bus"
  export DBUS_SESSION_BUS_ADDRESS
fi

if [ -x "/usr/bin/dbus-update-activation-environment" ]; then
  # tell dbus-daemon --session (and systemd --user, if running)
  # to put a minimal subset of the Xsession's environment in activated
  # services' environments
  dbus-update-activation-environment --verbose --systemd \
    DBUS_SESSION_BUS_ADDRESS DISPLAY XAUTHORITY
fi

exec i3
