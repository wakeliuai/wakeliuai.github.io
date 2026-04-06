#!/bin/bash
# Script to send messages sequentially with delay
/opt/homebrew/opt/node/bin/node /opt/homebrew/lib/node_modules/openclaw/dist/index.js message --text "第一則：自動化任務進度正常。" --channel "telegram" --to "1225909090"
sleep 5
/opt/homebrew/opt/node/bin/node /opt/homebrew/lib/node_modules/openclaw/dist/index.js message --text "第二則：AgentMail 已在後台監聽。" --channel "telegram" --to "1225909090"
sleep 5
/opt/homebrew/opt/node/bin/node /opt/homebrew/lib/node_modules/openclaw/dist/index.js message --text "第三則：所有系統檢查完畢。" --channel "telegram" --to "1225909090"
