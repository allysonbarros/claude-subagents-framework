# 🎨 Projeto 4: Design System - Exemplo Prático Completo

Este exemplo mostra como criar um Design System completo do zero usando 9 agentes especializados.

---

## 🎯 Objetivo

Criar uma biblioteca de componentes React reutilizáveis com:
- Design tokens (cores, tipografia, espaçamentos)
- 50+ componentes
- Documentação no Storybook
- Testes automatizados
- Dark mode
- Acessibilidade WCAG 2.1 AA

---

## 👥 Agentes (9)

1. UX Specialist
2. Design System Builder
3. UI Designer
4. React Specialist
5. State Manager
6. Performance Optimizer
7. Unit Tester
8. E2E Tester
9. CI/CD Engineer

---

## 🚀 Implementação Completa

### Passo 1: UX Specialist - Definir Princípios

**Prompt:**
```
Use o agente ux-specialist para definir os princípios de UX do nosso design system

Contexto:
Design system para produtos SaaS B2B corporativos.
Público: Profissionais de 25-50 anos, uso diário 4-8h.

Requisitos:
- Foco em produtividade
- Acessibilidade é prioridade
- Consistência visual
- Suporta customização (white-label)

Tarefas:
1. Defina princípios de design (4-6 princípios)
2. Crie guidelines de UX
3. Defina tom e voz (formal/informal)
4. Estabeleça padrões de interação
```

**Output:**
```markdown
# Princípios do Design System

## 1. Clareza Acima de Tudo
**Definição:** Toda interface deve ser imediatamente compreensível.

**Aplicação:**
- Labels descritivos (não ícones sozinhos)
- Feedback visual claro
- Estados explícitos (loading, error, success)

**Exemplo:**
```tsx
// ❌ Ruim: Ícone sem contexto
<Button><Icon name="check" /></Button>

// ✅ Bom: Ícone + Label
<Button>
  <Icon name="check" />
  Confirmar
</Button>
```

## 2. Consistência em Tudo
**Definição:** Mesmos padrões em todos os produtos.

**Aplicação:**
- Componentes reutilizáveis
- Nomenclatura padronizada
- Comportamentos previsíveis

## 3. Acessível por Padrão
**Definição:** WCAG 2.1 AA mínimo, AAA quando possível.

**Aplicação:**
- Contraste mínimo 4.5:1 para texto
- Navegação por teclado
- Screen readers suportados
- Foco visível
- Tamanhos de toque adequados (44x44px)

## 4. Performance Importa
**Definição:** Interfaces rápidas e responsivas.

**Aplicação:**
- Componentes leves
- Lazy loading
- Virtualization em listas longas
- Debounce em inputs

## 5. Customizável mas Consistente
**Definição:** Permite customização sem quebrar padrões.

**Aplicação:**
- Tokens customizáveis (cores, fontes)
- Temas (light/dark)
- White-label support

## Guidelines de Interação

### Feedback Visual
**Toda ação deve ter feedback imediato (<100ms)**

```tsx
// ✅ Loading states
<Button loading={isLoading}>
  {isLoading ? 'Salvando...' : 'Salvar'}
</Button>

// ✅ Success feedback
<Toast type="success">Salvo com sucesso!</Toast>

// ✅ Error feedback
<Input error="Email inválido" />
```

### Hierarquia Visual
**Uso de tamanho, peso e cor para hierarquia**

```tsx
// Primário: Ação principal (1 por tela)
<Button variant="primary">Criar Projeto</Button>

// Secundário: Ações alternativas
<Button variant="secondary">Cancelar</Button>

// Terciário: Ações menos importantes
<Button variant="ghost">Detalhes</Button>
```

### Tom e Voz

**Tom:** Profissional mas acessível, não robótico.

```
❌ "Erro: Operação falhou com código 500"
✅ "Ops! Algo deu errado. Tente novamente em instantes."

❌ "Clique para prosseguir"
✅ "Continuar"

❌ "Tem certeza que deseja deletar?"
✅ "Deletar este item? Esta ação não pode ser desfeita."
```
```

---

### Passo 2: Design System Builder - Criar Tokens

**Prompt:**
```
Use o agente design-system-builder para criar os design tokens completos

Contexto:
Design system React + TypeScript + Styled Components.

Tokens necessários:
- Cores (primária, secundária, neutras, semânticas)
- Tipografia (famílias, tamanhos, pesos)
- Espaçamentos (escala de 4px)
- Sombras
- Bordas e raios
- Breakpoints
- Animações

Requisitos:
- Suporte a dark mode
- Escala consistente
- Exportar para CSS custom properties
- TypeScript types

Output esperado:
Código completo dos tokens
```

**Output:**
```typescript
// tokens/colors.ts
export const colors = {
  // Brand
  brand: {
    50: '#f0f9ff',
    100: '#e0f2fe',
    200: '#bae6fd',
    300: '#7dd3fc',
    400: '#38bdf8',
    500: '#0ea5e9', // Primary
    600: '#0284c7',
    700: '#0369a1',
    800: '#075985',
    900: '#0c4a6e',
  },

  // Neutrals (grayscale)
  gray: {
    50: '#f9fafb',
    100: '#f3f4f6',
    200: '#e5e7eb',
    300: '#d1d5db',
    400: '#9ca3af',
    500: '#6b7280',
    600: '#4b5563',
    700: '#374151',
    800: '#1f2937',
    900: '#111827',
  },

  // Semantic colors
  success: {
    light: '#10b981',
    main: '#059669',
    dark: '#047857',
  },
  error: {
    light: '#ef4444',
    main: '#dc2626',
    dark: '#b91c1c',
  },
  warning: {
    light: '#f59e0b',
    main: '#d97706',
    dark: '#b45309',
  },
  info: {
    light: '#3b82f6',
    main: '#2563eb',
    dark: '#1d4ed8',
  },

  // Text colors
  text: {
    primary: '#111827',
    secondary: '#6b7280',
    disabled: '#9ca3af',
    inverse: '#ffffff',
  },

  // Background colors
  background: {
    default: '#ffffff',
    paper: '#f9fafb',
    elevated: '#ffffff',
  },

  // Border colors
  border: {
    default: '#e5e7eb',
    light: '#f3f4f6',
    dark: '#d1d5db',
  },
} as const;

// Dark theme overrides
export const darkColors = {
  text: {
    primary: '#f9fafb',
    secondary: '#d1d5db',
    disabled: '#6b7280',
    inverse: '#111827',
  },
  background: {
    default: '#111827',
    paper: '#1f2937',
    elevated: '#374151',
  },
  border: {
    default: '#374151',
    light: '#4b5563',
    dark: '#1f2937',
  },
} as const;

// tokens/typography.ts
export const typography = {
  // Font families
  fontFamily: {
    sans: '"Inter", -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif',
    mono: '"JetBrains Mono", "Fira Code", monospace',
  },

  // Font sizes (scale based on 1rem = 16px)
  fontSize: {
    xs: '0.75rem',    // 12px
    sm: '0.875rem',   // 14px
    base: '1rem',     // 16px
    lg: '1.125rem',   // 18px
    xl: '1.25rem',    // 20px
    '2xl': '1.5rem',  // 24px
    '3xl': '1.875rem', // 30px
    '4xl': '2.25rem', // 36px
    '5xl': '3rem',    // 48px
  },

  // Font weights
  fontWeight: {
    light: 300,
    normal: 400,
    medium: 500,
    semibold: 600,
    bold: 700,
  },

  // Line heights
  lineHeight: {
    tight: 1.25,
    normal: 1.5,
    relaxed: 1.75,
  },

  // Letter spacing
  letterSpacing: {
    tight: '-0.025em',
    normal: '0',
    wide: '0.025em',
  },
} as const;

// tokens/spacing.ts
// 4px base scale
export const spacing = {
  0: '0',
  1: '0.25rem',  // 4px
  2: '0.5rem',   // 8px
  3: '0.75rem',  // 12px
  4: '1rem',     // 16px
  5: '1.25rem',  // 20px
  6: '1.5rem',   // 24px
  8: '2rem',     // 32px
  10: '2.5rem',  // 40px
  12: '3rem',    // 48px
  16: '4rem',    // 64px
  20: '5rem',    // 80px
  24: '6rem',    // 96px
} as const;

// tokens/shadows.ts
export const shadows = {
  none: 'none',
  sm: '0 1px 2px 0 rgba(0, 0, 0, 0.05)',
  base: '0 1px 3px 0 rgba(0, 0, 0, 0.1), 0 1px 2px 0 rgba(0, 0, 0, 0.06)',
  md: '0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)',
  lg: '0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05)',
  xl: '0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04)',
  '2xl': '0 25px 50px -12px rgba(0, 0, 0, 0.25)',
  inner: 'inset 0 2px 4px 0 rgba(0, 0, 0, 0.06)',
} as const;

// tokens/radius.ts
export const radius = {
  none: '0',
  sm: '0.125rem',  // 2px
  base: '0.25rem', // 4px
  md: '0.375rem',  // 6px
  lg: '0.5rem',    // 8px
  xl: '0.75rem',   // 12px
  '2xl': '1rem',   // 16px
  full: '9999px',  // Círculo
} as const;

// tokens/breakpoints.ts
export const breakpoints = {
  xs: '320px',
  sm: '640px',
  md: '768px',
  lg: '1024px',
  xl: '1280px',
  '2xl': '1536px',
} as const;

// tokens/animations.ts
export const transitions = {
  duration: {
    fast: '150ms',
    base: '200ms',
    slow: '300ms',
  },
  timing: {
    ease: 'ease',
    easeIn: 'ease-in',
    easeOut: 'ease-out',
    easeInOut: 'ease-in-out',
  },
} as const;

// Export tudo
export const tokens = {
  colors,
  darkColors,
  typography,
  spacing,
  shadows,
  radius,
  breakpoints,
  transitions,
} as const;

// TypeScript types
export type Colors = typeof colors;
export type Spacing = typeof spacing;
export type Typography = typeof typography;
```

**Gerar CSS Custom Properties:**
```typescript
// tokens/cssVars.ts
import { tokens } from './index';

export function generateCSSVars(theme: 'light' | 'dark' = 'light') {
  const colorTokens = theme === 'dark' ? tokens.darkColors : tokens.colors;

  return `
    :root {
      /* Colors */
      --color-brand-500: ${tokens.colors.brand[500]};
      --color-text-primary: ${colorTokens.text.primary};
      --color-bg-default: ${colorTokens.background.default};

      /* Spacing */
      --spacing-4: ${tokens.spacing[4]};
      --spacing-8: ${tokens.spacing[8]};

      /* Typography */
      --font-sans: ${tokens.typography.fontFamily.sans};
      --font-size-base: ${tokens.typography.fontSize.base};

      /* Shadows */
      --shadow-md: ${tokens.shadows.md};

      /* Radius */
      --radius-base: ${tokens.radius.base};

      /* Transitions */
      --duration-base: ${tokens.transitions.duration.base};
    }
  `;
}
```

---

### Passo 3: UI Designer + React Specialist - Criar Componente Button

**Prompt para UI Designer:**
```
Use o agente ui-designer para criar o design de um componente Button

Requisitos:
- 3 variantes: primary, secondary, ghost
- 3 tamanhos: sm, md, lg
- Estados: default, hover, active, disabled, loading
- Suporta ícones (left/right)
- Acessível (ARIA)

Use os tokens definidos anteriormente.
```

**Prompt para React Specialist:**
```
Use o agente react-specialist para implementar o componente Button

Design: (cole output do UI Designer)
Tokens: (cole tokens.ts)

Requisitos:
- React 18 + TypeScript
- Styled Components
- Suporte a todos os estados
- Acessibilidade completa
- Testes com React Testing Library
```

**Output:**
```typescript
// components/Button/Button.tsx
import React from 'react';
import styled, { css } from 'styled-components';
import { tokens } from '../../tokens';

export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  /** Variante visual */
  variant?: 'primary' | 'secondary' | 'ghost';
  /** Tamanho */
  size?: 'sm' | 'md' | 'lg';
  /** Estado de loading */
  loading?: boolean;
  /** Ícone à esquerda */
  leftIcon?: React.ReactNode;
  /** Ícone à direita */
  rightIcon?: React.ReactNode;
  /** Full width */
  fullWidth?: boolean;
  /** Children */
  children: React.ReactNode;
}

const StyledButton = styled.button<ButtonProps>`
  /* Base styles */
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: ${tokens.spacing[2]};
  font-family: ${tokens.typography.fontFamily.sans};
  font-weight: ${tokens.typography.fontWeight.medium};
  border-radius: ${tokens.radius.md};
  border: none;
  cursor: pointer;
  transition: all ${tokens.transitions.duration.base} ${tokens.transitions.timing.easeInOut};

  /* Remove default button styles */
  -webkit-appearance: none;
  -moz-appearance: none;
  appearance: none;

  /* Focus styles (acessibilidade) */
  &:focus-visible {
    outline: 2px solid ${tokens.colors.brand[500]};
    outline-offset: 2px;
  }

  /* Disabled state */
  &:disabled {
    cursor: not-allowed;
    opacity: 0.6;
  }

  /* Size variants */
  ${({ size }) => {
    switch (size) {
      case 'sm':
        return css`
          padding: ${tokens.spacing[2]} ${tokens.spacing[3]};
          font-size: ${tokens.typography.fontSize.sm};
          min-height: 32px;
        `;
      case 'lg':
        return css`
          padding: ${tokens.spacing[4]} ${tokens.spacing[6]};
          font-size: ${tokens.typography.fontSize.lg};
          min-height: 48px;
        `;
      case 'md':
      default:
        return css`
          padding: ${tokens.spacing[3]} ${tokens.spacing[5]};
          font-size: ${tokens.typography.fontSize.base};
          min-height: 40px;
        `;
    }
  }}

  /* Variant styles */
  ${({ variant }) => {
    switch (variant) {
      case 'primary':
        return css`
          background: ${tokens.colors.brand[500]};
          color: white;

          &:hover:not(:disabled) {
            background: ${tokens.colors.brand[600]};
          }

          &:active:not(:disabled) {
            background: ${tokens.colors.brand[700]};
          }
        `;

      case 'secondary':
        return css`
          background: transparent;
          color: ${tokens.colors.brand[500]};
          border: 1px solid ${tokens.colors.brand[500]};

          &:hover:not(:disabled) {
            background: ${tokens.colors.brand[50]};
          }

          &:active:not(:disabled) {
            background: ${tokens.colors.brand[100]};
          }
        `;

      case 'ghost':
      default:
        return css`
          background: transparent;
          color: ${tokens.colors.text.secondary};

          &:hover:not(:disabled) {
            background: ${tokens.colors.gray[100]};
            color: ${tokens.colors.text.primary};
          }

          &:active:not(:disabled) {
            background: ${tokens.colors.gray[200]};
          }
        `;
    }
  }}

  /* Full width */
  ${({ fullWidth }) =>
    fullWidth &&
    css`
      width: 100%;
    `}

  /* Loading state */
  ${({ loading }) =>
    loading &&
    css`
      pointer-events: none;
      opacity: 0.7;
    `}
`;

const LoadingSpinner = styled.span`
  display: inline-block;
  width: 1em;
  height: 1em;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }
`;

export const Button: React.FC<ButtonProps> = ({
  variant = 'primary',
  size = 'md',
  loading = false,
  leftIcon,
  rightIcon,
  fullWidth = false,
  disabled,
  children,
  ...props
}) => {
  return (
    <StyledButton
      variant={variant}
      size={size}
      loading={loading}
      fullWidth={fullWidth}
      disabled={disabled || loading}
      aria-busy={loading}
      aria-disabled={disabled || loading}
      {...props}
    >
      {loading && <LoadingSpinner />}
      {!loading && leftIcon && <span>{leftIcon}</span>}
      <span>{children}</span>
      {!loading && rightIcon && <span>{rightIcon}</span>}
    </StyledButton>
  );
};
```

**Testes:**
```typescript
// components/Button/Button.test.tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from './Button';

describe('Button', () => {
  it('renders children correctly', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('shows loading state', () => {
    render(<Button loading>Loading</Button>);
    const button = screen.getByRole('button');

    expect(button).toHaveAttribute('aria-busy', 'true');
    expect(button).toBeDisabled();
  });

  it('disables button when disabled prop is true', () => {
    render(<Button disabled>Disabled</Button>);
    expect(screen.getByRole('button')).toBeDisabled();
  });

  it('renders with left icon', () => {
    render(<Button leftIcon={<span data-testid="icon">→</span>}>With Icon</Button>);
    expect(screen.getByTestId('icon')).toBeInTheDocument();
  });

  it('applies correct variant styles', () => {
    const { rerender } = render(<Button variant="primary">Primary</Button>);
    expect(screen.getByText('Primary')).toHaveStyle({
      background: tokens.colors.brand[500],
    });

    rerender(<Button variant="secondary">Secondary</Button>);
    expect(screen.getByText('Secondary')).toHaveStyle({
      background: 'transparent',
    });
  });

  it('applies correct size', () => {
    const { rerender } = render(<Button size="sm">Small</Button>);
    expect(screen.getByText('Small')).toHaveStyle({
      fontSize: tokens.typography.fontSize.sm,
    });

    rerender(<Button size="lg">Large</Button>);
    expect(screen.getByText('Large')).toHaveStyle({
      fontSize: tokens.typography.fontSize.lg,
    });
  });

  it('has accessible focus state', () => {
    render(<Button>Focus me</Button>);
    const button = screen.getByRole('button');

    button.focus();
    expect(button).toHaveFocus();
  });
});
```

**Storybook:**
```typescript
// components/Button/Button.stories.tsx
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  title: 'Components/Button',
  component: Button,
  tags: ['autodocs'],
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'ghost'],
    },
    size: {
      control: 'select',
      options: ['sm', 'md', 'lg'],
    },
  },
};

export default meta;
type Story = StoryObj<typeof Button>;

export const Primary: Story = {
  args: {
    children: 'Primary Button',
    variant: 'primary',
  },
};

export const Secondary: Story = {
  args: {
    children: 'Secondary Button',
    variant: 'secondary',
  },
};

export const Ghost: Story = {
  args: {
    children: 'Ghost Button',
    variant: 'ghost',
  },
};

export const Small: Story = {
  args: {
    children: 'Small Button',
    size: 'sm',
  },
};

export const Large: Story = {
  args: {
    children: 'Large Button',
    size: 'lg',
  },
};

export const Loading: Story = {
  args: {
    children: 'Loading...',
    loading: true,
  },
};

export const Disabled: Story = {
  args: {
    children: 'Disabled',
    disabled: true,
  },
};

export const WithLeftIcon: Story = {
  args: {
    children: 'Download',
    leftIcon: '⬇',
  },
};

export const WithRightIcon: Story = {
  args: {
    children: 'Next',
    rightIcon: '→',
  },
};

export const FullWidth: Story = {
  args: {
    children: 'Full Width',
    fullWidth: true,
  },
};

// Combinações (Playground)
export const AllVariants: Story = {
  render: () => (
    <div style={{ display: 'flex', gap: '1rem', flexDirection: 'column', maxWidth: '300px' }}>
      <Button variant="primary">Primary</Button>
      <Button variant="secondary">Secondary</Button>
      <Button variant="ghost">Ghost</Button>
    </div>
  ),
};

export const AllSizes: Story = {
  render: () => (
    <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
      <Button size="sm">Small</Button>
      <Button size="md">Medium</Button>
      <Button size="lg">Large</Button>
    </div>
  ),
};
```

---

## 📦 Estrutura Final do Projeto

```
design-system/
├── src/
│   ├── tokens/
│   │   ├── index.ts
│   │   ├── colors.ts
│   │   ├── typography.ts
│   │   ├── spacing.ts
│   │   ├── shadows.ts
│   │   ├── radius.ts
│   │   ├── breakpoints.ts
│   │   └── cssVars.ts
│   │
│   ├── components/
│   │   ├── Button/
│   │   │   ├── Button.tsx
│   │   │   ├── Button.test.tsx
│   │   │   └── Button.stories.tsx
│   │   ├── Input/
│   │   ├── Select/
│   │   ├── Modal/
│   │   ├── Card/
│   │   └── ... (50+ componentes)
│   │
│   ├── hooks/
│   │   ├── useTheme.ts
│   │   ├── useMediaQuery.ts
│   │   └── useDisclosure.ts
│   │
│   └── index.ts
│
├── .storybook/
│   ├── main.ts
│   ├── preview.ts
│   └── theme.ts
│
├── docs/
│   ├── principles.md
│   ├── getting-started.md
│   └── components/
│
├── package.json
├── tsconfig.json
└── README.md
```

---

## 🚀 Como Usar

### Instalação

```bash
npm install @company/design-system
```

### Uso Básico

```tsx
import { Button, ThemeProvider } from '@company/design-system';

function App() {
  return (
    <ThemeProvider>
      <Button variant="primary" size="md">
        Hello World
      </Button>
    </ThemeProvider>
  );
}
```

### Dark Mode

```tsx
import { ThemeProvider, useTheme } from '@company/design-system';

function ThemeToggle() {
  const { theme, setTheme } = useTheme();

  return (
    <Button onClick={() => setTheme(theme === 'light' ? 'dark' : 'light')}>
      Toggle Theme
    </Button>
  );
}

function App() {
  return (
    <ThemeProvider initialTheme="light">
      <ThemeToggle />
    </ThemeProvider>
  );
}
```

---

## 📊 Métricas de Sucesso

- ✅ 50+ componentes
- ✅ >90% coverage de testes
- ✅ 100% acessibilidade WCAG 2.1 AA
- ✅ Bundle size < 50kb (tree-shaking)
- ✅ Documentação completa no Storybook
- ✅ Dark mode suportado
- ✅ TypeScript 100%

---

## 🎯 Próximos Componentes

Ver implementações completas em `examples/project-4-design-system/components/`:

- Input
- Select
- Modal
- Card
- Table
- Tabs
- Dropdown
- Toast
- Avatar
- Badge
- ... e mais 40!

---

**Tempo de implementação:** 8 semanas
**Agentes usados:** 9 agentes especializados
**Componentes criados:** 50+
**Cobertura de testes:** >90%
