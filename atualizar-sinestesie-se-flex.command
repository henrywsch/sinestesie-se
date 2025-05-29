#!/bin/bash
echo "🗂️ Escolha a pasta do seu projeto (sinestesie-se-final)..."
project_path=$(osascript -e 'POSIX path of (choose folder with prompt "Selecione a pasta do projeto sinestesie-se-final:")')
cd "$project_path" || exit

echo "📦 Atualizando site sinestesie-se..."
git add .
echo "✍️ Escreva a mensagem do commit (ex: novo post, ajustes, etc):"
read msg
git commit -m "$msg"
git push
echo "✅ Site atualizado com sucesso!"
sleep 2
exit
