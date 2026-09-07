#!/data/data/com.termux/files/usr/bin/bash
for repo in jarvis-mega-repo my-automator PocketStrike-AI jarvis-unified jarvis-boot omniroute-config llama-cpp-config termux-config jarvis-scripts; do
    if [ -d ~/$repo ]; then
        cd ~/$repo
        echo "📁 $repo"
        git pull 2>/dev/null
        git push 2>/dev/null
    fi
done
