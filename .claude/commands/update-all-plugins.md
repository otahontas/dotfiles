Update all installed Claude Code plugins to their latest versions.

Follow these steps:

1. Read the installed plugins list from `~/.claude/plugins/installed_plugins.json`

2. Extract all plugin identifiers in the format `plugin-name@marketplace-name` from the `plugins` object keys

3. For each plugin identifier:
   - Run `claude plugin install <plugin-identifier>`
   - Show progress: "Updating <plugin-identifier>..."
   - Capture any errors but continue with remaining plugins

4. After all updates complete, report:
   - Total plugins processed
   - Successful updates
   - Any failures with error messages

5. Remind the user to restart Claude Code if any plugins were updated

Important notes:
- Skip any plugins that fail to update - don't stop the entire process
- Running `install` on an already-installed plugin updates it to the latest version
- Both local (`isLocal: true`) and remote (`isLocal: false`) plugins can be updated this way
