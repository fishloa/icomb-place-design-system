# 🌿 Verdant UI — Design System

A dark glassmorphism design system for SvelteKit applications. Hosted at `https://icomb.place/design-system/`.

## Files

```
design-system/
├── README.md                    ← this file
├── DESIGN_SYSTEM.md             ← full specification & Claude prompt
├── verdant-tokens.css           ← CSS custom properties (colours, type, spacing, shadows)
├── verdant-base.css             ← reset, glass utilities, animations, component classes
├── verdant-tailwind.css         ← Tailwind v4 @theme integration
└── examples/
    └── index.html               ← standalone demo page (no framework needed)
```

## Quick Start

### Any HTML project
```html
<link rel="stylesheet" href="https://icomb.place/design-system/verdant-tokens.css">
<link rel="stylesheet" href="https://icomb.place/design-system/verdant-base.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<button class="vui-btn vui-btn-primary">Click me</button>
```

### SvelteKit + Tailwind v4

1. Install dependencies:
```bash
npm create svelte@latest my-app
cd my-app
npm install
npm install -D tailwindcss @tailwindcss/vite bits-ui lucide-svelte clsx
```

2. Add Vite plugin (`vite.config.ts`):
```ts
import tailwindcss from '@tailwindcss/vite';
export default defineConfig({
  plugins: [tailwindcss(), sveltekit()]
});
```

3. Set up `src/app.css`:
```css
@import "tailwindcss";
@import url('https://icomb.place/design-system/verdant-tokens.css');
@import url('https://icomb.place/design-system/verdant-tailwind.css');
@import url('https://icomb.place/design-system/verdant-base.css');
```

4. Import in `src/routes/+layout.svelte`:
```svelte
<script>
  import '../app.css';
</script>
<slot />
```

5. Use it:
```svelte
<script>
  import { Leaf, Plus } from 'lucide-svelte';
</script>

<div class="bg-bg-deep min-h-screen text-text">
  <div class="vui-card vui-hover-lift">
    <h2 class="text-xl font-extrabold tracking-tight">Hello Verdant</h2>
    <p class="text-text-sub mt-2">Glass sidebar design system.</p>
    <button class="vui-btn vui-btn-primary mt-4">
      <Plus size={13} strokeWidth={2} /> Add Plant
    </button>
  </div>
</div>
```

## Token Prefix

All CSS custom properties use the `--vui-` prefix to avoid collisions:
- `var(--vui-accent)` → `#4fc978`
- `var(--vui-glass)` → `rgba(30, 42, 56, 0.55)`
- `var(--vui-radius-lg)` → `14px`

## Tailwind Utility Classes

The `verdant-tailwind.css` `@theme` block provides:

| Token | Tailwind Class |
|-------|---------------|
| `--vui-accent` | `bg-accent`, `text-accent`, `border-accent` |
| `--vui-surface` | `bg-surface` |
| `--vui-text-muted` | `text-muted` |
| `--vui-danger` | `bg-danger`, `text-danger` |
| `--vui-radius-lg` | `rounded-lg` |
| `--vui-shadow-xl` | `shadow-xl` |

## Component Classes

Pre-built classes in `verdant-base.css`:

**Buttons**: `.vui-btn` + `.vui-btn-primary`, `.vui-btn-secondary`, `.vui-btn-outline`, `.vui-btn-ghost`, `.vui-btn-danger`, `.vui-btn-sm`, `.vui-btn-lg`, `.vui-btn-icon`

**Glass**: `.vui-glass`, `.vui-glass-strong`, `.vui-glass-inner-glow`

**Layout**: `.vui-card`, `.vui-surface`, `.vui-overlay`, `.vui-section-header`, `.vui-toolbar`

**Data**: `.vui-badge` + `.vui-badge-success/warning/danger/info/purple`, `.vui-alert` + variants

**Inputs**: `.vui-input`, `.vui-input-group`

**Dropdowns**: `.vui-dropdown`, `.vui-dropdown-item`, `.vui-dropdown-divider`

**Animation**: `.vui-animate-fade-in`, `.vui-animate-slide-down`, `.vui-animate-toast`, `.vui-animate-modal`, `.vui-animate-sidebar`, `.vui-animate-spin`, `.vui-stagger`, `.vui-skeleton`

**Interaction**: `.vui-hover-lift`, `.vui-transition`, `.vui-transition-base`

## Icons

Uses [Lucide](https://lucide.dev) via `lucide-svelte`. Default props: `size={15} strokeWidth={1.8}`. In buttons: `size={13} strokeWidth={2}`.

## Design Spec

See `DESIGN_SYSTEM.md` for the full specification including component details, layout architecture, and a copy-paste prompt for Claude sessions.

## License

MIT — built for icomb.place projects.
