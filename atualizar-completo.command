#!/bin/bash

PROJECT_DIR="$HOME/Library/Mobile Documents/com~apple~CloudDocs/sinestesie-se-final"

cd "$PROJECT_DIR" || { echo "Pasta do projeto não encontrada!"; exit 1; }

echo "Atualizando posts.json com Python..."
python3 - <<EOF
import os
import json

posts_dir = os.path.join(os.path.expanduser("~"), "Library/Mobile Documents/com~apple~CloudDocs/sinestesie-se-final/posts")
post_files = [f for f in os.listdir(posts_dir) if f.endswith(".txt")]

posts_json_path = os.path.join(os.path.expanduser("~"), "Library/Mobile Documents/com~apple~CloudDocs/sinestesie-se-final/posts.json")

with open(posts_json_path, "w", encoding="utf-8") as f:
    json.dump(post_files, f, indent=2, ensure_ascii=False)
print(f"posts.json atualizado com {len(post_files)} arquivos!")
EOF

echo "Preparando para git add, commit e push..."

git add .
echo "Digite a mensagem do commit:"
read msg
git commit -m "$msg"
git push

echo "Tudo feito! Terminal será fechado em 3 segundos..."
sleep 3
exit