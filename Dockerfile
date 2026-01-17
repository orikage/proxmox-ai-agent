FROM debian:12-slim

RUN apt-get update && apt-get install -y \
    curl \
    jq \
    git \
    tmux \
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


# Install ttyd
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then \
        curl -L -o /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64; \
    elif [ "$ARCH" = "aarch64" ]; then \
        curl -L -o /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.aarch64; \
    else \
        echo "Unsupported architecture: $ARCH" && exit 1; \
    fi && \
    chmod +x /usr/local/bin/ttyd

COPY config/CLAUDE.md /workspace/CLAUDE.md

ENV TTYD_PORT=7681
CMD ["ttyd", "--writable", "--port", "7681", "tmux", "new", "-A", "-s", "proxy-agent"]
