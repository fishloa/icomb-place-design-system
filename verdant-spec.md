# Verdant UI — Design System Specification

> **Purpose**: This document is a reusable prompt/instruction for any Claude session to build SvelteKit applications using the Verdant UI design system. Paste this into any new conversation to get consistent, polished results.

---

## 1. Overview

**Verdant UI** is a dark-theme, glassmorphism-based design system for SvelteKit apps. It was originally inspired by the [Horti plant management app](https://horti.icomb.place/plants) and refined into a general-purpose framework.

### Hosted Assets (CDN)

The design system is hosted at `https://icomb.place/design-system/` and consists of three CSS files:

| File | Purpose |
|------|---------|
| `verdant-tokens.css` | Pure CSS custom properties (colours, typography, spacing, shadows, animations) |
| `verdant-base.css` | Reset, glass utilities, animations, component classes (`.vui-btn`, `.vui-card`, etc.) |
| `verdant-tailwind.css` | `@theme` block mapping tokens → Tailwind v4 utility classes |

**Minimal setup (any project)**:
```html
<link rel="stylesheet" href="https://icomb.place/design-system/verdant-tokens.css">
<link rel="stylesheet" href="https://icomb.place/design-system/verdant-base.css">
```

**SvelteKit + Tailwind v4 setup** (`src/app.css`):
```css
@import "tailwindcss";
@import url('https://icomb.place/design-system/verdant-tokens.css');
@import url('https://icomb.place/design-system/verdant-tailwind.css');
@import url('https://icomb.place/design-system/verdant-base.css');
```

### Design Philosophy
- **Glass Sidebar** layout: translucent panels with `backdrop-filter: blur(16px)`
- Dark navy/slate base with emerald green accent
- Depth through layered transparency, not drop shadows
- Minimal chrome, generous whitespace
- Mobile-first responsive design
- Smooth micro-animations on all interactive elements

### Tech Stack
- **SvelteKit** (latest) — framework
- **Bits UI** — headless accessible components (dialogs, menus, selects, etc.)
- **Tailwind CSS v4** — utility styling
- **Lucide Svelte** (`lucide-svelte`) — icon library
- **shadcn-svelte** (optional) — pre-styled Bits UI wrappers you own and customise

All tokens are prefixed `--vui-*` to avoid collisions with other libraries.

---

## 2. Design Tokens

Tokens are defined in `verdant-tokens.css` and all use the `--vui-` prefix.

### 2.1 Colours

Tokens available via `var(--vui-accent)` etc. In Tailwind, use `bg-accent`, `text-muted`, `border-danger-border` etc.:

```css
:root {
  /* ── Base ── */
  --bg:             #1a2332;
  --bg-deep:        #151d28;
  --sidebar:        #1e2a38;
  --surface:        #222d3d;
  --surface-alt:    #273446;
  --surface-hover:  #273749;

  /* ── Glass ── */
  --glass:          rgba(30, 42, 56, 0.55);
  --glass-border:   rgba(255, 255, 255, 0.06);

  /* ── Borders ── */
  --border:         rgba(255, 255, 255, 0.06);
  --border-hover:   rgba(255, 255, 255, 0.13);

  /* ── Text ── */
  --text:           #e0e8f0;
  --text-sub:       #94a3b8;
  --text-muted:     #6b7d90;
  --text-dim:       #3e5068;

  /* ── Accent (Emerald Green) ── */
  --accent:         #4fc978;
  --accent-hover:   #3dbd68;
  --accent-dim:     rgba(79, 201, 120, 0.1);
  --accent-border:  rgba(79, 201, 120, 0.25);
  --accent-glow:    rgba(79, 201, 120, 0.15);

  /* ── Semantic ── */
  --danger:         #f87171;
  --danger-dim:     rgba(248, 113, 113, 0.1);
  --danger-border:  rgba(248, 113, 113, 0.25);

  --warning:        #fbbf24;
  --warning-dim:    rgba(251, 191, 36, 0.1);
  --warning-border: rgba(251, 191, 36, 0.25);

  --info:           #38bdf8;
  --info-dim:       rgba(56, 189, 248, 0.1);
  --info-border:    rgba(56, 189, 248, 0.25);

  --purple:         #a78bfa;
  --purple-dim:     rgba(167, 139, 250, 0.1);
  --purple-border:  rgba(167, 139, 250, 0.25);
}
```

### 2.2 Typography

```css
:root {
  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
  --font-mono: 'JetBrains Mono', 'SF Mono', monospace;
}

body {
  font-family: var(--font-sans);
  color: var(--text);
  background: var(--bg-deep);
  -webkit-font-smoothing: antialiased;
}
```

**Scale** (use Tailwind classes or these values):
| Role | Size | Weight | Colour | Tracking |
|------|------|--------|--------|----------|
| Page title | 28px | 800 | --text | -0.04em |
| Section title | 10px uppercase | 700 | --accent | 0.08em |
| Card heading | 13–14px | 600 | --text | -0.01em |
| Body | 13px | 400 | --text-sub | normal |
| Caption/label | 11–12px | 500 | --text-muted | 0.02em |
| Dim/meta | 9–10px | 400 | --text-dim | normal |

### 2.3 Spacing & Radius

```css
:root {
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 14px;
  --radius-xl: 20px;
  --radius-full: 9999px;
}
```

Default padding: 16px on mobile, 28px on tablet, 36–40px on desktop.

### 2.4 Glass Effect

The signature glass effect used on sidebars, cards, dropdowns, and panels:

```css
.glass {
  background: var(--glass);
  backdrop-filter: blur(16px);
  -webkit-backdrop-filter: blur(16px);
  border: 1px solid var(--glass-border);
  border-radius: var(--radius-lg);
}
```

For inner glow on cards, add: `box-shadow: inset 0 1px 0 rgba(255,255,255,0.03);`

---

## 3. Layout Architecture

### 3.1 Glass Sidebar Layout

```
┌──────────┬────────────────────────────┐
│          │                            │
│ Sidebar  │   Main Content Area        │
│ (glass)  │   (scrollable)             │
│          │                            │
│ - Brand  │   - Page title + count     │
│ - Search │   - Search bar             │
│ - Nav    │   - Card grid / content    │
│ - Footer │   - Pagination             │
│          │                            │
└──────────┴────────────────────────────┘
```

- **Sidebar width**: 220px desktop, 200px tablet, 260px mobile (overlay)
- **Sidebar background**: `var(--glass)` with `backdrop-filter: blur(20px)`
- **Mobile**: sidebar hidden, triggered by hamburger → slides in from left with backdrop overlay `rgba(0,0,0,0.6)` + blur
- **Active nav item**: left bar `3px solid var(--accent)`, background `var(--accent-dim)`, icon colour `var(--accent)`

### 3.2 Responsive Breakpoints

```css
/* Mobile-first */
@media (min-width: 768px)  { /* Tablet  — 2-col grid, sidebar visible */ }
@media (min-width: 1024px) { /* Desktop — 3-col grid, full sidebar    */ }
```

---

## 4. Component Specifications

### 4.1 Buttons

| Variant | Background | Text | Border |
|---------|-----------|------|--------|
| Primary | `var(--accent)` | `#0a1520` | none |
| Secondary | `var(--glass)` | `var(--text)` | `var(--glass-border)` |
| Outline | transparent | `var(--accent)` | `var(--accent-border)` |
| Ghost | transparent | `var(--text-muted)` | none |
| Destructive | `var(--danger-dim)` | `var(--danger)` | `var(--danger-border)` |

**Common styles**: `border-radius: 10px; padding: 8px 16px; font-size: 13px; font-weight: 600; gap: 7px (icon+text); transition: all 0.15s ease;`

**Sizes**: Small `5px 10px / 11px`, Medium (default), Large `12px 24px / 15px`

**Icon buttons**: Square with `border-radius: 12px`, icon-only, no text.

**Toolbar**: Row of icon buttons in a `background: rgba(255,255,255,0.03); border-radius: 10px; padding: 3px` container.

### 4.2 Text Inputs

All inputs use the glass treatment:
```css
.input {
  background: var(--glass);
  backdrop-filter: blur(16px);
  border: 1px solid var(--glass-border);
  border-radius: var(--radius-md);
  padding: 10px 14px;
  color: var(--text);
  font-size: 13px;
}
.input:focus {
  border-color: rgba(79, 201, 120, 0.4);
  box-shadow: 0 0 0 3px rgba(79, 201, 120, 0.08);
}
```

**Variants**: Plain, with leading icon, with trailing action (eye toggle for password), textarea.

### 4.3 Select / Dropdown

- Trigger: glass button with `ChevronDown` icon that rotates 180° on open
- Dropdown panel: `var(--glass)` with blur, `border-radius: 10px`, `box-shadow: 0 12px 40px rgba(0,0,0,0.3)`
- Animation: `slideDown 0.15s ease` (translateY(-8px) + scale(0.96) → identity)
- Selected item: `background: var(--accent-dim)`, `color: var(--accent)`, `Check` icon on right
- Hover: `background: rgba(255,255,255,0.04)`

**Use Bits UI `Select` component** for accessibility (keyboard nav, ARIA).

### 4.4 Checkboxes

- Size: 20×20px, `border-radius: 6px`
- Unchecked: `background: rgba(255,255,255,0.04); border: 2px solid var(--text-dim)`
- Checked: `background: var(--accent)`, `Check` icon (`lucide-svelte`) in `#0a1520`, size 12px, strokeWidth 3
- Transition: `all 0.15s ease`

### 4.5 Radio Buttons

- Size: 20×20px, full round
- Unselected: `border: 2px solid var(--text-dim)`
- Selected: `border: 2px solid var(--accent)`, inner dot 10×10px `background: var(--accent)`

### 4.6 Toggle Switches

- Track: 42×24px, `border-radius: 12px`, padding 3px
- Off: `background: rgba(255,255,255,0.08)`
- On: `background: var(--accent)`
- Thumb: 18×18px white circle, `box-shadow: 0 1px 3px rgba(0,0,0,0.2)`
- Transition: `transform 0.2s cubic-bezier(0.16, 1, 0.3, 1)`

### 4.7 Tabs

- Container: `background: rgba(255,255,255,0.03); border-radius: 10px; padding: 3px`
- Inactive tab: transparent, `color: var(--text-muted)`
- Active tab: `.glass` treatment with border, icon + label, `color: var(--text)`
- Each tab has a Lucide icon (size 13, strokeWidth 1.8) to the left of the label

### 4.8 Badges / Tags

Pill-shaped with semantic colours:

| Variant | Background | Colour | Border | Icon |
|---------|-----------|--------|--------|------|
| Success | `--accent-dim` | `--accent` | `--accent-border` | `CircleCheck` |
| Warning | `--warning-dim` | `--warning` | `--warning-border` | `AlertTriangle` |
| Error | `--danger-dim` | `--danger` | `--danger-border` | `CircleX` |
| Info | `--info-dim` | `--info` | `--info-border` | `BadgeInfo` |
| New | `--purple-dim` | `--purple` | `--purple-border` | `Sparkles` |

Style: `border-radius: 9999px; padding: 4px 11px 4px 8px; font-size: 11.5px; font-weight: 600`

### 4.9 Cards

- Glass card: `.glass` treatment, `border-radius: var(--radius-lg)`, `padding: 18px`
- Hover: `transform: translateY(-2px); box-shadow: 0 8px 25px rgba(0,0,0,0.2)`
- Stat card: icon + label on top, large number (28px, weight 800), trend line below
- Accent card: `background: linear-gradient(135deg, var(--surface) 0%, var(--accent-dim) 100%)` with soft glow blob in corner

### 4.10 Table

- Wrapped in `.glass` container
- Header: `font-size: 11px; font-weight: 600; text-transform: uppercase; letter-spacing: 0.04em; color: var(--text-muted)`
- Row hover: `background: rgba(255,255,255,0.02)`
- Row border: `1px solid var(--border)`
- Status cells use badge component inline

### 4.11 Accordion

- Container: `.glass` treatment
- Each item: button with icon + label + `ChevronDown` (rotates 180°)
- Active item has icon colour `var(--accent)`
- Content: fades in with `fadeIn 0.2s ease`

**Use Bits UI `Accordion` component.**

### 4.12 Alerts

Full-width banners with semantic colours. Structure: `[Icon] [Message text] [X close]`
Same colour mapping as badges. `border-radius: var(--radius-md); padding: 10px 14px`

### 4.13 Toast

- Position: fixed `bottom: 24px; right: 24px`
- Background: `var(--sidebar)` with blur
- Border: `1px solid var(--accent-border)`
- Animation: `toastIn` — slides from right
- Auto-dismiss after 2.5s
- Contains `CircleCheck` icon + message text

### 4.14 Modal / Dialog

- Backdrop: `rgba(0,0,0,0.6)` + `backdrop-filter: blur(4px)`
- Panel: `background: var(--sidebar); border-radius: var(--radius-xl); padding: 28px`
- Animation: `modalIn 0.2s ease` — scale(0.95) → scale(1)
- Max-width: 420px, 90% on mobile
- Footer: right-aligned Cancel + Primary buttons

**Use Bits UI `Dialog` component.**

### 4.15 Context Menu / Dropdown Menu

- Glass panel with blur, `border-radius: 10px`
- Items: `padding: 9px 14px`, icon (size 14) + label
- Divider: `height: 1px; background: var(--border); margin: 4px 0`
- Destructive items: `color: var(--danger)`
- Hover: `background: rgba(255,255,255,0.04)`
- Animation: `slideDown 0.15s ease`

**Use Bits UI `DropdownMenu` component.**

### 4.16 Avatars

- Sizes: 28, 36, 44px
- Style: coloured background (accent-dim, purple-dim, etc.) + matching border, bold initials
- Stacked group: negative margin `-8px`, descending z-index, `+N` overflow pill

### 4.17 File Upload

- Dashed border: `2px dashed var(--text-dim)`
- Hover: border becomes `var(--accent)`, background becomes `var(--accent-dim)`
- Icon: `CloudUpload` from Lucide (size 32)
- Text: "Drag & drop or **browse**" with accent-coloured "browse"

### 4.18 Pagination

- Previous/Next buttons: glass style, with `ArrowLeft` / `ArrowRight` icons
- Page numbers: transparent default, active page gets `var(--accent-dim)` bg + `var(--accent)` text + accent border
- Current page: `font-variant-numeric: tabular-nums`

### 4.19 Breadcrumb

Simple text chain: `Home / Plants / Sweet Cherry`
- Ancestors: `color: var(--text-muted); cursor: pointer`
- Separator: `/ in var(--text-dim)`
- Current: `color: var(--text); font-weight: 500`

### 4.20 Keyboard Shortcuts

`<kbd>` elements: `background: rgba(255,255,255,0.06); border: 1px solid var(--border); border-radius: 5px; padding: 3px 7px; box-shadow: 0 1px 0 rgba(255,255,255,0.04)`
Use Lucide `Command` and `CornerDownLeft` icons inside kbd for ⌘ and ↵.

### 4.21 Rating

Stars using Lucide `Star` icon (size 22). Filled: `fill="#fbbf24" color="#fbbf24"`. Empty: `fill="none" color="var(--text-dim)"`. Hover: `transform: scale(1.2)`.

---

## 5. Icons

**Library**: `lucide-svelte` (install: `npm i lucide-svelte`)

**Default icon props**: `size={15} strokeWidth={1.8}`
**Small icon props** (inside buttons): `size={13} strokeWidth={2}`

**Core icons used in this system**:

| Context | Icon Name |
|---------|-----------|
| Navigation | `Leaf`, `Map`, `Printer`, `Settings` |
| Actions | `Plus`, `Copy`, `Trash2`, `UserPlus`, `Download`, `Share2`, `ExternalLink` |
| Search / Filter | `Search`, `Filter`, `SlidersHorizontal`, `RefreshCw` |
| Inputs | `Mail`, `Lock`, `Eye`, `EyeOff`, `Calendar` |
| Feedback | `Check`, `X`, `CircleCheck`, `CircleX`, `AlertTriangle`, `BadgeInfo`, `Sparkles` |
| UI | `ChevronDown`, `ArrowLeft`, `ArrowRight`, `MoreVertical`, `Menu`, `Loader2` |
| Media | `CloudUpload`, `Star`, `Heart`, `Bell`, `Bookmark`, `MessageSquare` |
| Keyboard | `Command`, `CornerDownLeft` |

**Svelte usage**:
```svelte
<script>
  import { Leaf, Plus, Search } from 'lucide-svelte';
</script>

<Leaf size={15} strokeWidth={1.8} class="text-accent" />
```

---

## 6. Animations

Define in `src/app.css`:

```css
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(8px); }
  to   { opacity: 1; transform: translateY(0); }
}
@keyframes slideDown {
  from { opacity: 0; transform: translateY(-8px) scale(0.96); }
  to   { opacity: 1; transform: translateY(0) scale(1); }
}
@keyframes slideInLeft {
  from { transform: translateX(-100%); }
  to   { transform: translateX(0); }
}
@keyframes toastIn {
  from { opacity: 0; transform: translateX(30px); }
  to   { opacity: 1; transform: translateX(0); }
}
@keyframes modalIn {
  from { opacity: 0; transform: scale(0.95); }
  to   { opacity: 1; transform: scale(1); }
}
@keyframes shimmer {
  0%   { background-position: -200% 0; }
  100% { background-position: 200% 0; }
}
@keyframes spin {
  to { transform: rotate(360deg); }
}
```

**Usage**:
- Card enter: `fadeIn 0.3s ease` with staggered `animation-delay`
- Dropdown open: `slideDown 0.15s ease`
- Mobile sidebar: `slideInLeft 0.25s cubic-bezier(0.16, 1, 0.3, 1)`
- Toast: `toastIn 0.25s cubic-bezier(0.16, 1, 0.3, 1)`
- Modal: `modalIn 0.2s ease`
- Skeleton: `shimmer 1.5s ease infinite`
- Spinner: `spin 0.8s linear infinite`

**Transitions** (interactive elements):
- Buttons/links: `transition: all 0.15s ease`
- Cards hover lift: `transition: all 0.2s ease`
- Toggle thumb: `transition: transform 0.2s cubic-bezier(0.16, 1, 0.3, 1)`
- ChevronDown rotation: `transition: transform 0.2s ease`

---

## 7. SvelteKit Project Structure

```
src/
├── app.css                    ← design tokens + animations
├── app.html
├── lib/
│   ├── components/
│   │   ├── ui/                ← shadcn-svelte / custom components
│   │   │   ├── Button.svelte
│   │   │   ├── Input.svelte
│   │   │   ├── Select.svelte
│   │   │   ├── Checkbox.svelte
│   │   │   ├── Toggle.svelte
│   │   │   ├── Tabs.svelte
│   │   │   ├── Badge.svelte
│   │   │   ├── Card.svelte
│   │   │   ├── Table.svelte
│   │   │   ├── Alert.svelte
│   │   │   ├── Toast.svelte
│   │   │   ├── Modal.svelte
│   │   │   ├── DropdownMenu.svelte
│   │   │   ├── Accordion.svelte
│   │   │   ├── Avatar.svelte
│   │   │   ├── FileUpload.svelte
│   │   │   ├── Pagination.svelte
│   │   │   ├── Breadcrumb.svelte
│   │   │   ├── Kbd.svelte
│   │   │   └── Rating.svelte
│   │   └── layout/
│   │       ├── Sidebar.svelte
│   │       ├── MobileHeader.svelte
│   │       └── PageHeader.svelte
│   └── stores/
│       └── toast.ts           ← toast notification store
├── routes/
│   ├── +layout.svelte         ← sidebar + main wrapper
│   └── +page.svelte
└── tailwind.config.js
```

---

## 8. Tailwind v4 Integration

**No `tailwind.config.js` needed.** Tailwind v4 is CSS-first. The `verdant-tailwind.css` file provides an `@theme` block that maps all `--vui-*` tokens to Tailwind utility classes.

Your `src/app.css` should be:

```css
@import "tailwindcss";
@import url('https://icomb.place/design-system/verdant-tokens.css');
@import url('https://icomb.place/design-system/verdant-tailwind.css');
@import url('https://icomb.place/design-system/verdant-base.css');
```

This gives you utility classes like:
- `bg-accent`, `bg-surface`, `bg-glass`, `bg-bg-deep`
- `text-text`, `text-muted`, `text-dim`, `text-accent`
- `border-border`, `border-accent-border`, `border-danger-border`
- `rounded-sm` (6px), `rounded-md` (10px), `rounded-lg` (14px), `rounded-xl` (20px)
- `shadow-sm` through `shadow-2xl`, `shadow-focus`
- `font-sans`, `font-mono`
- `ease-default`, `ease-spring`

Plus all the `.vui-*` component classes from `verdant-base.css`.

---

## 9. Dependencies (package.json)

```json
{
  "devDependencies": {
    "@sveltejs/kit": "latest",
    "svelte": "^5",
    "tailwindcss": "^4",
    "bits-ui": "latest",
    "lucide-svelte": "latest",
    "clsx": "latest"
  }
}
```

Optional: `shadcn-svelte` CLI for scaffolding Bits UI components with Tailwind styles.

---

## 10. Quick-Start Prompt for Claude

Paste this into a new Claude session to bootstrap a Verdant UI project:

> **System context**: I am building a SvelteKit application using the **Verdant UI** design system. The design system CSS is hosted at `https://icomb.place/design-system/` — three files:
>
> 1. `verdant-tokens.css` — CSS custom properties (`--vui-*` prefixed) for all colours, typography, spacing, shadows, animations
> 2. `verdant-base.css` — reset, glass utilities (`.vui-glass`), animations (`.vui-animate-*`), component classes (`.vui-btn`, `.vui-card`, `.vui-input`, `.vui-badge`, `.vui-alert`, `.vui-dropdown`, `.vui-overlay`, etc.)
> 3. `verdant-tailwind.css` — `@theme` block mapping tokens to Tailwind v4 utility classes
>
> **My `src/app.css`**:
> ```css
> @import "tailwindcss";
> @import url('https://icomb.place/design-system/verdant-tokens.css');
> @import url('https://icomb.place/design-system/verdant-tailwind.css');
> @import url('https://icomb.place/design-system/verdant-base.css');
> ```
>
> **Key design rules**:
> - **Dark glassmorphism theme**: navy backgrounds (`--vui-bg: #1a2332`), translucent panels with `backdrop-filter: blur(16px)`, emerald accent (`--vui-accent: #4fc978`)
> - **Bits UI** for headless accessible components (Dialog, Select, DropdownMenu, Accordion, Tabs, etc.)
> - **Tailwind CSS v4** for styling — use utility classes like `bg-accent`, `text-muted`, `rounded-lg`, `shadow-xl`
> - **Lucide Svelte** icons (`lucide-svelte`) — default: `size={15} strokeWidth={1.8}`, small/button: `size={13} strokeWidth={2}`
> - **Glass effect** on panels: use `.vui-glass` class or `bg-glass backdrop-blur-[16px] border border-glass-border`
> - **Text hierarchy**: `text-text` (primary #e0e8f0), `text-text-sub` (#94a3b8), `text-muted` (#6b7d90), `text-dim` (#3e5068)
> - **Semantic colours**: accent (emerald), warning (#fbbf24), danger (#f87171), info (#38bdf8), purple (#a78bfa) — each with `-dim` and `-border` variants
> - **Animations**: use `.vui-animate-fade-in`, `.vui-animate-slide-down`, `.vui-animate-toast`, `.vui-animate-modal`, `.vui-stagger` (for card lists)
> - **Component classes**: `.vui-btn-primary`, `.vui-btn-secondary`, `.vui-btn-outline`, `.vui-btn-ghost`, `.vui-btn-danger`, `.vui-input`, `.vui-card`, `.vui-badge-success`, `.vui-alert-warning`, `.vui-dropdown`, `.vui-dropdown-item`
> - **Layout**: Glass Sidebar (translucent sidebar on desktop, hamburger overlay on mobile with `.vui-overlay` backdrop)
> - **Border radius scale**: `rounded-sm` (6px), `rounded-md` (10px), `rounded-lg` (14px), `rounded-xl` (20px)
>
> When I ask you to build pages or components, follow this design system exactly. All components should be mobile-responsive. Always use Lucide icons, never inline SVGs.

---

## 11. Checklist When Building New Pages

- [ ] Uses `var(--glass)` + blur for panels, cards, dropdowns
- [ ] All buttons have Lucide icons with correct size props
- [ ] Interactive elements have `transition: all 0.15s ease`
- [ ] Cards have hover lift: `translateY(-2px)` + shadow
- [ ] Dropdowns/modals use `slideDown` / `modalIn` animations
- [ ] Semantic colours used correctly (not raw hex in components)
- [ ] Mobile breakpoint: sidebar collapses, grid goes to 1-col
- [ ] Focus states: `border-color: rgba(79,201,120,0.4); box-shadow: 0 0 0 3px rgba(79,201,120,0.08)`
- [ ] Text follows hierarchy: title → sub → muted → dim
- [ ] Section headers: 10px uppercase, accent colour, weight 700, with left bar decoration
