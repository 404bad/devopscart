0. This dev project is not mine.. i just cloned it from github and what i will do here it to devopsified it.
1. running the next js app locally first 
2. Wrote a basic ci pipeline for the next js app

```yml
name: DevOps cart CI

on:
  push:
   branches:
     - main
    
jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository on the runner
        uses: actions/checkout@v6

      - name: Setup node version 20 in the runner
        uses: actions/setup-node@v6
        with:
          node-version: 20
        
      - name: Install the dependecies
        run: npm ci

      # - name: Linting to analyze source code for potential problems without running it.
      #   run: npm run lint

      - name: Build the project to generate an artifact.
        run: npm run build
      
      - name: Show build output directory
        run: |
          echo "Build output directory: .next"
          ls -la .next
```

4. Added env vars in the github secrets and vars and use it in the pipeline

