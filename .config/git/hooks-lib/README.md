# Modular Git Hooks System

A lightweight, shell-based modular git hooks system with per-repo configuration.

## Architecture

```
~/.config/git/
├── template/hooks/          # Templates for new repos (copied via git init)
│   ├── pre-commit
│   ├── commit-msg
│   └── prepare-commit-msg
├── hooks-lib/               # Shared hook modules (functions)
│   ├── commitlint.sh       # Validates conventional commits
│   ├── gitleaks.sh         # Detects secrets
│   ├── llm-check.sh        # AI-powered sensitive data check
│   └── gptcommit.sh        # AI-generated commit messages
└── commitlint/
    └── commitlint.config.mjs
```

## How It Works

1. **Template Setup**: `git config --global init.templatedir ~/.config/git/template`
2. **New Repos**: `git init` copies hooks from template
3. **Per-Repo Config**: Each repo can have `.githooks-config` to enable/disable hooks
4. **Modular Execution**: Template hooks load and run enabled modules from `hooks-lib/`

## Per-Repo Configuration

Create `.githooks-config` in repo root:

```bash
# .githooks-config
# Enable hooks by setting to 1, disable with 0

# Pre-commit hooks
HOOK_GITLEAKS=1       # Detect secrets (gitleaks)
HOOK_LLM_CHECK=0      # AI-powered sensitive data check (llm CLI)
HOOK_TESTS=0          # Run tests (not yet implemented)

# Commit-msg hooks
HOOK_COMMITLINT=1     # Validate conventional commits

# Prepare-commit-msg hooks
HOOK_GPTCOMMIT=1      # AI-generated commit messages
```

## Default Configuration

If no `.githooks-config` exists, defaults are:
- ✅ `HOOK_GITLEAKS=1` - Always check for secrets
- ❌ `HOOK_LLM_CHECK=0` - Opt-in (costs API tokens)
- ❌ `HOOK_TESTS=0` - Opt-in (not yet implemented)
- ✅ `HOOK_COMMITLINT=1` - Always validate conventional commits
- ✅ `HOOK_GPTCOMMIT=1` - Always generate commit messages

## Example Configurations

### Dotfiles Repo (paranoid)
```bash
HOOK_GITLEAKS=1
HOOK_LLM_CHECK=1      # Extra check for personal configs
HOOK_COMMITLINT=1
HOOK_GPTCOMMIT=0      # Manual commits for dotfiles
```

### Work Repo
```bash
HOOK_GITLEAKS=1
HOOK_LLM_CHECK=0
HOOK_TESTS=1          # Run tests before commit
HOOK_COMMITLINT=1
HOOK_GPTCOMMIT=1
```

### Personal Project
```bash
HOOK_GITLEAKS=1
HOOK_COMMITLINT=1
HOOK_GPTCOMMIT=1
```

## Adding Hooks to Existing Repos

```bash
# Option 1: Reinit (safe, just copies hooks)
cd your-repo
git init

# Option 2: Manual copy
cp ~/.config/git/template/hooks/* .git/hooks/
```

## Adding New Hook Modules

1. Create module in `~/.config/git/hooks-lib/your-module.sh`:
```bash
#!/bin/sh
run_your_module() {
    echo "🔧 Running your module..."
    # Your code here
    return 0  # 0 = success, 1 = failure
}
```

2. Add to appropriate template hook:
```bash
if [ "$HOOK_YOUR_MODULE" = "1" ]; then
    . "$HOOKS_LIB/your-module.sh"
    if ! run_your_module; then
        HOOK_FAILED=1
    fi
    echo ""
fi
```

3. Document default in template hook and README

## Dependencies

- **gitleaks** (brew): Secret detection
- **commitlint** (brew): Conventional commits validation
- **llm** (brew/pip): AI-powered checks (optional)
- **gptcommit** (brew): AI commit messages (optional)

All tools gracefully skip if not installed.

## Troubleshooting

**Hooks not running?**
- Check `.git/hooks/` has executable files
- Run `git init` to copy from template

**Commitlint fails?**
- Config at `~/.config/commitlint/commitlint.config.mjs`
- Uses inline rules (no external dependencies)

**Want to skip hooks temporarily?**
```bash
git commit --no-verify -m "message"
```

## Philosophy

- **Simple**: Plain shell scripts, no frameworks
- **Modular**: Each check is isolated
- **Configurable**: Per-repo control
- **Transparent**: Easy to understand and debug
- **Optional**: Tools gracefully skip if missing
