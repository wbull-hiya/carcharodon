# Carcharodon CLI

Command-line interface for the Carcharodon spoofed call API.

## Installation

### Homebrew (recommended)

```bash
brew tap wbull/tap
brew install carcharodon
```

### Manual Installation

```bash
git clone https://github.com/wbull/carcharodon.git
cd carcharodon
chmod +x carcharodon
ln -s "$(pwd)/carcharodon" /usr/local/bin/carcharodon
```

## Configuration

Set your API key as an environment variable:

```bash
export CARCHARODON_API_KEY="your_api_key_here"
```

Optionally, configure a custom API URL:

```bash
export CARCHARODON_API_URL="https://api.example.com"
```

## Usage

### Place a Call

```bash
carcharodon call -t +12065551234 -f +18005551234
```

Options:
- `-t, --to` - Destination phone number (E.164 format, required)
- `-f, --from` - Caller ID to display (E.164 format, required)
- `--cancel-after <ms>` - Auto-cancel timeout in milliseconds (default: 35000)
- `--wait` - Wait for call to complete before returning

### Check Call Status

```bash
carcharodon status -i <call_id>
```

### Cancel a Call

```bash
carcharodon cancel -i <call_id>
```

### View SIP Timestamps

```bash
carcharodon timestamps -i <call_id>
```

## Output Options

All commands support:
- `--json` - Output raw JSON response
- `--quiet, -q` - Minimal output (just the essential value)

Examples:

```bash
# Get just the call ID
carcharodon call -t +12065551234 -f +18005551234 --quiet

# Get full JSON response
carcharodon status -i abc123 --json
```

## Shell Completions

### Bash

Add to your `~/.bashrc`:

```bash
source /path/to/carcharodon/completions/carcharodon.bash
```

### Zsh

Add to your `~/.zshrc`:

```bash
fpath=(/path/to/carcharodon/completions $fpath)
autoload -Uz compinit && compinit
```

## Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `CARCHARODON_API_KEY` | API key for authentication | (required) |
| `CARCHARODON_API_URL` | API base URL | `https://api.carcharodon.dev` |
| `NO_COLOR` | Disable colored output | (unset) |

## Dependencies

- `curl` - HTTP client
- `jq` - JSON processor

Install with Homebrew:

```bash
brew install curl jq
```

## License

MIT License - see [LICENSE](LICENSE) for details.
