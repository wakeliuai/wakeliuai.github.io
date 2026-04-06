# Automated Morning Briefing
# This script runs at 6:30 AM to send a Telegram message.
# Requires gateway active and agent session bound to Telegram.

if [ "$(date +%H:%M)" = "06:30" ]; then
    # 1. Fetch News/Stocks
    # 2. Format message
    # 3. Deliver to Telegram via gateway
    /opt/homebrew/opt/node/bin/node /opt/homebrew/lib/node_modules/openclaw/dist/index.js message \
    --text "早安老爺！這是今天的早報：$(/opt/homebrew/opt/node/bin/node /opt/homebrew/lib/node_modules/openclaw/dist/index.js exec --command 'fetch_news_and_stocks')" \
    --channel "telegram" \
    --to "1225909090"
fi
