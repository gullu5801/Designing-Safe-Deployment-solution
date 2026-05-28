# Deployment Safety Analysis

This document outlines the fatal flaws present in the original (broken) pipeline and how they violated production safety standards.

## 1. Unsafe Deployment Order
**The Flaw**: The original pipeline likely deployed to production immediately, running tests and security scans in parallel (or entirely missing them).
**The Risk**: A broken build or insecure code could easily be pushed to production, resulting in immediate downtime or security breaches.
**The Fix**: Strict linear dependencies using `needs:` where the deployment relies on `test` and `security` stages.

## 2. Missing Validation Stages
**The Flaw**: No staging environment or verification step before production.
**The Risk**: "Works on my machine" bugs passing unit tests but failing in a real-world deployed state.
**The Fix**: Introduced `deploy-staging` followed by a `verify` job that runs health checks on the staging server before promoting to production.

## 3. Lack of Operational Visibility
**The Flaw**: Silent failures and lack of traceability.
**The Risk**: When deployments failed, engineers couldn't identify the commit, time, or exact point of failure easily.
**The Fix**: Explicit echoing of commit SHAs and timestamps in the deployment jobs.

## 4. Artifact Inconsistency
**The Flaw**: Re-installing dependencies using `npm install` rather than using cached, deterministic builds.
**The Risk**: Tests might pass with one set of sub-dependencies, but the deployment might use slightly different ones due to floating versions.
**The Fix**: Used `npm ci` and caching across jobs to ensure the exact same `node_modules` tree is used.
