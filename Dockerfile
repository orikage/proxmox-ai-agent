FROM debian:12-slim

RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    nodejs \
    npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ClaudeCode
RUN npm install -g @anthropic-ai/claude-code

# Gemini CLI
RUN npm install -g @google/gemini-cli

WORKDIR /workspace
ENV HOME=/workspace

COPY scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/pve-*

COPY config/CLAUDE.md /workspace/CLAUDE.md

CMD ["/bin/bash"]
