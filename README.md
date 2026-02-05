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

The CLI uses your system username to identify requests. Optionally configure:

```bash
# Override user email (default: $USER@hiya.com)
export CARCHARODON_USER="yourname@hiya.com"

# Override API URL (default: https://carcharodon.toolsv3.us-west-2.wtpgs.net)
export CARCHARODON_API_URL="https://custom-api.example.com"
```

## Usage

### Place a Call

```bash
# With explicit phone number
carcharodon call -t +12065551234 -f +18005551234

# Using test number shorthand
carcharodon call -t +12065551234 -f spam
carcharodon call -t +12065551234 -f fraud
carcharodon call -t +12065551234 -f fraud:tax-scam
```

Options:
- `-t, --to` - Destination phone number (E.164 format, required)
- `-f, --from` - Caller ID: E.164 number or shorthand like `spam`, `fraud:tax-scam` (required)
- `--trunk <name>` - SIP trunk: `flowroute` (default), `telnyx`, `bandwidth`
- `--cancel-after <ms>` - Auto-cancel timeout in milliseconds (default: 35000)
- `--wait` - Wait for call to complete before returning

### SIP Trunks

| Trunk | Description |
|-------|-------------|
| `flowroute` | Default trunk for US numbers |
| `telnyx` | Alternative trunk |
| `bandwidth` | Auto-selected for UK (+44) numbers |

```bash
# Use a specific trunk
carcharodon call -t +12065551234 -f spam --trunk telnyx
```

### Test Number Shorthands

Instead of specifying a full phone number for `--from`, use these shortcuts:

| Shorthand | Description |
|-----------|-------------|
| `ok` | Random number with OK reputation |
| `uncertain` | Random uncertain number |
| `spam` | Random spam number |
| `fraud` | Random fraud number |
| `spam:telemarketer` | Spam telemarketer |
| `spam:robocaller` | Spam robocaller |
| `fraud:tax-scam` | Tax scam fraud |
| `fraud:extortion` | Extortion fraud |
| `fraud:tech-support-scam` | Tech support scam |

### List Test Numbers

```bash
# List all test numbers
carcharodon numbers

# Filter by level
carcharodon numbers --level fraud
carcharodon numbers --level spam

# Filter by category
carcharodon numbers --category telemarketer

# Filter by region
carcharodon numbers --region uk
carcharodon numbers --level spam --region us

# Get just phone numbers (for scripting)
carcharodon numbers --level fraud --quiet
```

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
carcharodon call -t +12065551234 -f spam --quiet

# Get full JSON response
carcharodon status -i abc123 --json

# Get list of fraud numbers for scripting
carcharodon numbers --level fraud -q
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
| `CARCHARODON_USER` | User email for API requests | `$USER@hiya.com` |
| `CARCHARODON_API_URL` | API base URL | `https://carcharodon.toolsv3.us-west-2.wtpgs.net` |
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
