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
- configure `.gemini/settings.json` to set up the Gemini CLI (or equivalent for other providers)

## Build

```sh
docker build -t ai-coding-agent .
```

## Usage Overview

General form:
```sh
docker run --rm \
	--env-file .env \
	-v "$(pwd)":/workspace \
	ai-coding-agent <provider|command> [options] -- <free-form prompt>
```

### Read / Explain an Image

Use `@image/<path>` inside the prompt. The path is relative to the mounted workspace root.

```sh
docker run --env-file .env -v ./:/workspace ai-coding-agent \
	gemini --approval-mode auto_edit -m "gemini-1.5-flash-8b" \
	"Explain the content of @image/example.png and list key metrics."
```

Example (truncated) output explanation:
> The image shows a comparison of Free vs Paid tiers for "Gemini 2.5 Flash-Lite" including input/output/latency token costs, Google Search integration limits, and product improvement policy.

### Create a File

If the agent supports file creation via prompt (pattern example):
```sh
docker run --env-file .env -v ./:/workspace ai-coding-agent \
	gemini -m "gemini-2.5-flash-lite" --approval-mode auto_edit \
	"Create a new file at src/hello.py that prints 'Hello AI Agent' when executed."
```
Depending on approval mode, the file is written automatically or a diff is shown for confirmation.

### Modify a File

```sh
docker run --env-file .env -v ./:/workspace ai-coding-agent \
	gemini -m "gemini-2.5-flash-lite" --approval-mode auto_edit \
	"Update README.md to add a Troubleshooting section with common errors."
```

### Development Workflow

Iterate locally without rebuilding image each time by mounting the code; rebuild only after dependency changes:
```sh
docker build -t ai-coding-agent .
docker run --env-file .env -v ./:/workspace ai-coding-agent gemini -m gemini-2.5-flash-lite "List repository files"
```

### Troubleshooting

| Symptom                      | Possible Cause             | Fix                                           |
|------------------------------|----------------------------|-----------------------------------------------|
| `Invalid API key`            | Wrong `API_KEY`            | Update `.env` and re-run.                     |
| `File not found: @image/...` | Wrong relative path        | Ensure file exists under project root.        |
| Hanging run                  | Network / provider latency | Retry with smaller prompt or different model. |
| No changes applied           | `dry_run` mode enabled     | Use `--approval-mode auto_edit` or `ask`.     |

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