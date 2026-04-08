# Prompt CLI

This CLI packages the Dart/Flutter prompt system into terminal commands.

## Entry Point

From the repository root:

```powershell
.\aiprompt.ps1 help
```

## Commands

### List routes

```powershell
.\aiprompt.ps1 list-routes
```

### Resolve a route from a raw query

```powershell
.\aiprompt.ps1 resolve -Query "design giao dien login"
```

### Show route metadata

```powershell
.\aiprompt.ps1 show-route -RouteId design-screen
```

### Build a prompt package from a route

```powershell
.\aiprompt.ps1 build `
  -RouteId design-screen `
  -Goal "Design login screen for Flutter" `
  -Scope "Mobile first" `
  -Constraints "Use Material 3","Support loading, error, empty states"
```

### Build a prompt package from a raw query

```powershell
.\aiprompt.ps1 build `
  -Query "design giao dien login" `
  -Goal "Design login screen for Flutter" `
  -Related "lib/features/auth/presentation/login_screen.dart" `
  -Constraints "Use Material 3","Support tablet" `
  -DefinitionOfDone "Return design-spec-v1 only" `
  -OutputPath ".out/login-prompt.md" `
  -Clipboard
```

### Flutter decision examples

```powershell
.\aiprompt.ps1 resolve -Query "khi nao dung initState didChangeDependencies didUpdateWidget dispose"
.\aiprompt.ps1 build -Query "khi nao dung navigator hay go router"
.\aiprompt.ps1 resolve -Query "nen dung provider hay riverpod"
.\aiprompt.ps1 build -Query "khi nao dung secure storage hay sharedpreferences"
.\aiprompt.ps1 build -Query "khi nao dung listview builder thay vi singlechildscrollview"
.\aiprompt.ps1 build -Query "khi nao dung repository hay use case"
.\aiprompt.ps1 build -Query "to chuc code flutter theo feature nhu the nao"
```

### AI system examples

```powershell
.\aiprompt.ps1 resolve -Query "lam sao toi uu prompt cho he thong nay"
.\aiprompt.ps1 build -Query "thiet ke he thong ai agent cho du an"
.\aiprompt.ps1 build -Query "xay benchmark va regression test cho prompt"
```

## Useful Options

- `-ExtraContextFiles`
  Add extra local context files into the generated package.
- `-Memory decisions patterns mistakes`
  Inject memory files into the package.
- `-IncludeReferences`
  Attach the source map for research-heavy prompts.
- `-SkipProjectContext`
  Omit `project-context.md` when you want a smaller package.

## Default Behavior

- `build` loads only the files needed for the chosen route.
- `resolve` uses normalized query matching so Vietnamese text with or without accents can still match.
- architecture, testing, performance, security, CI/CD, and Flutter decision routes load `decision-engine` plus only the matching Flutter docs section and leaf packs.
- AI-system routes can load dedicated context files from `08-guides/ai-systems/`.
- output can be printed, written to a file, or copied to the clipboard.
