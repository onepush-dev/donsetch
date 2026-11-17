# DonSeTch on Railway

[DonSeTch](https://github.com/dondai44423/donsetch) (AGPL-3.0) — a web access MCP server for AI agents in one Rust binary: `web_fetch` (URL to clean markdown, PDFs, in-process JS), keyless `web_search` aggregation, `web_crawl` site digests, plus OCR. No API keys required. Deploy it on Railway with one click and point any MCP client at it over streamable HTTP.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/deploy/TEMPLATE_CODE)

## What this template runs

- **donsetch**: `ghcr.io/onepush-dev/donsetch:5.5.4`, the official v5.5.4 Linux release binary (sha256-verified, unmodified) on `debian:trixie-slim`, started as `donsetch mcp` in HTTP mode. Public HTTPS domain on port 8080, healthcheck `/health`, MCP endpoint `/mcp`, volume at `/data` (fetch/search cache and learned per-site routes).

## Variables

| Variable | Value | Notes |
|---|---|---|
| `DONSETCH_HTTP_TOKEN` | generated secret | Bearer token required on `/mcp`. `/health` stays open for probes. |

Baked into the image: `DONSETCH_TRANSPORT=http`, `DONSETCH_HTTP_HOST=0.0.0.0`, `DONSETCH_HTTP_PORT=8080`, `XDG_CACHE_HOME=/data/cache`.

## How to use

1. Deploy, then copy `DONSETCH_HTTP_TOKEN` from the service's Variables.
2. Add a remote MCP server in your client: URL `https://<your-domain>/mcp`, header `Authorization: Bearer <token>`.
   - Claude Code: `claude mcp add --transport http donsetch https://<your-domain>/mcp --header "Authorization: Bearer <token>"`
3. Ask your agent to search, fetch or crawl the web.

## Notes

- `web_screenshot` needs Chrome, which is not included (its sandbox needs user namespaces that containers do not provide).
- Requests leave from a datacenter IP, so some sites show more bot walls than from a home connection. Optional search providers and proxies can be configured with DonSeTch's env vars (see upstream docs).
- Not affiliated with DonSeTch.
