#!/bin/sh
set -e

MODEL="${MODEL:-smollm:135m}"
PORT="${PORT:-11434}"

export OLLAMA_HOST="0.0.0.0:${PORT}"

ollama serve &
OLLAMA_PID=$!

echo "Waiting for ollama to start..."
until ollama list > /dev/null 2>&1; do
  sleep 1
done

echo "Pulling model: ${MODEL}"
ollama pull "${MODEL}"

echo "Ollama ready on port ${PORT}"
wait $OLLAMA_PID
