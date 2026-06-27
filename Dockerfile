FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    python3 \
    python3-pip \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install code-server (VS Code)
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create user
RUN useradd -m coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER coder
WORKDIR /home/coder

# Expose port (HF uses 7860)
EXPOSE 7860

# Start VS Code
CMD ["code-server", "--bind-addr", "0.0.0.0:7860", "--auth", "none"]
