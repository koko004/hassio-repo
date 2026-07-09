# WallAlert Bot - Home Assistant Add-on

Bot de Telegram para buscar artículos en Wallapop.

## Características

- Notifica cuando encuentra artículos que coincidan con tus búsquedas
- Avisa cuando algún artículo baja de precio
- Permite gestionar tu lista de búsquedas desde Telegram

## Instalación

1. Añade este repositorio a Home Assistant:
   - Ve a **Configuración** > **Add-ons** > **Add-on Store**
   - Haz clic en los tres puntos del menú superior derecho
   - Selecciona **Repositorios**
   - Añade: `https://github.com/koko004/hassio-repo`

2. Busca "WallAlert Bot" en el Add-on Store e instálalo

3. Configura el token del bot de Telegram en las opciones del addon

## Configuración

| Opción | Tipo | Descripción |
|--------|------|-------------|
| `bot_token` | string | Token del bot de Telegram (obtenido de @BotFather) |

## Uso del Bot

### Comandos disponibles

- `/help` - Muestra la ayuda
- `/add búsqueda,min-max` - Añadir una búsqueda
  - Ejemplo: `/add zapatos rojos,5-25`
- `/del búsqueda` - Eliminar una búsqueda
  - Ejemplo: `/del zapatos rojos`
- `/lis` - Listar todas las búsquedas activas

## Código fuente

https://github.com/koko004/wallalert-bot
