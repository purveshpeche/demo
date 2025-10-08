#!/bin/bash

# GitHub Integration Setup Script
# This script helps you quickly set up GitHub integration for your project

set -e

echo "🚀 GitHub Integration Setup Script"
echo "=================================="

# Check if git is initialized
if [ ! -d ".git" ]; then
    echo "📁 Initializing Git repository..."
    git init
    git branch -M main
fi

# Check if remote is set
if ! git remote get-url origin >/dev/null 2>&1; then
    echo "🔗 Please set your GitHub repository URL:"
    read -p "Enter GitHub repository URL: " REPO_URL
    git remote add origin "$REPO_URL"
fi

# Check if we're in the right directory
if [ ! -f "package.json" ] || [ ! -f "Dockerfile" ]; then
    echo "❌ Error: Please run this script from your project root directory"
    exit 1
fi

echo "✅ Project structure verified"

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Test the application
echo "🧪 Testing application..."
node index.js &
APP_PID=$!
sleep 2

if curl -f http://localhost:3000/ >/dev/null 2>&1; then
    echo "✅ Application is working correctly"
    kill $APP_PID
else
    echo "❌ Application test failed"
    kill $APP_PID
    exit 1
fi

# Test Docker build
echo "🐳 Testing Docker build..."
if docker build -t sample-app . >/dev/null 2>&1; then
    echo "✅ Docker build successful"
else
    echo "❌ Docker build failed"
    exit 1
fi

# Create .gitignore if it doesn't exist
if [ ! -f ".gitignore" ]; then
    echo "📝 Creating .gitignore..."
    cat > .gitignore << EOF
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*
coverage/
.env
.env.local
.env.development.local
.env.test.local
.env.production.local
.DS_Store
*.log
EOF
fi

# Commit all changes
echo "💾 Committing changes..."
git add .
git commit -m "Add CI/CD pipeline and GitHub integration" || echo "No changes to commit"

echo ""
echo "🎉 Setup Complete!"
echo "=================="
echo ""
echo "Next steps:"
echo "1. Push to GitHub: git push -u origin main"
echo "2. Enable GitHub Actions in your repository"
echo "3. Configure any required secrets in GitHub"
echo "4. Set up branch protection rules"
echo ""
echo "Files created:"
echo "- .github/workflows/ci-cd.yml (GitHub Actions)"
echo "- Jenkinsfile (Jenkins pipeline)"
echo "- GITHUB_INTEGRATION.md (Setup guide)"
echo "- JENKINS_SETUP.md (Jenkins guide)"
echo ""
echo "Your project is now ready for professional CI/CD! 🚀"
