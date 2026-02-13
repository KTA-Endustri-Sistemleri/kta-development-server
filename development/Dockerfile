FROM frappe/bench:latest

USER root

# code-server kurulumu
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Node.js 18.x ve yarn (frontend dev için)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g yarn

# Gerekli development araçları
RUN apt-get update && \
    apt-get install -y \
    git \
    vim \
    tmux \
    htop \
    jq \
    && rm -rf /var/lib/apt/lists/*

# frappe kullanıcısına geri dön
USER frappe

# code-server config dizini
RUN mkdir -p /home/frappe/.config/code-server

# Varsayılan config (9090 portu - 8080 Vite için ayrıldı)
RUN echo "bind-addr: 0.0.0.0:9090\nauth: password\ncert: false" > /home/frappe/.config/code-server/config.yaml

WORKDIR /workspace/development

# Helper scripts
COPY start.sh /usr/local/bin/start.sh
COPY dev-frontend.sh /usr/local/bin/dev-frontend

USER root
RUN chmod +x /usr/local/bin/start.sh /usr/local/bin/dev-frontend
USER frappe

CMD ["/usr/local/bin/start.sh"]
