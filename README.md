# ☕ Awake Timer — a Cinnamon applet

A minimalist Cinnamon panel applet that keeps your computer awake for a chosen number of hours — **no screen blanking, no lock screen, no display sleep, no automatic suspend** — then automatically restores your normal power settings.

| Panel | Meaning |
| --- | --- |
| ☕ | Awake mode is off |
| ☕ 4:32 | Awake, with the remaining time counting down |

Click the icon for a menu:

- **Presets:** 1 / 2 / 3 / 5 / 8 hours
- **Custom:** type any duration in hours (e.g. `1.5`) and press Enter
- **Turn off now:** restore your normal settings immediately
- Choosing a new duration while active simply restarts the countdown from now

## Why

Cinnamon's built-in power settings are all-or-nothing: either your session blanks and locks on a schedule, or you dig into *System Settings → Power* and *Screensaver* every time you need the machine to stay on for a download, a build, a remote session, or a presentation — and you have to remember to switch everything back.

Awake Timer does that for you, temporarily and safely: it snapshots your current settings, disables every idle action for the duration you pick, and restores the snapshot when time is up.

## How it works

While active, these settings are changed (and restored afterwards):

| gsettings key | During | After |
| --- | --- | --- |
| `org.cinnamon.desktop.session` → `idle-delay` | 0 (never blank) | *your value* |
| `org.cinnamon.desktop.screensaver` → `lock-enabled` | false | *your value* |
| `org.cinnamon.settings-daemon.plugins.power` → `sleep-display-ac` | 0 | *your value* |
| `org.cinnamon.settings-daemon.plugins.power` → `sleep-display-battery` | 0 | *your value* |
| `org.cinnamon.settings-daemon.plugins.power` → `sleep-inactive-ac-type` | `nothing` | *your value* |
| `org.cinnamon.settings-daemon.plugins.power` → `sleep-inactive-battery-type` | `nothing` | *your value* |

Reliability details:

- The snapshot and deadline live in `~/.cache/awake-override/state.json`.
- A transient **systemd user timer** (`awake-restore`) fires the restore even if Cinnamon crashes or is restarted mid-session.
- If the machine was powered off when the deadline passed, the timer is gone — so on its next load, the applet notices the expired state file and restores your settings.
- Extending the duration keeps the *original* snapshot, so nothing is lost when you chain sessions.
- Only idle actions are touched: manual suspend and the laptop lid switch behave exactly as before.
- No root, no daemon of its own, no dependencies beyond Cinnamon and systemd.

## Install

### From this repository

```bash
git clone https://github.com/enisn/cinnamon-awake-applet.git
cd cinnamon-awake-applet
./install.sh
```

Then open **System Settings → Applets → Awake Timer** and add it to a panel (or right-click the panel → *Applets*).

<details>
<summary>Manual install</summary>

```bash
cp -r awake@enisn ~/.local/share/cinnamon/applets/
```

…then add it from **System Settings → Applets**, or restart Cinnamon (Alt+F2 → `r`) if you enabled it from the command line instead.
</details>

### From the Cinnamon Spices catalog

Once accepted, search for **Awake Timer** in **System Settings → Applets → Download**.

## Uninstall

1. Remove the applet from your panel (right-click the applet → *Remove*), or System Settings → Applets.
2. Delete the files:

```bash
rm -rf ~/.local/share/cinnamon/applets/awake@enisn
```

If awake mode is active when you remove it, the systemd timer still restores your settings at the deadline. To restore immediately:

```bash
~/.cache/awake-override/restore.sh   # if present
```

## Compatibility

Developed and tested on **Linux Mint 22.3 (Cinnamon 6.x)**. It only uses `St`, `PopupMenu`, `GLib`/`Gio` and a systemd user timer, so it should work on any Cinnamon ≥ 5.4. It is desktop-friendly (AC settings) and laptop-friendly (battery suspend settings) alike.

## License

[MIT](LICENSE) © 2026 enisn
