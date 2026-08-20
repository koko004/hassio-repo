# hassio-repo
[![Open your Home Assistant instance and show the add app repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https://github.com/koko004/hassio-repo)

Home Assistant Add-on Repository by [koko004](https://github.com/koko004)

## Add-ons

### [Cloudflared Web UI](./cloudflared-web)
Web UI for managing Cloudflare Tunnels (cloudflared) with a modern Vue.js interface.

- **Architectures**: amd64, aarch64, armv7
- **Ports**: 14333 (Web UI), 60123 (Metrics)
- **Features**: Tunnel management, token configuration, ingress rules, basic auth, metrics
- **Source**: Based on [WisdomSky/Cloudflared-web](https://github.com/WisdomSky/Cloudflared-web)

### [WallAlert Bot](./wallalert-bot)
Telegram bot for searching Wallapop articles with price drop notifications.

- **Architectures**: amd64
- **Features**: Search management via Telegram, price drop alerts, new listing notifications
- **Source**: [koko004/wallalert-bot](https://github.com/koko004/wallalert-bot)

### [Network UPS Tools (netxml-ups)](./NUTS-netxml-ups)
Custom NUT addon with netxml-ups driver for Eaton UPS. Compiles netxml-ups from source since it was dropped from the official NUT addon.

- **Architectures**: amd64
- **Ports**: 3493/tcp (NUT Server)
- **Features**: netxml-ups driver support, Eaton UPS monitoring
- **Source**: Based on Network UPS Tools v2.8.5

## Installation

1. Open Home Assistant
2. Go to **Settings** → **Add-ons** → **Add-on Store**
3. Click the **⋮** menu (top right) → **Repositories**
4. Add: `https://github.com/koko004/hassio-repo`
5. Click **Add**
6. Refresh the Add-on Store - you'll see the add-ons above

## Support

- Issues: [GitHub Issues](https://github.com/koko004/hassio-repo/issues)
- Each addon has its own configuration - check the individual addon's README for details
