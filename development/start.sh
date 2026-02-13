#!/bin/bash

# code-server'ı 9090 portunda background'da başlat
code-server --bind-addr 0.0.0.0:9090 --auth password --cert false &

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

# Container'ı ayakta tut
sleep infinity
