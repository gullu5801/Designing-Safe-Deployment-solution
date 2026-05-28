# Designing Safe Deployment - Instructor Solution

This repository serves as the instructor reference implementation for the **Designing Safe Deployment Pipeline Stages** lesson in Module 3 (Docker & Kubernetes Concepts).

It repairs the unsafe CI/CD workflow from the student exercise and implements a production-grade, staged deployment pipeline.

## Features of the Solution

- **Sequential Pipeline Stages:** Strict isolation between Source, Build, Test, Security, Staging, and Production stages.
- **Release Gating:** Security scans, testing, and staging verifications must pass before production deployment.
- **Environment Protections:** Production deployments are gated by environments (`github.ref` conditions).
- **Operational Visibility:** Explicit echoing of commit SHAs, timestamps, and stage statuses for debugging.

## Pipeline Architecture

The `.github/workflows/deploy.yml` workflow enforces:

1. **Source & Build**: Checks out code, sets up Node, installs dependencies cleanly with `npm ci`, and caches node modules.
2. **Test**: Gated by build. Runs unit and integration tests.
3. **Security**: Gated by build. Runs `npm audit` and Trivy secret/filesystem scanning.
4. **Deploy-Staging**: Gated by test & security. Deploys to a staging environment.
5. **Verify**: Gated by staging. Executes smoke tests and health checks against the staging environment.
6. **Deploy-Production**: Gated by verify. Final production release.

## Usage

This repository is for instructor reference and should be used to evaluate student submissions or demonstrate a proper solution.
