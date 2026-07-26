# Cloudflared Web UI - Home Assistant Add-on

![Supports amd64 Architecture][amd64-shield]
![Supports aarch64 Architecture][aarch64-shield]
![Supports armv7 Architecture][armv7-shield]

Web UI for managing Cloudflare Tunnels (cloudflared) with a modern Vue.js interface.

## Features

- Web-based interface to manage Cloudflare Tunnels
- Start/stop tunnels from the UI
- Configure tunnel token
- View tunnel status and version
- Advanced configuration for ingress rules
- Optional basic authentication
- Metrics endpoint support

## Installation

1. Add this repository to Home Assistant:
   - Go to **Settings** > **Add-ons** > **Add-on Store**
   - Click the three dots menu in the top right
   - Select **Repositories**
   - Add: `https://github.com/koko004/hassio-repo`

2. Search for "Cloudflared Web UI" in the Add-on Store and install it

3. Configure the Cloudflare Tunnel token in the addon options

## Configuration

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `token` | string | `""` | Cloudflare Tunnel token (from Zero Trust Dashboard) |
| `start` | boolean | `false` | Auto-start tunnel on addon start |
| `webui_port` | port | `14333` | Web UI port |
| `metrics_enable` | boolean | `false` | Enable metrics endpoint |
| `metrics_port` | port | `60123` | Metrics port |
| `basic_auth_user` | string | `admin` | Basic auth username |
| `basic_auth_pass` | password | `""` | Basic auth password (empty = disabled) |
| `edge_bind_address` | string | `""` | Edge bind address |
| `grace_period` | string | `""` | Grace period for connections |
| `region` | string | `""` | Tunnel region |
| `retries` | string | `""` | Number of retries |
| `edge_ip_version` | string | `""` | Edge IP version (4, 6, or auto) |
| `protocol` | string | `""` | Protocol (http2, quic, or auto) |

## Usage

1. Create a tunnel in Cloudflare Zero Trust Dashboard
2. Copy the tunnel token
3. Paste it in the addon configuration under `token`
4. Set `start` to `true` to auto-start the tunnel
5. Access the Web UI at `http://homeassistant.local:14333`

## Advanced Configuration

You can also configure custom ingress rules via the Advanced tab in the Web UI, which will be saved to `/config/config.yml`.

## Source Code

Based on: https://github.com/WisdomSky/Cloudflared-web

[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg