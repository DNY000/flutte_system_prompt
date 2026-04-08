# Showcase: resolve then build

1. Resolve a route from a query (PowerShell):

```powershell
.\aiprompt.ps1 resolve -Query "design login screen Flutter"
```

2. Build a prompt package:

```powershell
.\aiprompt.ps1 build -Query "design login screen Flutter" -Goal "Login screen Material 3"
```

3. TypeScript runtime (from repo root):

```bash
cd tools/prompt-runtime-ts && npm install && npm run build
node dist/index.js --command plan --query "design auth module architecture Flutter"
```
