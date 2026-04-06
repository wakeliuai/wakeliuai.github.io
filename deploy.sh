#!/bin/bash
echo "🚀 Building site..."
python3 build.py
echo "📦 Committing and pushing to GitHub..."
git add .
git commit -m "Auto-deploy: new blog content"
git push origin main
echo "✅ Deployment complete!"
