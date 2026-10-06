# Awake Timer

Keep the computer awake (no screen blank, no lock screen, no display sleep, no idle suspend) for a chosen number of hours, then automatically restore your normal power settings.

- Panel shows ☕ when idle and ☕ 4:32-style countdown while active
- Presets: 1 / 2 / 3 / 5 / 8 hours, plus a custom duration
- "Turn off now" restores your settings immediately
- Restore is crash-proof: a systemd user timer runs it even if Cinnamon restarts, and if the machine was powered off at the deadline, the applet restores on the next login
- Manual suspend and the laptop lid switch are never touched — only idle actions

Source and install instructions: https://github.com/enisn/cinnamon-awake-applet
