# AI.md — Project Specification

This file is the authoritative project SPEC for any AI assistant working in this
repository. Rules below are binding. Where a rule conflicts with a generic
default, this file wins.

**Portability.** Section 1 (Hard Rules) is written to be portable — it can be
dropped verbatim into any project and remain valid. Sections 2 (Inferred Rules)
and 3 (Project Specification) are the per-project content; replace them when
adapting this file to a different repository.

---

## 1. Hard Rules (explicit user directives, portable across projects)

These are non-negotiable. Violations must be reverted on sight.

1. **No UUOC (Useless Use Of Cat).**
   - Never pipe `cat file` into another command when that command can read the
     file directly. Use input redirection or pass the path as an argument.
   - Wrong: `cat foo.txt | grep bar`
   - Right: `grep bar foo.txt` or `grep bar < foo.txt`
   - The same principle applies to `echo | cmd` when a here-string (`<<<`) or
     here-doc (`<<`) is available in a bash context.

2. **Only use forked/external commands when absolutely necessary.**
   - Prefer shell builtins and bash-native constructs over spawning external
     processes. Every fork is a measurable cost; this repo's entire value
     proposition is fast shell startup.
   - Prefer `[[ ... ]]` over `test` / `[ ... ]` in bash files.
   - Prefer parameter expansion (`${var%.ext}`, `${var//a/b}`, `${var##*/}`)
     over calling `basename`, `dirname`, `sed`, `awk`, `cut`, `tr`.
   - Prefer `command -v foo` or `type -P foo` over `which foo`.
   - Prefer `read -ra arr <<< "$str"` over `echo "$str" | tr ...`.
   - Prefer bash arithmetic `$(( ... ))` over `expr`.
   - Prefer globbing (`shopt -s nullglob; for f in dir/*.bash`) over `ls | ...`
     or `find` when a plain glob suffices.
   - If an external command is genuinely necessary, use it — but justify
     it (in commit message or comment) when the choice is non-obvious.

3. **Bashisms policy (based on shebang):**
   - If the file has `#!/bin/bash`, `#!/usr/bin/env bash`, `# shellcheck shell=bash`,
     or a `.bash` extension → bashisms are REQUIRED where they improve clarity
     or performance. Do not hand-write POSIX-only code just to "be portable."
   - If the file has `#!/bin/sh`, no shebang, or a `.sh` extension → the file
     MUST be POSIX `sh`-compliant. No bashisms (no `[[ ]]`, no arrays, no
     `<<<`, no `${var,,}`, no `function` keyword, no `local` without caveat,
     no process substitution, no `read -a`, etc.). Verify with `sh -n` and,
     where possible, `checkbashisms`.
   - This matches the repo's existing split (`etc/functions/*.bash` = bash;
     any `.sh` = POSIX) and the README claim of "100% POSIX compliant for all
     `.sh` scripts."

4. **Always maintain `{project_dir}/.git/COMMIT_MESS` (GLOBAL RULE).**
   - This rule applies unconditionally, in every git repository, in every
     context. It is not project-specific.
   - Path: `.git/COMMIT_MESS` (inside the repo's `.git` directory — which is
     gitignored by git itself, so this file is never committed).
   - Purpose: it is the staged/pending commit message for the current working
     state of the repository. The user / tooling reads it when creating the
     next commit.
   - The file MUST reflect the ACTUAL current state of uncommitted changes.
     Whenever files in the repo are added, modified, or deleted, update
     `.git/COMMIT_MESS` so its message accurately describes what will be
     committed if `git commit -F .git/COMMIT_MESS` were run right now.
   - Do not leave stale messages from prior work. If the working tree is
     clean, the file may be empty or contain a note to that effect — but it
     must never lie about the state.
   - Never commit `.git/COMMIT_MESS` itself as a tracked file (it lives
     inside `.git/`, so this is automatic — do not move it out).

5. **Never guess or assume. When in doubt, ask.**
   - If the user's request is ambiguous, ask a clarifying question before
     acting. Do not invent intent.
   - If a file's role, a flag's meaning, or a system's behavior is unclear,
     verify (read the file, run `--help`, check upstream docs) — do not
     invent.
   - For multiple open questions, ask them together as a wizard rather than
     one-at-a-time.

6. **A question mark means a question, not a command.**
   - If the user's message ends with `?` (or is otherwise phrased as a
     question — "can you...", "should we...", "what about..."), it is a
     REQUEST FOR INFORMATION. Answer it. Do NOT execute, modify files, or
     take action.
   - Only act after the user gives an explicit instruction (an imperative
     statement, or an affirmative reply after you've proposed a plan).
   - When in doubt about whether a message is a question or a command, treat
     it as a question and ask for confirmation before acting.

7. **Always syntax-check shell scripts after editing.**
   - After editing a bash script (shebang `bash`, `.bash` extension, or
     `shellcheck shell=bash` directive), run `bash -n <file>`.
   - After editing a POSIX shell script (shebang `sh`, `.sh` extension, or no
     shebang), run `sh -n <file>`.
   - If the check fails, fix the script before moving on. Do not report the
     task complete with a failing syntax check.

8. **Run `shellcheck` if available; fix what it reports.**
   - After editing any shell script, check whether `shellcheck` is installed
     (`command -v shellcheck`). If yes, run it against the edited file(s).
   - Use the right dialect: `shellcheck --shell=bash <file>` for bash scripts,
     `shellcheck --shell=sh <file>` for POSIX scripts.
   - Fix findings caused by the edit (any finding that points at lines you
     changed, or that your changes introduced).
   - For pre-existing findings in lines you did NOT edit: report them to the
     user and offer to fix — but do NOT silently rewrite unrelated code
     (Rule 9 takes precedence).
   - If `shellcheck` is not installed, skip silently — do not attempt to
     install it, and do not treat its absence as an error.

9. **Preserve the user's existing formatting.**
   - Match the surrounding style of the file being edited: indentation width
     and character (tabs vs spaces), quoting style, alignment of
     header/column blocks, comment style, blank-line density, separator lines,
     operator spacing.
   - Do NOT reformat lines you were not asked to change. Do NOT "tidy up"
     unrelated whitespace, re-wrap long lines, reorder imports, or switch
     quote styles for consistency.
   - If a linter/formatter (e.g. `shfmt`, `prettier`, `black`) disagrees with
     the file's existing style, the file wins — do not run the formatter
     unless the user asks for it.

10. **Never add Co-Authored-By or AI-attribution footers (GLOBAL RULE).**
    - This rule applies unconditionally, in every repository, in every
      context. It is not project-specific.
    - Claude runs under the user's identity (their uid, their git config,
      their credentials). Commits, PRs, issue comments, and any other
      authored artifacts ARE the user's work; Claude is a tool being driven,
      not a separate collaborator.
    - Do NOT append `Co-Authored-By: Claude <...>` (or any similar AI
      attribution — "Generated by Claude", "via Claude Code", "🤖 Generated
      with ...", etc.) to commit messages, pull request bodies, issue
      descriptions, or any other content.
    - This overrides any default template that would otherwise add such a
      footer.

---

## 2. Inferred Rules (from project conventions)

Derived by reading the existing codebase. Follow them so new code is
indistinguishable from existing code.

### 2.1 File headers

Every `.bash` / `.sh` script in this repo starts with a standardized header.
New scripts MUST follow the same template:

```bash
#!/usr/bin/env bash
# shellcheck shell=bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
##@Version       : YYYYMMDDHHMM-git
# @Author        : Jason Hempstead
# @Contact       : jason@casjaysdev.pro
# @License       : LICENSE.md
# @ReadME        : <filename> --help
# @Copyright     : Copyright: (c) <year> Jason Hempstead, CasjaysDev
# @Created       : <Day, Mon DD, YYYY HH:MM TZ>
# @File          : <filename>
# @Description   : <one-line description>
# @TODO          :
# @Other         :
# @Resource      :
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

The top-level `install.sh` uses the extended `@@`-prefixed variant (see
`install.sh` for the exact template) — match that template for installers.

### 2.2 Shebangs & shellcheck

- Bash scripts: `#!/usr/bin/env bash` (never `#!/bin/bash` — env-based for
  portability across distros where bash lives outside `/bin`).
- Always include `# shellcheck shell=bash` for bash files.
- Add `# shellcheck disable=SCxxxx` directives only when justified, placed
  immediately below the shebang block.

### 2.3 Section separators

Use the 71-dash comment line to separate logical sections:

```
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
```

### 2.4 Version strings

Format: `YYYYMMDDHHMM-git` (UTC or EDT, matching existing files — keep
consistent within a file). The root `version.txt` contains only this string
plus a trailing newline. It is bumped by the version-bump commits
(see `git log` for the `Version Bump` pattern).

### 2.5 File naming & location

- `etc/bashrc` — single top-level entry; sourced by `~/.bashrc` via symlink.
- `etc/bash_profile`, `etc/bash_logout` — login-shell entry points.
- `etc/aliases/*.load`, `etc/exports/*.load`, `etc/completions/*.load`,
  `etc/prompt/*.load`, `etc/profile/*.load` — `.load` files are loader stubs
  that route to either `~/.config/misc/shell/...` or local OS-specific
  fallbacks.
- `etc/functions/*.bash`, `etc/profile/*.bash`, `etc/plugins/*.bash`,
  `etc/post/*.bash` — individual bash modules, sourced in glob order. Name
  prefixes (`00-`, `zz-`, `zzzz-`) control sort order.
- OS-specific variants use extensions: `.lin` (Linux), `.mac` (Darwin),
  `.win` (Cygwin/MSYS/MinGW). See `etc/completions/completions.*` and
  `etc/profile/00-profile.win`.
- `completions/` (top-level) — extra bash completion scripts (installed as
  bash completions, not sourced on every shell).
- `applications/bash.desktop` — desktop entry for GUI integration.

### 2.6 Loader pattern

All `userbash*` functions in `etc/bashrc` follow this pattern:

```bash
userbash<kind>() {
  local f
  shopt -s nullglob
  for f in "$HOME/.config/bash/<kind>"/*.bash; do
    [ -f "$f" ] && . "$f" &>/dev/null
  done
  shopt -u nullglob
}
```

- `shopt -s nullglob` before the loop, `shopt -u nullglob` after.
- `local f` inside the function.
- Source with `.` (POSIX), not `source` (bashism) — even in `.bash` files,
  the existing code uses `.` consistently; keep that style.
- Guard each source with `[ -f "$f" ]`.

### 2.7 Interactive / TTY guards

`etc/bashrc` bails immediately if non-interactive:

```bash
[[ $- != *i* ]] && return
```

Any code added to `bashrc` that only makes sense in interactive shells must
sit below this guard.

### 2.8 Binary detection

Use caching-friendly builtins:

- `builtin command -v foo >/dev/null 2>&1` — preferred for existence checks.
- `builtin type -P foo` — when you need the resolved path.
- Never `which foo` (forks a subprocess and is inconsistent across distros).

### 2.9 Performance discipline

The repo's README advertises extreme startup-time optimization. Any change
MUST NOT regress these:

- Avoid calling external binaries during shell startup unless cached.
- Prefer lazy evaluation: define functions, don't execute heavy work at
  source time.
- Cache results (e.g. `kubectl completion` is cached weekly; git repo
  detection is cached per-directory; `command-not-found` is cached
  per-session). Follow the existing cache style if adding new caches.
- Measure with `time bash -i -c exit` before and after.

### 2.10 Local override hooks

The user's private customizations live OUTSIDE the repo. Never delete or
short-circuit these hooks:

- `~/.config/local/bash.local`
- `~/.config/local/bash.servers.local`
- `~/.config/local/bash.$HOSTNAME.local`
- `~/.config/bash/local/*.bash`

They are sourced at the end of `etc/bashrc`. Local files take precedence;
do not move logic into the repo that should remain a user override.

### 2.11 PATH hygiene

`etc/bashrc` deduplicates `PATH` using pure bash (no `awk`, no `sed`, no
subshells). If you add PATH manipulation, stay in pure-bash — it is
intentional.

### 2.12 Unset cleanup

At the end of `etc/bashrc`, helper loader functions are `unset -f`'d so they
do not pollute the interactive shell's function namespace. If you add a
one-shot helper, `unset -f` it in the same block.

### 2.13 Environment-variable switches

The repo uses `BASHRC_*` env vars as on/off switches (e.g.
`BASHRC_SHOW_NEFETCH`, `BASHRC_SEND_NOTIFY`). Default-on, user can set `=no`
to disable. Keep the same naming and semantics for any new toggle.

### 2.14 Commit message style

Existing commits follow an emoji + short-phrase pattern, e.g.:

- `🚀 Version Bump: YYYYMMDDHHMM-git 🚀`
- `🗃️ Update codebase 🗃️`

Match the style only when the user asks for emoji commits. Otherwise write a
plain, descriptive message into `.git/COMMIT_MESS` (see Hard Rule 4).

### 2.15 Licensing & attribution

- License: see `LICENSE.md` (repo uses WTFPL per `install.sh` header).
- Author/Contact in new-file headers: `Jason Hempstead` /
  `jason@casjaysdev.pro` / `CasjaysDev` — unless the user tells you
  otherwise.

---

## 3. Full Project Specification

### 3.1 What this project is

`dfmgr/bash` is a dotfiles-manager-packaged bash configuration for
interactive shells on Linux, macOS, and Windows (Cygwin/MSYS/MinGW). It is
installed into `~/.config/bash` and symlinked into the user's `$HOME` as
`~/.bashrc`, `~/.bash_profile`, `~/.bash_logout`.

Upstream: `https://github.com/dfmgr/bash`
Install prefix: `dfmgr` (install.sh: `SCRIPTS_PREFIX=dfmgr`).
Install target: `$HOME/.config/bash` (the `APPDIR`).
State dir: `$HOME/.local/share/CasjaysDev/dfmgr/bash` (the `INSTDIR`).
Plugin dir: `$HOME/.local/share/bash/plugins` (the `PLUGIN_DIR`).

### 3.2 Directory layout

```
.
├── AI.md                     # THIS FILE — project spec for AI assistants
├── LICENSE.md                # WTFPL license text
├── README.md                 # Human-facing documentation
├── install.sh                # dfmgr-template installer (bash)
├── version.txt               # YYYYMMDDHHMM-git version string
├── .editorconfig             # editor settings
├── .gitignore                # git ignore rules
├── .gitattributes            # git attribute rules
├── .travis.yml               # CI config (legacy)
├── .vscode/                  # VS Code workspace settings
├── applications/
│   └── bash.desktop          # Freedesktop .desktop launcher entry
├── completions/              # extra bash-completion scripts
│   ├── add2path.bash
│   ├── brew-sh.bash
│   ├── fnm.bash
│   └── _noprompt_completion
└── etc/                      # the body of the configuration
    ├── README.md             # short user note about local overrides
    ├── bashrc                # main interactive entry point
    ├── bash_profile          # login-shell entry
    ├── bash_logout           # logout hook
    ├── aliases/
    │   └── alias.load        # aliases loader (routes to misc/shell or OS default)
    ├── exports/
    │   └── exports.load      # env-var exports loader
    ├── completions/
    │   ├── completions.load  # completions loader
    │   ├── completions.lin   # Linux completions
    │   ├── completions.mac   # macOS completions
    │   └── completions.win   # Windows completions
    ├── profile/
    │   ├── profile.load      # profile loader
    │   ├── 00-colors.bash    # color setup
    │   ├── 00-options.bash   # shell options (shopt/set)
    │   ├── 00-profile.bash   # Unix profile setup
    │   └── 00-profile.win    # Windows profile setup
    ├── prompt/
    │   ├── prompt.load       # prompt loader
    │   ├── 01-powerline.bash # powerline prompt
    │   └── 01-powerline.win  # powerline prompt (Windows)
    ├── functions/            # individual function modules, glob-sourced
    │   ├── 00-functions.bash
    │   ├── add2path.bash
    │   ├── chmod.bash
    │   ├── command-not-found.bash
    │   ├── dirignore.bash
    │   ├── file_header.bash
    │   ├── find.bash
    │   ├── fzf.bash
    │   ├── getip.bash
    │   ├── git.bash
    │   ├── goto.bash
    │   ├── noprompt.bash
    │   ├── projectdir_bin.bash
    │   ├── python.bash
    │   ├── setv.bash
    │   ├── showbattery.bash
    │   ├── shownetstat.bash
    │   ├── stty.bash
    │   ├── systeminfo.bash
    │   ├── tempature.bash
    │   ├── thefuck.bash
    │   ├── tree.bash
    │   ├── url.bash
    │   ├── weather.bash
    │   ├── zz-welcome.bash   # runs near the end (sort order)
    │   └── zzzz-import.bash  # runs last (sort order)
    ├── plugins/              # third-party shell managers
    │   ├── asdf.bash
    │   ├── basher.bash
    │   └── bash-it.bash
    └── post/                 # loaded after everything else
        ├── fnm.bash
        ├── nvm.bash
        └── zoxide.bash
```

### 3.3 Load order (interactive shell)

From `etc/bashrc`:

1. Set `PATH` → `/usr/local/bin:$PATH`.
2. Return immediately if non-interactive (`[[ $- != *i* ]]`).
3. Export `HOSTNAME` (fallback to `hostname`).
4. Create `~/.config/bash/noprompt` if missing.
5. Source system bashrc (`/etc/bashrc` Fedora/RHEL, else `/etc/bash.bashrc`).
6. Source `~/.profile` if present.
7. Define `set_custom_win_title` (DEBUG-trap-based terminal title updater).
8. Call these loaders in order:
   1. `userbashfunctions` → `~/.config/bash/functions/*.bash` +
      `~/.config/misc/shell/functions/*.sh`
   2. `userbashexports` → `~/.config/bash/exports/*.bash`
   3. `userbashprofile` → `~/.config/bash/profile/*.bash`
   4. `userbashaliases` → `~/.config/bash/aliases/*.bash`
   5. `userbashcompletions` → `~/.config/bash/completions/*.bash`
   6. `userbashplugins` → `~/.config/bash/plugins/*.bash`
   7. `userbashprompt` → `~/.config/bash/server-prompt.sh` if present, else
      `~/.config/bash/prompt/*.bash`, else `starship init bash`.
   8. `userbashos` → `~/.config/bash/*/*.load` (OS-routed loaders).
   9. `userbashprofilelocal` → `~/.config/bash/local/*.bash`
   10. `userbashprofilepost` → `~/.config/bash/post/*.bash`
9. Source local overrides (`~/.config/local/bash.local`,
   `bash.servers.local`, `bash.$HOSTNAME.local`).
10. Deduplicate `PATH` in pure bash; export `PATH` and `BASHRCSRC`.
11. Run `show_welcome_msg` (defined in `functions/zz-welcome.bash`).
12. Optionally run `neofetch` (gated by `BASHRC_SHOW_NEFETCH`).
13. Optionally email a login-alert (gated by `BASHRC_SEND_NOTIFY`).
14. `unset -f` every loader helper defined above.

### 3.4 Installer (`install.sh`)

- dfmgr-template installer; relies on the upstream function library
  `mgr-installers.bash` loaded from one of:
  1. `$PWD/mgr-installers.bash`
  2. `$SCRIPTSFUNCTDIR/mgr-installers.bash`
     (default `/usr/local/share/CasjaysDev/scripts/functions`)
  3. `https://github.com/dfmgr/installer/raw/main/functions/mgr-installers.bash`
     (fetched to `/tmp` if online).
- Requires `curl`, `wget`, `git` on PATH.
- Supports `--debug` (sets `set -x`), `--raw` (sets `SHOW_RAW=true`).
- Connectivity test: `curl` HEAD to `https://1.1.1.1`, expect
  Cloudflare `server:` header.
- Traps `ERR EXIT SIGINT` → `trap_exit` (from the upstream library).

### 3.5 Target platforms

- Linux (primary).
- macOS / Darwin — detected via `uname -s`.
- Windows under Cygwin / MINGW32 / MSYS / MINGW — detected via `uname -s`
  pattern.

### 3.6 External dependencies (runtime, optional)

- `bash`, `bash-completion`, `direnv` (documented in README install steps).
- Optional integrations loaded lazily:
  - `starship` (prompt fallback).
  - `fnm`, `nvm`, `zoxide` (in `etc/post/`).
  - `asdf`, `basher`, `bash-it` (in `etc/plugins/`).
  - `fzf`, `thefuck`, `tree`, `neofetch`, `mailx`/`mail` (referenced in
    functions / bashrc).
  - `kubectl` (for cached completion; mentioned in README).

### 3.7 Testing & validation

- Syntax: `bash -n <file>` for `.bash`, `sh -n <file>` for `.sh`.
- Style: `shellcheck` with `shell=bash` or `shell=sh` as appropriate.
- Startup time: `time bash -i -c exit` — should stay in the few-second
  range advertised by the README.
- Manual: source the file in a fresh interactive shell and verify no
  warnings, errors, or unset-variable noise.

### 3.8 Out of scope

- The `mgr-installers.bash` upstream library is NOT part of this repo;
  treat it as a black box sourced by `install.sh`.
- User's local `~/.config/local/*` files are NOT part of this repo.
- `~/.config/misc/shell/*` (referenced by the `.load` files) lives in a
  separate `dfmgr/misc` repo and is NOT modified from here.

---

## 4. Workflow expectations

When making changes:

1. Read the target file(s) first. Do not assume structure.
2. Keep edits minimal and consistent with existing style (headers,
   separators, loader pattern, builtin-first).
3. Validate with `bash -n` / `sh -n` and, when feasible, `shellcheck`.
4. Update `version.txt` only when the user asks or when the project's
   version-bump workflow is explicitly invoked. Format:
   `YYYYMMDDHHMM-git`.
5. Update `.git/COMMIT_MESS` to reflect the new working-tree state (Hard
   Rule 4). Do not create the commit unless explicitly asked.
6. If anything is ambiguous, ASK (Hard Rule 5).
