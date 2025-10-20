# JavaScript + Vue 3 Review Guidelines
# Universal guidelines for Vue 3 + TypeScript + Vite projects

## Typical Stack Context
- **Language**: TypeScript + JavaScript
- **Framework**: Vue 3 (Composition API with `<script setup>`)
- **Testing**: Vitest, Jest, or Playwright
- **Build**: Vite
- **Linter**: ESLint with Vue plugin
- **Formatter**: Prettier
- **CSS**: Plain CSS, PostCSS, Sass, Less, or CSS-in-JS
- **State Management**: Pinia, Vuex, or component-local state

## Review Checklist

### Language-Specific (TypeScript/JavaScript)
- [ ] TypeScript types defined for all props, emits, and composables
- [ ] Use `type` for simple type aliases, `interface` for extendable contracts
- [ ] No `any` types - use proper typing or `unknown`
- [ ] Computed properties use `computed()` from Vue
- [ ] Reactive state uses `ref()` or `reactive()` appropriately
- [ ] Proper destructuring of props (use `.value` or toRefs())

### Framework-Specific (Vue 3)
- [ ] Use Composition API with `<script setup lang="ts">` (preferred)
- [ ] Props defined with `defineProps<PropsType>()` (TypeScript) or runtime validation
- [ ] Emits defined with `defineEmits<EmitsType>()` with proper payload types
- [ ] Use `v-bind="$attrs"` to pass through attributes when needed
- [ ] Component names follow PascalCase (e.g., `MyButton`, `UserProfile`)
- [ ] Proper slot usage with conditional rendering (`v-if="$slots.slotName"`)
- [ ] Scoped styles or CSS Modules for component isolation
- [ ] Use `<script setup>` benefits: auto-imports, cleaner syntax

### Testing
- [ ] Test files colocated or in `__tests__`/`tests` directory
- [ ] Test framework configured (Vitest recommended for Vite projects)
- [ ] Component tests use `@vue/test-utils`
- [ ] E2E tests with Playwright or Cypress (if applicable)
- [ ] Tests cover props, emits, slots, and user interactions
- [ ] Accessibility testing included

### Code Quality
- [ ] Prettier formatting applied
- [ ] ESLint rules passing (Vue + TypeScript recommended configs)
- [ ] TypeScript type checking passing (`vue-tsc --noEmit`)
- [ ] No console.log or debugging artifacts
- [ ] JSDoc comments for public APIs
- [ ] Meaningful variable and function names

### Performance
- [ ] Use `computed()` for derived state, not methods in templates
- [ ] Avoid unnecessary watchers - prefer computed properties
- [ ] CSS optimization: avoid inline styles, use classes
- [ ] Component lazy loading for large/conditional components (`defineAsyncComponent`)
- [ ] Proper tree-shaking by using named exports
- [ ] v-memo for expensive list items (if needed)

### Security
- [ ] No `v-html` without sanitization (use DOMPurify if needed)
- [ ] Props validated and typed to prevent injection
- [ ] User input properly escaped in templates (Vue does this automatically)
- [ ] No sensitive data in component props or exposed to dev tools
- [ ] XSS prevention in dynamic attributes

### Accessibility (a11y)
- [ ] Semantic HTML elements used
- [ ] ARIA attributes where necessary
- [ ] Keyboard navigation support
- [ ] Focus management for modals/dialogs
- [ ] Alt text for images
- [ ] Color contrast meets WCAG standards

## Common Vue 3 + Vite Patterns

### File Structure
```
src/
├── components/
│   ├── MyComponent.vue
│   ├── MyComponent.types.ts (optional)
│   └── MyComponent.test.ts
├── composables/
│   └── useMyComposable.ts
├── utils/
│   └── helpers.ts
├── types/
│   └── index.ts
└── App.vue
```

### Import Organization
1. Vue core imports (`vue`, `vue-router`, `pinia`)
2. Third-party libraries
3. Type imports (`import type`)
4. Local components
5. Local composables/utils
6. Assets (CSS, images)

### Props Pattern (TypeScript)
```typescript
<script setup lang="ts">
interface Props {
  title: string
  count?: number  // optional
  variant?: 'primary' | 'secondary'
}

const props = withDefaults(defineProps<Props>(), {
  count: 0,
  variant: 'primary'
})
</script>
```

### Emits Pattern
```typescript
<script setup lang="ts">
const emit = defineEmits<{
  (e: 'update:modelValue', value: string): void
  (e: 'submit', payload: { id: number; name: string }): void
}>()

const handleSubmit = () => {
  emit('submit', { id: 1, name: 'example' })
}
</script>
```

### Composables Pattern
```typescript
// composables/useCounter.ts
import { ref, computed } from 'vue'

export function useCounter(initialValue = 0) {
  const count = ref(initialValue)
  const doubled = computed(() => count.value * 2)

  const increment = () => count.value++
  const decrement = () => count.value--

  return {
    count,
    doubled,
    increment,
    decrement
  }
}
```

## Examples

### Good Pattern Example
```vue
<script setup lang="ts">
import { computed } from 'vue'

interface Props {
  size?: 'sm' | 'md' | 'lg'
  disabled?: boolean
}

const props = withDefaults(defineProps<Props>(), {
  size: 'md',
  disabled: false
})

const emit = defineEmits<{
  (e: 'click', event: MouseEvent): void
}>()

const sizeClasses = computed(() => ({
  'btn-sm': props.size === 'sm',
  'btn-md': props.size === 'md',
  'btn-lg': props.size === 'lg',
}))

const handleClick = (event: MouseEvent) => {
  if (!props.disabled) {
    emit('click', event)
  }
}
</script>

<template>
  <button
    :class="sizeClasses"
    :disabled="disabled"
    @click="handleClick"
  >
    <slot />
  </button>
</template>

<style scoped>
.btn-sm { padding: 0.25rem 0.5rem; }
.btn-md { padding: 0.5rem 1rem; }
.btn-lg { padding: 0.75rem 1.5rem; }
</style>
```

### Anti-Patterns to Avoid

```vue
<!-- ❌ DON'T: Use Options API for new code -->
<script>
export default {
  props: ['size', 'disabled'],  // ❌ No types
  methods: {
    getSizeClass() {  // ❌ Should be computed
      return `btn-${this.size}`
    }
  }
}
</script>

<!-- ❌ DON'T: Use inline styles -->
<button :style="{ padding: size === 'large' ? '20px' : '10px' }">

<!-- ❌ DON'T: Use any types -->
<script setup lang="ts">
const props = defineProps<any>()  // ❌ Defeats TypeScript
</script>

<!-- ❌ DON'T: Mutate props directly -->
<script setup lang="ts">
const props = defineProps<{ count: number }>()
props.count++  // ❌ Props are readonly!
</script>

<!-- ❌ DON'T: Use methods in templates for computed values -->
<template>
  <div>{{ calculateTotal() }}</div>  <!-- ❌ Use computed instead -->
</template>
```

## Automated Checks (Common Scripts)

Based on typical Vue 3 + Vite projects:
- `npm run type-check` or `vue-tsc --noEmit` - TypeScript validation
- `npm run lint` or `eslint .` - ESLint checks
- `npm run format` or `prettier --write` - Code formatting
- `npm run test` or `vitest` - Unit tests
- `npm run build` - Build check
- `npm run preview` - Preview production build

## Vite-Specific Considerations

- Use Vite's path aliases (`@/` for `src/`)
- Leverage Vite's fast HMR (Hot Module Replacement)
- Use `import.meta.env` for environment variables
- Optimize chunks with Vite's `build.rollupOptions`
- Use `vite-plugin-vue-devtools` for enhanced debugging

## State Management (Pinia)

If using Pinia:
```typescript
// stores/counter.ts
import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useCounterStore = defineStore('counter', () => {
  const count = ref(0)
  const doubled = computed(() => count.value * 2)

  function increment() {
    count.value++
  }

  return { count, doubled, increment }
})
```

## Notes

- This file contains universal Vue 3 + Vite best practices
- For project-specific conventions, create `.claude/review-guidelines.md` in your project
- The review agent will combine both files for comprehensive reviews
- Keep this file focused on Vue 3 patterns, not project specifics
- Contribute improvements back to the claude-code-agents repository
