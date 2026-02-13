FROM frappe/bench:latest

USER root

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Install Node.js 18.x and yarn (for frontend development)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Install required development tools
RUN apt-get update && \
    apt-get install -y \
    git \
    vim \
    tmux \
    htop \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Switch back to frappe user
USER frappe

# Create code-server directories with proper permissions
RUN mkdir -p /home/frappe/.config/code-server && \
    mkdir -p /home/frappe/.local/share/code-server

# Default config (port 9090 - 8080 reserved for Vite)
RUN echo -e "bind-addr: 0.0.0.0:9090\nauth: password\ncert: false" > /home/frappe/.config/code-server/config.yaml

WORKDIR /workspace/development

# Helper scripts
COPY start.sh /usr/local/bin/start.sh
COPY dev-frontend.sh /usr/local/bin/dev-frontend

USER root
RUN chmod +x /usr/local/bin/start.sh /usr/local/bin/dev-frontend
USER frappe

CMD ["/usr/local/bin/start.sh"]
