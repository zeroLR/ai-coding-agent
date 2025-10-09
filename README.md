# AI Coding Agent

An experimental, containerized command-line AI coding assistant. It mounts your current workspace into a Docker container and delegates actions (like reading images, creating or modifying files) to an AI model with optional approval modes.

## Features

- Run fully inside Docker (clean host environment)
- File creation & modification with optional approval workflow

## Prerequisites

- Docker installed and running
- A `.env` file containing required API keys / settings (example variables, adjust to your provider):
	```env
	API_KEY=your_key_here
	```
- configure `gemini/.gemini/settings.json` to set up the Gemini CLI (or equivalent for other providers)

## Build

Build locally for each CLI image:

```sh
# Gemini image
docker build -t gemini-coding-agent gemini

# Copilot image
docker build -t copilot-coding-agent copilot
```

Or pull from GHCR after a tagged release (replace <owner> with your GitHub username or org):

```sh
docker pull ghcr.io/<owner>/gemini-coding-agent:latest
docker pull ghcr.io/<owner>/copilot-coding-agent:latest
```

## Usage Overview

General forms (choose one image):

Gemini:
```sh
docker run --rm \
	--env-file .env \
	-v "$(pwd)":/workspace \
	ghcr.io/<owner>/gemini-coding-agent \
	gemini [options] -- <free-form prompt>
```

Copilot:
```sh
docker run --rm \
	-v "$(pwd)":/workspace \
	ghcr.io/<owner>/copilot-coding-agent \
	copilot [options]
```

### Read / Explain an Image

Use `@image/<path>` inside the prompt. The path is relative to the mounted workspace root.

```sh
docker run --rm --env-file .env -v "$(pwd)":/workspace ghcr.io/<owner>/gemini-coding-agent \
	gemini --approval-mode auto_edit -m "gemini-1.5-flash-8b" \
	"Explain the content of @image/example.png and list key metrics."
```
### Create a File

If the agent supports file creation via prompt (pattern example):

```sh
docker run --rm --env-file .env -v "$(pwd)":/workspace ghcr.io/<owner>/gemini-coding-agent \
	gemini -m "gemini-2.5-flash-lite" --approval-mode auto_edit \
	"Create a new file at src/hello.py that prints 'Hello AI Agent' when executed."
```
```sh
docker run --rm --env-file .env -v "$(pwd)":/workspace ghcr.io/<owner>/gemini-coding-agent \
	gemini -m "gemini-2.5-flash-lite" --approval-mode auto_edit \
	"Update README.md to add a Troubleshooting section with common errors."
```
```sh
docker build -t gemini-coding-agent gemini
docker run --env-file .env -v "$(pwd)":/workspace gemini-coding-agent \
	gemini -m gemini-2.5-flash-lite "List repository files"
```

### Troubleshooting

| Symptom                      | Possible Cause             | Fix                                           |
|------------------------------|----------------------------|-----------------------------------------------|
| `Invalid API key`            | Wrong `API_KEY`            | Update `.env` and re-run.                     |
| `File not found: @image/...` | Wrong relative path        | Ensure file exists under project root.        |
| Hanging run                  | Network / provider latency | Retry with smaller prompt or different model. |
| No changes applied           | `dry_run` mode enabled     | Use `--approval-mode auto_edit` or `ask`.     |

## GitHub Actions Integration

This repository includes an example GitHub Actions workflow that demonstrates how to use the AI Coding Agent in CI/CD pipelines.

### Quick Setup

1. **Add GEMINI_API_KEY Secret**: Go to your repository **Settings** → **Secrets and variables** → **Actions** and add `GEMINI_API_KEY` with your Gemini API key
2. **Run Workflow**: Navigate to **Actions** tab → **AI Coding Agent Example** → **Run workflow**
3. **Configure Task**: Enter your task description and choose approval mode

See [GitHub Actions Setup Guide](docs/github-actions-setup.md) for detailed instructions.

### Example Workflows

The included workflow demonstrates several use cases:
- **Repository Analysis**: Analyze project structure and provide insights
- **Code Quality Checks**: Review code for improvements and security issues
- **Documentation Review**: Check and suggest documentation improvements
- **Automated File Modifications**: Create or modify files based on AI recommendations

### Contributing

Pull requests welcome. Please keep changes small and focused. If adding a dependency, explain why in the PR description.

### Roadmap

- More model providers (OpenAI, Anthropic, etc.)
- Improved error handling and user feedback
- Enhanced support for code-related tasks (e.g., refactoring, code reviews)

### License

Specify a license (e.g., MIT) in a future update.

---
Feedback & improvements welcome. Enjoy building with AI-assisted coding.