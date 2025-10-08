# Jenkins Testing Setup Guide

## Prerequisites

- Docker and Docker Compose installed
- Git repository (local or remote)
- Basic understanding of CI/CD concepts

## Installation Steps

### 1. Install Jenkins using Docker Compose

```bash
# Start Jenkins with Docker support
docker-compose -f docker-compose.jenkins.yml up -d

# Check if Jenkins is running
docker ps | grep jenkins
```

### 2. Access Jenkins Web Interface

- Open browser and navigate to: `http://localhost:8080`
- Get initial admin password:
```bash
docker exec jenkins-master cat /var/jenkins_home/secrets/initialAdminPassword
```

### 3. Install Required Jenkins Plugins

After initial setup, install these plugins:
- **Pipeline** (usually pre-installed)
- **Docker Pipeline**
- **Git**
- **NodeJS**
- **HTML Publisher** (for test reports)
- **Cobertura** (for coverage reports)

### 4. Configure Jenkins Global Tools

1. Go to **Manage Jenkins** → **Global Tool Configuration**
2. Configure:
   - **NodeJS**: Install latest LTS version
   - **Docker**: Use system Docker installation

### 5. Create New Pipeline Job

1. Click **New Item**
2. Enter job name: `sample-app-pipeline`
3. Select **Pipeline**
4. Click **OK**

### 6. Configure Pipeline

1. In **Pipeline** section:
   - **Definition**: Pipeline script from SCM
   - **SCM**: Git
   - **Repository URL**: Your repository URL
   - **Branch**: `*/main` (or your main branch)
   - **Script Path**: `Jenkinsfile`

2. Click **Save**

### 7. Run the Pipeline

1. Click **Build Now**
2. Monitor the build progress in **Console Output**

## Pipeline Stages Explained

The Jenkinsfile includes these stages:

1. **Checkout**: Downloads source code
2. **Install Dependencies**: Runs `npm install`
3. **Run Tests**: Executes Jest test suite
4. **Security Scan**: Runs `npm audit`
5. **Build Docker Image**: Creates Docker image
6. **Test Docker Container**: Tests container functionality
7. **Integration Tests**: End-to-end testing
8. **Cleanup**: Removes test containers

## Testing Commands

### Local Testing (before Jenkins)

```bash
# Install dependencies
npm install

# Run tests
npm test

# Run tests with coverage
npm run test:coverage

# Run linting
npm run lint

# Build Docker image
docker build -t sample-app .

# Test Docker container
docker run -d -p 3000:3000 --name test-container sample-app
curl http://localhost:3000/
docker stop test-container && docker rm test-container
```

### Docker Compose Testing

```bash
# Run tests using docker-compose
docker-compose up --build

# Run only tests
docker-compose run test

# Clean up
docker-compose down
```

## Troubleshooting

### Common Issues

1. **Docker Permission Denied**
   ```bash
   sudo usermod -aG docker $USER
   # Logout and login again
   ```

2. **Jenkins Cannot Access Docker**
   - Ensure Jenkins container has Docker socket mounted
   - Check Docker daemon is running

3. **Tests Failing**
   - Check test files are in correct location
   - Verify all dependencies are installed
   - Check Jest configuration

4. **Port Conflicts**
   - Change port mappings in docker-compose files
   - Update Jenkinsfile if needed

### Useful Jenkins Commands

```bash
# View Jenkins logs
docker logs jenkins-master

# Restart Jenkins
docker-compose -f docker-compose.jenkins.yml restart jenkins

# Access Jenkins shell
docker exec -it jenkins-master bash

# Backup Jenkins configuration
docker cp jenkins-master:/var/jenkins_home ./jenkins-backup
```

## Security Considerations

1. **Change default admin password**
2. **Enable HTTPS** for production
3. **Configure proper user permissions**
4. **Regular security updates**
5. **Secure Docker socket access**

## Next Steps

1. Set up webhook for automatic builds on Git push
2. Configure email notifications for build failures
3. Add more comprehensive test coverage
4. Implement deployment stages
5. Add performance testing
6. Set up monitoring and alerting

## File Structure

```
project/
├── Jenkinsfile                 # Main CI/CD pipeline
├── docker-compose.yml         # Application testing
├── docker-compose.jenkins.yml # Jenkins setup
├── package.json               # Updated with test scripts
├── jest.config.js            # Jest configuration
├── .eslintrc.json           # ESLint configuration
├── tests/
│   └── app.test.js          # Application tests
└── README.md                # This documentation
```
