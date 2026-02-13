#!/bin/bash

# Ensure config directory exists
mkdir -p /home/frappe/.config/code-server

# Create/overwrite config.yaml with correct settings (port 9090)
cat > /home/frappe/.config/code-server/config.yaml << 'EOF'
bind-addr: 0.0.0.0:9090
auth: password
cert: false
EOF

echo "📝 Created config.yaml with port 9090"

# Start code-server on port 9090 in background with workspace
code-server --bind-addr 0.0.0.0:9090 --auth password --cert false /workspace/development &

echo "🚀 code-server started on http://localhost:9090"
echo "📝 Use PASSWORD environment variable to set password"
echo ""
echo "💡 Frontend Development:"
echo "   - kta_employee: cd apps/kta_employee/frontend && yarn dev"
echo "   - Vite will run on http://localhost:8080"
echo ""
echo "🔧 Frappe Backend:"
echo "   - bench start (runs on http://localhost:8000)"
echo ""

# Keep container running
sleep infinity
