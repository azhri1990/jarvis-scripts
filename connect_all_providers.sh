#!/data/data/com.termux/files/usr/bin/bash

# ==============================================
# BULK CONNECT ALL PROVIDERS IN OMNROUTE
# ==============================================

OMNIROUTE_URL="http://localhost:20128"
API_KEY="sk-5f238e76072d7926-92e57f-f18174b2"

# List of free providers to connect
providers=(
  "kiro-ai"
  "cloudflare-ai"
  "longcat"
  "pollinations"
  "qoder"
  "opencode-free"
  "ai-horde"
  "deepseek"
  "groq"
  "nvidia-nim"
  "cerebras"
  "cohere"
  "mistral"
  "openrouter"
  "gemini"
  "claude"
)

echo "🚀 Starting bulk provider connection..."
echo "========================================"

for provider in "${providers[@]}"; do
    echo "📡 Connecting $provider..."
    
    # Try to connect the provider via OmniRoute API
    response=$(curl -s -X POST "$OMNIROUTE_URL/api/providers/$provider/connect" \
        -H "Content-Type: application/json" \
        -H "Authorization: Bearer $API_KEY" \
        -d '{}')
    
    if echo "$response" | grep -q "connected\|success"; then
        echo "✅ $provider connected successfully"
    else
        echo "⚠️ $provider: $(echo "$response" | cut -c1-100)"
    fi
    
    sleep 1
done

echo ""
echo "========================================"
echo "✅ Bulk connection complete!"
echo ""
echo "📋 To see all connected providers:"
echo "   curl $OMNIROUTE_URL/api/providers -H 'Authorization: Bearer $API_KEY'"
