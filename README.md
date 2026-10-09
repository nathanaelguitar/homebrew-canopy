# Canopy Code for Homebrew

```sh
brew install nathanaelguitar/canopy/canopy-code
canopy
```

Canopy Code is a terminal coding agent. It is free: bring your own model provider, or sign in
inside Canopy with `/auth`:

- **ChatGPT** — "Sign in with ChatGPT" (Plus, Pro, Business plans).
- **Claude** — "Sign in with Anthropic" runs your Claude subscription through Claude Code.
  Install Claude Code first, then pick it in `/auth`; Canopy runs `claude auth login` for you if
  you are not signed in yet:

  ```sh
  brew install --cask claude-code      # or: npm install -g @anthropic-ai/claude-code
  ```

  Canopy finds `claude` on your PATH, in `/opt/homebrew/bin`, `~/.local/bin`, or the npm, bun and
  volta global bins. To point it elsewhere, set `CANOPY_CLAUDE_CODE_COMMAND=/path/to/claude`.
  `ANTHROPIC_API_KEY` and similar overrides must be unset for subscription sign-in.
- **API keys** — any OpenAI-compatible, Anthropic or Gemini endpoint.

Remote control from the CanopyChat app needs a Canopy account
(https://canopychat.app/signup) and a subscription.

To update: `brew upgrade canopy-code`, then restart `canopy` and accept the daemon restart.

Apple silicon Macs only for now.
