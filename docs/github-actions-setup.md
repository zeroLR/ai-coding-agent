# GitHub Actions Setup Guide

This guide explains how to set up and use the AI Coding Agent with GitHub Actions using the GEMINI_API_KEY secret.

## Prerequisites

1. **Gemini API Key**: Obtain a Gemini API key from [Google AI Studio](https://aistudio.google.com/)
2. **Repository Access**: Ensure you have admin access to your repository to add secrets
3. **Published Docker Image**: The repository should have the Docker image published to GitHub Container Registry (handled by the existing `docker-publish.yml` workflow)

## Setup Instructions

### 1. Add GEMINI_API_KEY Secret

1. Go to your GitHub repository
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `GEMINI_API_KEY`
5. Value: Your Gemini API key
6. Click **Add secret**

### 2. Example Workflow Usage

The example workflow (`.github/workflows/ai-coding-agent-example.yml`) provides several usage patterns:

#### Manual Trigger (Recommended for Testing)

1. Go to **Actions** tab in your repository
2. Select **AI Coding Agent Example** workflow
3. Click **Run workflow**
4. Configure inputs:
   - **Task description**: What you want the AI agent to do
   - **Approval mode**: 
     - `dry_run`: Preview changes without applying them
     - `ask`: Show changes and require manual approval (not applicable in CI)
     - `auto_edit`: Automatically apply changes and commit them

## Workflow Features

### 1. Repository Analysis
- Analyzes project structure and files
- Provides overview and insights about the codebase

### 2. Code Quality Checks
- Reviews code for potential improvements
- Identifies security issues
- Suggests best practices

### 3. Documentation Review
- Checks if documentation is up to date
- Suggests improvements to README and other docs

### 4. File Modifications
- Can create, modify, or update files based on instructions
- Supports different approval modes for safety

## Safety Considerations

### Approval Modes

- **`dry_run`**: Safest option - only shows what would be changed
- **`ask`**: Shows changes and require manual approval (not practical in CI)
- **`auto_edit`**: Automatically applies changes - use with caution

### Best Practices

1. **Start with `dry_run`**: Always test with dry run mode first
2. **Review Changes**: Carefully review any automated commits
3. **Limit Permissions**: Use branch protection rules for important branches
4. **Monitor Usage**: Keep track of API usage and costs
5. **Specific Instructions**: Provide clear, specific task descriptions

## Example Task Descriptions

### Code Analysis
```
"Analyze the security of the Dockerfile and suggest improvements"
"Review the code for potential bugs and improvements"
"Check if the API follows best practices"
```

### Documentation Tasks
```
"Update README.md to include setup instructions"
"Create a CONTRIBUTING.md file with development guidelines"
"Add documentation for new features"
```

### Code Generation
```
"Create unit tests for the main functions"
"Add error handling to the API endpoints"
"Generate configuration files for deployment"
```

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|--------|----------|
| `Invalid API key` | Wrong or missing GEMINI_API_KEY | Check secret value and name |
| `Permission denied` | Insufficient GitHub token permissions | Ensure GITHUB_TOKEN has required permissions |
| `Image pull failed` | Docker image not published | Wait for docker-publish workflow to complete |
| `No changes detected` | Task already completed or unclear instructions | Provide more specific task description |

## Security Best Practices

1. **Secret Management**: Never hardcode API keys in workflows
2. **Branch Protection**: Use branch protection rules for auto_edit mode
3. **Review Permissions**: Regularly audit repository secrets and permissions
4. **Audit Logs**: Monitor GitHub Actions usage and results
5. **Principle of Least Privilege**: Only grant necessary permissions to workflows
