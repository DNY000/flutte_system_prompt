# API And Network Domain

## Use For

- API client structure
- repository boundaries
- DTO vs domain models
- retries, interceptors, auth propagation
- network ownership

## Default Decisions

- keep network clients in infrastructure or data layer
- map DTOs before they leak into domain or UI
- use repositories to hide data-source details from callers
- centralize auth headers, retries, and logging policies
- keep request orchestration out of widgets

## Decision Switches

- if the question is transport and client setup, stay in data layer
- if the question is package choice for HTTP client, consult `package-governance`
- if caching and persistence are central, combine with `storage`
