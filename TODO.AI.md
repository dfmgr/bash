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
- completions/fnm.bash: vendor-generated output (from `fnm completions
  --shell bash`, i.e. Rust clap_complete), carrying ~30 SC2207
  (unquoted COMPREPLY=($(compgen ...))) warnings plus one SC2034
  (unused `cmds`). Matches the same generated-file style already left
  untouched elsewhere in this repo (etc/post/fnm.bash); hand-editing
  vendored output would just be overwritten on the next `fnm
  completions` regeneration. Left as-is.
- completions/*.bash, completions/_noprompt_completion: none of the
  completion scripts carry a `VERSION=` assignment matching their
  `##@Version` header, unlike executable bin/ scripts. These are
  sourced-only library files with no `--version` dispatch to read the
  variable, so adding an unused `VERSION=` would be dead code with no
  behavior; left unchanged pending user direction on whether
  completions should carry the assignment anyway for stamp-consistency
  reasons.
