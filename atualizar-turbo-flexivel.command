#!/bin/bash

echo "Selecione a pasta do projeto sinestesie-se-final:"
project_path=$(osascript -e 'POSIX path of (choose folder with prompt "Selecione a pasta do projeto sinestesie-se-final:")')
project_path="${project_path%/}"

cd "$project_path" || { echo "Pasta do projeto não encontrada!"; exit 1; }

echo "Atualizando posts.json com Python..."
/usr/bin/env python3 <<EOF
import os, json

project_path = """$project_path"""
posts_dir = os.path.join(project_path, "posts")
print(f"Verificando pasta: {posts_dir}")

try:
    post_files = [f for f in os.listdir(posts_dir) if f.endswith(".txt")]
except FileNotFoundError:
    print("⚠️  ERRO: Pasta 'posts' não encontrada. Verifique o caminho.")
    exit(1)

posts_json_path = os.path.join(project_path, "posts.json")

with open(posts_json_path, "w", encoding="utf-8") as f:
    json.dump(post_files, f, indent=2, ensure_ascii=False)

print(f"✅ posts.json atualizado com {len(post_files)} arquivos.")
EOF

echo "Preparando para git add, commit e push..."

git add .
echo "Digite a mensagem do commit:"
read msg
git commit -m "$msg"
git push

echo "✨ Tudo feito! Terminal será fechado em 3 segundos..."
sleep 3
exit