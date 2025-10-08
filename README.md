# Sample Dockerized Node.js Project

A production-ready Node.js Express application with comprehensive CI/CD pipeline setup for both Jenkins and GitHub Actions.

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ (or Docker)
- Docker and Docker Compose
- Git

### Local Development
```bash
# Clone the repository
git clone <your-repo-url>
cd sample-app

# Install dependencies
npm install

# Start the application
npm start

# Test the application
curl http://localhost:3000/
```

### Docker Development
```bash
# Build and run with Docker
docker build -t sample-app .
docker run -p 3000:3000 sample-app

# Or use Docker Compose
docker-compose up --build
```

## 🧪 Testing

```bash
# Run tests
npm test

# Run tests with coverage
npm run test:coverage

# Run linting
npm run lint

# Fix linting issues
npm run lint:fix
```

## 🏗️ CI/CD Pipeline

This project supports multiple CI/CD approaches:

### Option 1: GitHub Actions (Recommended)
- **Automatic**: Runs on every push and pull request
- **Features**: Testing, building, security scanning, multi-platform builds
- **Setup**: Just push to GitHub and enable Actions

### Option 2: Jenkins
- **Advanced**: Custom workflows and enterprise integrations
- **Setup**: Follow `JENKINS_SETUP.md` guide
- **Features**: GitHub integration, Docker testing, custom deployments

### Option 3: Hybrid
- Use GitHub Actions for CI
- Use Jenkins for complex deployments

## 📁 Project Structure

```
├── .github/workflows/          # GitHub Actions workflows
├── tests/                      # Test files
├── Dockerfile                  # Docker configuration
├── docker-compose.yml          # Local development
├── docker-compose.jenkins.yml # Jenkins setup
├── Jenkinsfile                 # Jenkins pipeline
├── package.json                # Dependencies and scripts
├── jest.config.js             # Jest configuration
├── .eslintrc.json             # ESLint configuration
├── index.js                   # Main application file
├── setup-github.sh            # Quick setup script
├── GITHUB_INTEGRATION.md      # GitHub setup guide
└── JENKINS_SETUP.md           # Jenkins setup guide
```

## 🔧 Configuration

### Environment Variables
```bash
PORT=3000                    # Server port (default: 3000)
NODE_ENV=production         # Environment mode
```

### Docker Configuration
- **Base Image**: `node:18-alpine`
- **Port**: 3000
- **Health Check**: Built-in endpoint monitoring

## 🛡️ Security Features

- **Dependency Scanning**: `npm audit`
- **Container Scanning**: Trivy integration
- **Code Quality**: ESLint with security rules
- **Input Validation**: Express middleware
- **Error Handling**: Proper error responses

## 📊 Monitoring & Observability

### Health Endpoints
- `GET /` - Application health check
- `GET /error` - Error simulation endpoint

### Logging
- Structured logging with timestamps
- Error tracking and monitoring
- Request/response logging

## 🚀 Deployment

### GitHub Actions Deployment
```yaml
# Automatic deployment on main branch
# Configurable environments (staging, production)
# Multi-platform Docker builds
```

### Jenkins Deployment
```groovy
// Custom deployment stages
// Environment-specific configurations
// Rollback capabilities
```

### Docker Deployment
```bash
# Production deployment
docker run -d \
  --name sample-app \
  -p 3000:3000 \
  -e NODE_ENV=production \
  sample-app:latest
```

## 🔄 CI/CD Pipeline Stages

### 1. Code Quality
- Linting with ESLint
- Code formatting
- Security scanning

### 2. Testing
- Unit tests with Jest
- Integration tests
- Coverage reporting

### 3. Building
- Docker image creation
- Multi-platform builds
- Image optimization

### 4. Security
- Vulnerability scanning
- Container security checks
- Dependency auditing

### 5. Deployment
- Environment-specific deployments
- Health checks
- Rollback capabilities

## 📈 Performance

### Optimizations
- **Docker**: Multi-stage builds for smaller images
- **Node.js**: Production optimizations
- **Dependencies**: Minimal production dependencies
- **Caching**: Docker layer caching

### Metrics
- Build time optimization
- Image size minimization
- Test execution speed
- Deployment frequency

## 🛠️ Development

### Adding New Features
1. Create feature branch
2. Implement changes
3. Add tests
4. Run linting
5. Create pull request
6. CI/CD pipeline runs automatically

### Code Standards
- ESLint configuration
- Jest testing framework
- Docker best practices
- Security-first approach

## 📚 Documentation

- [GitHub Integration Guide](GITHUB_INTEGRATION.md)
- [Jenkins Setup Guide](JENKINS_SETUP.md)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## 📄 License

This project is licensed under the ISC License.

## 🆘 Support

- Check the documentation files
- Review CI/CD pipeline logs
- Open an issue for bugs
- Create discussions for questions

## 🎯 Roadmap

- [ ] Add database integration
- [ ] Implement authentication
- [ ] Add API documentation
- [ ] Set up monitoring dashboard
- [ ] Add performance testing
- [ ] Implement blue-green deployments

---

**Built with ❤️ using modern DevOps practices**
