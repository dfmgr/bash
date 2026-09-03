# TODO.AI.md

Deferred items found during the shellcheck/audit pass, deliberately
left unfixed pending user sign-off.

- etc/prompt/01-powerline.win: file is a verbatim copy of the
  Linux/Darwin-branching prompt logic in 01-powerline.bash with
  nothing actually Windows/Git-Bash-specific. Restructuring it to be
  Windows-specific (or merging it with 01-powerline.bash) is a larger
  design change than a shellcheck/bugfix pass and needs user
  direction before proceeding.
- etc/functions/setv.bash: file carries a GPLv3 license header
  (vendored from upstream author psachin) while the rest of this repo
  uses WTFPL. This is third-party vendored code; the header should not
  be changed without the user confirming how to handle the license
  mismatch (keep as-is with attribution, relicense, or drop the file).
