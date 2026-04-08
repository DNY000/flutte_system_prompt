# Design Prompt Templates

Use these templates when the design route needs concrete prompt structure instead of a loose request.

These templates are inferred from current Flutter adaptive design guidance, Material navigation and state guidance, and Apple platform interaction guidance. Use them as prompt scaffolds, not as rigid forms.

## 1. Screen Design Prompt

Use when:

- designing one screen or one flow entry screen
- the request needs hierarchy, states, actions, and Flutter composition guidance

```text
Design a Flutter screen for:
- user goal:
- screen purpose:
- primary action:
- secondary actions:
- critical content:
- platform scope: phone / tablet / desktop-like / web
- input modes: touch / keyboard / mouse
- design-system or brand constraints:
- implementation constraints:
- accessibility constraints:

The response must:
- prioritize structure before colors or style
- define the top-level layout and navigation pattern
- define loading, empty, error, success, disabled, and offline states where relevant
- explain how the layout adapts across screen sizes or input modes
- map the final design to concrete Flutter widgets and layout primitives
- call out risks such as overflow, focus order, tap target size, or state complexity
```

## 2. Design System Prompt

Use when:

- designing shared primitives, tokens, or component rules
- the request is larger than one screen

```text
Design a Flutter design-system direction for:
- product type:
- brand tone:
- current UI problems:
- shared components in scope:
- token scope: color / typography / spacing / radius / elevation / motion
- platform scope:
- accessibility and localization constraints:
- implementation ownership: app theme / shared widgets / feature wrappers

The response must:
- define the visual system and token ownership
- decide what stays as raw Material/Cupertino usage versus shared app primitives
- define component states such as default, hover, focus, pressed, disabled, loading, destructive, and success when relevant
- show how the system scales across phone, tablet, and desktop-like surfaces
- map the system to Flutter theme and component primitives
- identify governance risks such as duplication, one-off styling, or unstable component contracts
```

## 3. Responsive Redesign Prompt

Use when:

- an existing screen works on one device class but breaks on others
- adaptation rules are the main issue

```text
Redesign this Flutter screen for responsive and adaptive use:
- current screen:
- current layout problems:
- target device classes:
- required parity across platforms:
- navigation context:
- critical content that must stay visible:
- interaction risks:

The response must:
- explain what should stay shared versus what should adapt by screen size or input model
- define layout changes for narrow, medium, and wide widths
- define navigation changes such as bottom navigation, navigation rail, side panels, or dialog/sheet use
- explain accessibility and keyboard/focus implications
- end with a Flutter composition plan
```

## 4. Component Prompt

Use when:

- one component needs a detailed spec before implementation
- state behavior is more important than full-screen composition

```text
Design a reusable Flutter component:
- component name:
- user action or purpose:
- content inputs:
- states required:
- icon/image needs:
- size and density expectations:
- platform scope:
- accessibility constraints:
- implementation constraints:

The response must:
- define the component structure and content hierarchy
- define all required states and transitions
- specify when to use this component and when not to use it
- map the design to Flutter widgets
- call out any design-system token dependencies
```

## 5. Critique And Redesign Prompt

Use when:

- reviewing an existing screen and proposing improvements
- the request is half audit, half redesign

```text
Critique and redesign this Flutter screen:
- current screen purpose:
- current issues:
- target users:
- target platforms:
- business goal:
- non-goals:

The response must:
- identify the main usability, hierarchy, and state problems first
- propose a revised structure and interaction model
- explain responsive/adaptive changes
- include accessibility corrections
- map the redesign to Flutter composition
```

## Design Brief Checklist

Before sending a design request, try to name:

- user goal
- primary action
- must-see content
- state coverage
- navigation context
- screen sizes or platform scope
- input modes
- accessibility constraints
- brand or design-system constraints
- implementation constraints

## Common Failure Modes

- asking for “a beautiful screen” without user goal or primary action
- asking for style before hierarchy
- forgetting error, empty, disabled, or offline states
- ignoring wide-screen, keyboard, or mouse behavior when desktop or web is in scope
- not asking for Flutter composition mapping at the end
