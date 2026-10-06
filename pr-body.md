## What

Adds a new applet: **Awake Timer** (`awake@enisn`) — a minimalist panel applet that keeps the computer awake for a chosen number of hours (no screen blank, no lock screen, no display sleep, no idle suspend), then automatically restores the user's original power settings.

![Applet menu and panel countdown](https://github.com/user-attachments/assets/cdaa2012-af2b-4c55-8a90-da5af620e3e5)

## Why

Cinnamon's power settings are all-or-nothing: either your session blanks and locks on a schedule, or you change several settings by hand every time you need the machine to stay on — and you have to remember to revert them. Awake Timer does this temporarily and safely: it snapshots the current settings, disables every idle action for the chosen duration, and restores the snapshot when time is up (or on demand).

## Details

- Presets (1/2/3/5/8 hours), custom duration entry, live countdown in the panel, "Turn off now"
- Auto-restore is crash-proof: state is kept in `~/.cache/awake-override/state.json` and a transient systemd **user** timer runs the restore even if Cinnamon is restarted; if the machine was powered off at the deadline, the applet restores on its next load
- Only idle actions are touched (`idle-delay`, `lock-enabled`, `sleep-display-ac/battery`, `sleep-inactive-ac/battery-type`) — manual suspend and the lid switch are unaffected
- No root, no daemon, no external dependencies
- Written entirely by me, MIT licensed; standalone repo with README and installer: https://github.com/enisn/cinnamon-awake-applet
- Developed and tested on Linux Mint 22.3 (Cinnamon 6.4); uses only `St`, `PopupMenu`, `GLib`/`Gio`, `Mainloop`

Folder follows the current layout: `files/awake@enisn/` (applet.js, metadata.json), `info.json`, `README.md`, `screenshot.png`.
