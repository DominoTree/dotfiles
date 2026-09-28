# Shared global instructions

The canonical file is `~/Projects/dotfiles/agent-instructions/AGENTS.md`. Both `~/.codex/AGENTS.md` and `~/.claude/CLAUDE.md` are symlinks to it. Edit the canonical file and preserve the symlinks. Keep durable cross-project guidance here; keep project findings, task history, and live environment details in the relevant project documentation or `~/Projects/_AGENTS`.

# Scope and working style

- Complete the requested work without unrelated cleanups. Report adjacent bugs, but do not fix them, even in the same file.
- Follow existing conventions and patterns. Use descriptive names and avoid unnecessary nesting.
- Verify technical claims against relevant source code and documentation for the version being worked on.

# Execution

- Batch independent reads and searches before reaching for subagents.
- Use research subagents, when available, for substantial open-ended exploration or independent parallel tasks. Keep small edits and sequential work in one area in the main session.
- Run independent work concurrently. Coordinate shared resources and file edits to avoid contention or conflicting changes.
- Size builds and processing jobs to available CPU, memory, and I/O capacity. Inspect host capabilities when they affect the task; optimize for useful throughput.

# Scripts and validation

- For new shell scripts, use Zsh on macOS and POSIX sh elsewhere. Preserve existing scripts' interpreters and conventions.
- Run ShellCheck on shell scripts you create or modify when it supports their dialect.
- Format and lint changed code using the repository's configuration and tools. Address findings introduced by the change without unrelated reformatting or cleanup.
- For new compute-heavy or I/O-heavy utilities, prefer Go, Rust, or Zig. Follow the existing language and tooling when extending a project.
- Long-running utility scripts should print regular status messages.

# Writing

- Use plain ASCII in generated text, including chat, code, comments, commits, PR text, documentation, and notes. Use straight quotes, hyphens, three dots for an ellipsis, and `->` for an arrow.
- Preserve quoted upstream text, vendor content, and existing text; do not rewrite them merely to change typography.

# Paths and references

- `~/Projects`: active personal projects, forks, and working trees. The old `~/Work`, `~/src`, and `~/attic` layout has been retired; resolve old references against the current tree.
- `~/Projects/_SRC`: third-party reference checkouts, such as Linux, the other BSDs, and language/toolchain sources. Consult them without modifying them; use a personal fork or working tree under `~/Projects` for development.
- `~/Projects/_REFERENCE`: standards, specifications, datasheets, and reference collections. Check here before relying on a header comment or online copy, and verify the applicable revision. Use `pdftotext -layout` when searching PDF tables.
- `~/Projects/_REFERENCE/freebsd-mailarchive`: local FreeBSD mailing list archive. Search the uncompressed `plain/` tree with `rg`, narrowing by year/list when possible. If using `mirror/`, use `rg -z` across all files; a `*.gz` glob misses uncompressed messages. See its `ARCHITECTURE.md` for coverage, reconstruction caveats, and sync details.
- `~/Projects/_AGENTS`: shared working context for all agents: design notes, investigations, rig state, and `TODO.md`. Its `.env` holds FreeBSD API credentials; use the access instructions below without copying secrets into documentation.
- `~/Projects/_CLAUDE` is a compatibility symlink to `_AGENTS`. Use `_AGENTS` in new notes, scripts, and instructions; old references still resolve through the link.
- `~/Projects/_ATTIC`: retained investigation and submission artifacts: patches, draft reports, review writeups, captures, reproducers, one-off tools, and miscellaneous files. Put material being prepared for submission here. Placement here does not authorize publication or deletion.
- `~/Projects/_ARCHIVE`: inactive personal projects retained for reference; resume development there only when the task calls for it.
- `~/bin`: reusable personal scripts on `PATH`; project-specific scripts stay with their project.

## Shared working context

- Before substantive work, read `~/Projects/_AGENTS/TODO.md` and relevant project notes for existing investigations and unfinished work.
- Reconcile that TODO at the end of substantive work: add new open threads, remove completed ones, and refresh its `Last updated` date. Keep only open `- [ ]` entries, with a short description and a pointer to the detailed notes; do not leave completed `- [x]` entries.
- Before removing a completed item, preserve useful findings, decisions and their reasons, refuted approaches, and live rig state in durable project notes or `~/Projects/_AGENTS`. Keep those notes usable by either agent without requiring access to Claude's private memory index.
- If `~/Projects/TODO.md` is present, it is Nick's separate personal tracker; do not conflate it with `~/Projects/_AGENTS/TODO.md`.

# Environment and tooling

- Primary hosts are FreeBSD and macOS. Use the actual host and userland when selecting commands; do not assume GNU utilities or flags.
- A Linux `uname` may come from the FreeBSD Linuxulator. Check `freebsd-version`, `sysctl`, and the available native toolchain before concluding that FreeBSD kernels or modules cannot be built locally.
- For in-place regex edits, prefer `perl -i -pe`; BSD `sed` options and regex syntax differ from GNU `sed`.
- On FreeBSD, use `doas` instead of `sudo` for privilege escalation.
- Ask before installing additional tooling, preferably through the system package manager. Exception: in the FreeBSD `scratch` jail, installing tooling needed for the task from any source is already authorized.
- Available CLIs include `gh`, `aws`, `gcloud`, and `az`. AWS profiles are in `~/.aws/config`; prefer the `AWSAdministratorAccess` role.
- On the configured FreeBSD hosts, jails are at `/usr/local/jails/containers/`, configs at `/usr/local/etc/jail.conf.d/`, and persistent stores at `/usr/local/jails/data`. Jails are ephemeral. Unprivileged sessions cannot access jails or see other users' processes.

## Jail and host configuration

- `~/Projects/jails` is the active repository for host configuration, jail build/operations scripts, and deployment notes. Start with `jails/ARCHITECTURE.md`, then verify details against the scripts and installed configuration; repository copies and running state can differ.
- Make durable jail changes in build scripts, templates, and persistent data/configuration. Changes made only inside a container can disappear when it is rebuilt.
- Check the target host, jail, dataset, and nullfs mounts before changing files. A writable jail mount can expose host files; the `scratch` development jail is not a containment boundary for untrusted code.
- Prefer `doas jexec -l -U <user> <jail> <command>` for running a command as a jail user. Keep builds unprivileged when their output directories and shared caches belong to the normal user.
- Keep fleet versions, per-service settings, storage details, and operational runbooks beside the scripts. Keep shared investigations and open threads in `~/Projects/_AGENTS`.

# FreeBSD source work

These rules apply to FreeBSD source repositories, including forks and working trees.

## Source and commits

- Develop in `~/Projects/freebsd-src` and `~/Projects/freebsd-ports` or their designated working trees. `/usr/src` and `/usr/ports` are deployment/build/install trees; do not author changes, commit, or push from them.
- Make source changes on `nick-dev`, based on `main`. Before editing, inspect the working tree, use `git checkout nick-dev` when a switch is needed and preserves existing work, and verify with `git branch --show-current`. Read-only reviews do not require switching branches.
- The releng fork is retired. Do not cherry-pick to it or add `(cherry picked from ...)` trailers.
- New comments in `.c` and `.h` files must be extremely terse and necessary. Do not add explanatory or rationale block comments, and preserve original and vendor comments.
- Put change rationale in the commit message. Keep it terse and limited to what is needed to understand the change; avoid explanations of unrelated architecture. Use plain text with approximately 72-column hard wrapping.
- Draft commit messages, code comments, and outward drafts (PR, Bugzilla, Phabricator, list replies) at their final terse length on the first pass. Do not produce a full version and wait to be told to cut it; assume the shortest form that still carries the non-obvious facts is what I want.
- Keep only what a reader cannot derive from the code or the diff. Cut, in this order: throat-clearing and preamble; any sentence restating what the change plainly does; the same point stated twice; device- or case-specific detail the general statement already covers; API or usage recipes (they go in the man page); impact and edge-case notes (they go in the PR description or review, not the log).
- When told to shorten, cut hard: remove whole sentences and paragraphs, do not word-smith. A second "still too verbose" means the first cut was far too timid; overshoot rather than nudge.
- Match my register, not a neutral one: short declarative sentences in my own voice. When I point to one of my own commits, comments, or PR replies, treat it as the exact style to copy.
- Avoid specific commit hashes in internal notes because frequent rebasing makes them unstable references.

## Reviews and publishing

- FreeBSD bug reports live in Bugzilla at `bugs.freebsd.org`; Differential code reviews live in Phabricator at `reviews.freebsd.org`.
- Before designing a fix for a Bugzilla bug, search Phabricator for the bug number, subject, and relevant symbols to find existing or in-flight reviews. Check the bug's comments and attachments and relevant mailing list discussions before duplicating work.
- Never submit or update anything outward without an explicit request. This includes Phabricator (`arc diff`), Bugzilla, mailing lists, and Git pushes. Prepare patches, local commits, amended commits, and draft replies locally.
- When asked to push, use `origin` (Nick's fork) unless another remote is explicitly named. Pushing to `upstream` and force-pushing each require an explicit request.
- Before an authorized upstream submission, check the project's contribution instructions, including AI-assistance, DCO, and CLA requirements. Inspect the active Git identity and signoff hooks, and verify required trailers without adding duplicates.
- When updating Phabricator reviews, upload only the requested subset or commits whose patch content changed. Rebasing and changing commit hashes alone do not justify uploading new diffs.
- Phabricator paragraphs must have no hard line breaks; wrap code symbols in backticks.

## Bugzilla and Phabricator access

- Prefer REST/Conduit for programmatic reads. Public web pages may work anonymously, but if a fetch returns an Anubis challenge or login shell, use the API instead of repeatedly scraping it.
- Credentials live in `~/Projects/_AGENTS/.env`: `FREEBSD_BUGZILLA_API_KEY` and `FREEBSD_PHABRICATOR_API_TOKEN`. Load them in the requesting process, for example with `set -a; . ~/Projects/_AGENTS/.env; set +a` in a shell. Do not print values, enable shell tracing, or include credential-bearing URLs in logs, notes, or replies.
- Bugzilla REST base: `https://bugs.freebsd.org/bugzilla/rest/`. Use GET `bug` for searches, `bug/<id>` for details, `bug/<id>/comment` for discussion, and `bug/<id>/attachment` for attachments. Use `include_fields` to keep responses small and `exclude_fields=data` for attachment metadata. FreeBSD's recorded working authentication uses the `api_key` parameter; do not assume the `X-BUGZILLA-API-KEY` header supported by other Bugzilla installations works here.
- URL-encode Bugzilla `quicksearch` terms. Prefix them with `ALL` to include resolved bugs as well as open ones when checking prior work. Check the JSON `error`, `code`, and `message` fields before interpreting results.
- Phabricator Conduit base: `https://reviews.freebsd.org/api/`. POST `api.token` plus the method's parameters. Use `differential.revision.search` with nested `constraints[ids][0]=<number>` for a review or `constraints[query]=<terms>` for text search. Use `transaction.search` with `objectIdentifier=<revision PHID>` for comments and history. Check `error_code` and `error_info`, and follow `result.cursor.after` when paging search results.
- `arc` uses `~/.arcrc`; running it from the FreeBSD source tree picks up that tree's `.arcconfig`. Check the installed `arc`/`git-arc` help before using options from another version. API access and configured credentials do not authorize publishing.

API references: [Bugzilla REST](https://bugzilla.readthedocs.io/en/5.2/api/core/v1/general.html), [FreeBSD revision search](https://reviews.freebsd.org/conduit/method/differential.revision.search/), and [FreeBSD transaction search](https://reviews.freebsd.org/conduit/method/transaction.search/).

## Build and testing

- On a FreeBSD host, use the native toolchain to build kernels and modules. Example module build with objects out of tree: `mkdir -p /tmp/obj && env MAKEOBJDIRPREFIX=/tmp/obj make -C sys/modules/<mod> -j4`. Module builds use `-Werror`.
- When changing a binary, run its whole test suite against the freshly built binary, not the system binary. If the changed behavior has no coverage, add a regression test and prove it fails on the unpatched binary.
- When changing a network driver, prove the interface passes traffic: RX and TX counters must move and ping or iperf must succeed. Link-up and absence of a panic are insufficient. For RSS or multiqueue changes, use enough distinct flows to demonstrate traffic on multiple RX queues.
