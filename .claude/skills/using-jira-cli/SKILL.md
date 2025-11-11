---
name: jira-cli
description: Reference skill for operating Atlassian Jira via the `jira` command-line interface bundled in this workspace.
---

# Jira CLI Operations

Use this skill whenever you need to inspect, create, update, or navigate Jira data from the terminal. It summarises the behaviour of the `jira` binary available in this repo.

## Core Mental Model
- Command shape: `jira <command> <subcommand> [arguments] [flags]`.
- Global flags: `--config`, `--project`, `--debug`, plus `-h/--help`.
- Most list commands launch an interactive explorer. Switch to scripts or tabular output with `--plain`, `--table`, `--raw`, or `--csv`.
- Drill into more detail with `jira <command> --help` or `jira <command> <subcommand> --help`.

## Initial Setup
- Run `jira init` to create `~/.config/.jira/.config.yml` (override via `JIRA_CONFIG_FILE`).
- Important init flags:
  - `--installation cloud|local`
  - `--server`, `--login`, `--auth-type basic|bearer|mtls`
  - `--project`, `--board` for defaults
  - `--force` to overwrite existing config, `--insecure` to skip TLS verification

## Navigation & Discovery
- `jira project list`: enumerate accessible projects (`ls`, `lists` aliases).
- `jira board list`: list boards within the active project (`boards`, `ls`).
- `jira release list`: show project versions/releases.
- `jira sprint list [SPRINT_ID]`: explore sprints or sprint issues; filter with `--state`, `--current`, `--next`, `--prev`, `--jql`.
- `jira open [ISSUE-KEY]`: open the project or issue in a browser (`--no-browser` to emit URL only).
- `jira me`: print the configured Jira user.
- `jira serverinfo`: show instance metadata.
- `jira version`: print CLI build info.

## Working With Issues
- Create: `jira issue create` with flags like `--type`, `--summary`, `--body`, `--priority`, `--assignee`, `--label`, `--component`, `--parent`, `--custom key=value`, `--template`, `--web`, `--raw`, `--no-input`.
- Edit: `jira issue edit ISSUE-KEY` to update summary, description, priority, assignee, labels, components, custom fields; use `--no-input` for non-interactive updates.
- List/search: `jira issue list [query]` with filters (`--type`, `--status`, `--priority`, `--label`, `--created`, `--updated`, `--jql`, `--paginate` etc.) and output controls (`--plain`, `--columns`, `--comments`, `--raw`, `--csv`, `--no-headers`, `--no-truncate`, `--delimiter`).
- View: `jira issue view ISSUE-KEY` with optional `--comments N`, `--plain`, `--raw`.
- Comments: `jira issue comment add ISSUE-KEY [BODY]` supports `--template`, `--internal`, `--no-input`, `--web`.
- Assignment: `jira issue assign ISSUE-KEY USER`; pass email, display name, `default`, `x`, or `$(jira me)`.
- Workflow: `jira issue move ISSUE-KEY STATE` with optional `--comment`, `--assignee`, `--resolution`, `--web`.
- Clone/Delete: `jira issue clone ISSUE-KEY` (override fields with flags) and `jira issue delete ISSUE-KEY [--cascade]`.
- Watchers: `jira issue watch ISSUE-KEY USER`.
- Worklogs: `jira issue worklog add ISSUE-KEY "2d 1h"` with `--started`, `--timezone`, `--comment`, `--new-estimate`, `--no-input`.
- Linking:
  - `jira issue link A-1 B-2 "Blocks"`; add `--web` to open in browser.
  - `jira issue link remote ISSUE-1 URL TITLE`.
  - `jira issue unlink A-1 B-2` removes the relationship.

## Epics
- Create epics with `jira epic create` (same flag palette as issue create).
- Inspect epics via `jira epic list [EPIC-KEY]`; supports filters (`--status`, `--priority`, `--label`, `--created`, `--jql`) and output modifiers (`--table`, `--plain`, `--columns`, `--csv`, `--raw`).
- Manage relationships:
  - `jira epic add EPIC-KEY ISSUE-1 ...` (up to 50 issues).
  - `jira epic remove ISSUE-1 ...` to detach.

## Sprints
- List sprint metadata or issues with `jira sprint list [SPRINT_ID]`; use `--current`, `--next`, `--prev`, `--state`, `--jql`, `--paginate`, `--columns`, and the same output flags as issue list.
- Assign issues: `jira sprint add SPRINT_ID ISSUE-1 ...` (max 50 issues).
- Close sprint: `jira sprint close SPRINT_ID`.

## Output Control Patterns
- Interactive explorer is default; prefer `--plain` + `--columns` + `--delimiter` for piping into text processing.
- Structured data options: `--raw` for JSON (suitable for jq) and `--csv` for spreadsheets.
- Adjust interactive layout with `--fixed-columns` when using table mode.

## Automation Tips
- Set per-run project context through `--project KEY` or `JIRA_PROJECT`.
- Combine with shell utilities: e.g., `jira issue list --plain --columns key,summary | rg BUG`.
- Use `--template -` to accept STDIN (e.g., `echo "note" | jira issue comment add ISSUE-1 --template -`).
- Capture URLs for CI logs via `jira open ISSUE-1 --no-browser`.

## Example Sequences
```bash
# Configure CLI (interactive)
jira init

# Create a bug with template body and custom field
jira issue create --type Bug --summary "API returns 500" \
  --template docs/bug.md --custom story-points=3 --label backend

# View high-priority work assigned to self
jira issue list --priority High --assignee "$(jira me)" --plain --columns key,summary,status

# Transition issue to Done with resolution and comment
jira issue move PROJ-42 Done --resolution Fixed --comment "Verified in staging"

# Attach work item to epic and sprint
jira epic add PROJ-EPIC-7 PROJ-42
jira sprint add 12345 PROJ-42

# Log time with timezone-aware start
jira issue worklog add PROJ-42 "1h 30m" --started "2024-06-03 09:30:00" --timezone "America/New_York"
```

## Troubleshooting Reminders
- Missing config errors → rerun `jira init` or point `JIRA_CONFIG_FILE` to the correct YAML.
- Permission failures → confirm Jira access with `jira me` and verify server grants.
- Truncated columns → add `--plain --no-truncate` or tweak `--columns`.
- Workflow transition errors → check Jira workflow states; CLI honours project constraints.

Always keep `jira help` in mind to discover additional subcommands or flags not summarised here.
