Thanks for the scan! All three findings are addressed in e004d4d88:

- **sync_file_get_contents / sync_file_test** — `_loadState()` now uses `Gio.File.load_contents_async()` (with a `_alive` guard for the applet being removed before the callback fires) and the `GLib.file_test()` pre-check is gone; a missing state file is simply handled as an error from the async load.
- **hardcoded_cache_dir** — the state directory is now `GLib.get_user_cache_dir() + "/awake-override"`, respecting `XDG_CACHE_HOME`.

Version bumped to 1.2.0. Happy to adjust anything else reviewers spot.
