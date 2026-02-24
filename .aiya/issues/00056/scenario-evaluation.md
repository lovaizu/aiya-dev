# Scenario Evaluation

| AS | Status | Method | Judgment |
|----|--------|--------|----------|
| AS1 | OK | Executed | As a developer, piped wc.sh content to `bash` (simulating `curl \| bash`). Got "Welcome to ciya-dev!" and exit 0. `main` executes and setup completes without errors is satisfied. |
| AS2 | OK | Executed | As a developer, ran `bash wc.sh` in a temp directory. Got "Welcome to ciya-dev!" and exit 0. `main` executes and setup completes without errors is satisfied. |
| AS3 | OK | Executed | As a developer, ran `source wc.sh` in a subshell. Got `ensure_git is a function` from `type ensure_git` and no setup output. Functions are loaded but `main` is not executed is satisfied. |
