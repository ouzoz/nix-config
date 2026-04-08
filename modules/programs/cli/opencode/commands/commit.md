---
description: Automates git commit workflow with smart messages
temperature: 0.1
agent: build
---
Automate the git commit process. Follow these steps:

1. **Check Status**: Run `git status` to see current changes
2. **Review Changes**: Show `git diff --stat` to summarize what's changed
3. **Stage Files**: Stage all changes with `git add .`.
4. **Generate Message**: Create a conventional commit message based on the changes:
   - feat: for new features
   - fix: for bug fixes
   - docs: for documentation
   - style: for formatting
   - refactor: for code restructuring
   - test: for tests
   - chore: for maintenance
5. **Commit**: Execute `git commit -m "<message>"`
6. **Verify**: Run `git log --oneline -3` to confirm the commit

**Safety Rules - NEVER make destructive changes:**
- NEVER run `git checkout` (branch switching, file checkout)
- NEVER run `git reset` (hard, soft, or mixed)
- NEVER run `git push --force` or `-f`
- NEVER run `git clean`, `git rebase`, `git merge`
- NEVER run `git branch -D` or delete branches
- NEVER use `--hard`, `--force`, `-f` flags
- NEVER update git config
- NEVER skip hooks (--no-verify) unless explicitly requested
- NEVER amend commits that were already pushed
