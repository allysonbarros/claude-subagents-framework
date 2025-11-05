# Claude Subagents Framework CLI

🚀 **User-friendly CLI tool to easily manage and install Claude Code subagents for your projects.**

The Claude Subagents Framework CLI (`csf`) makes it easy for both technical and non-technical users to discover, browse, and install specialized AI agents for Claude Code.

## 📦 Installation

### Global Installation (Recommended)

```bash
npm install -g claude-subagents-cli
```

After installation, you can use the `csf` command from anywhere.

### Local Installation

```bash
# Clone the repository
git clone https://github.com/allysonbarros/claude-subagents-framework.git
cd claude-subagents-framework/cli

# Install dependencies
npm install

# Link for local development
npm link
```

## 🎯 Quick Start

### Interactive Mode (Recommended for Beginners)

The easiest way to get started is using interactive mode:

```bash
csf interactive
```

This will launch a guided wizard that helps you:
- 📁 Choose your project directory
- 📋 Browse agents by category
- ✅ Select agents to install
- 🚀 Install everything automatically

### Quick Commands

```bash
# List all available agents
csf list

# Search for agents
csf search react

# Install specific agents
csf install product-manager tech-architect

# Show agent details
csf info react-specialist

# Initialize project structure
csf init
```

## 📖 Commands

### `csf list`

List all available agents, optionally filtered by category or tags.

```bash
# List all agents
csf list

# List agents by category
csf list --category frontend

# List agents by tags
csf list --tags react,hooks

# Output as JSON
csf list --json
```

**Options:**
- `-c, --category <category>` - Filter by category
- `-t, --tags <tags>` - Filter by tags (comma-separated)
- `--json` - Output as JSON

### `csf search <query>`

Search for agents by name, description, or tags.

```bash
# Search for React-related agents
csf search react

# Search for testing agents
csf search test

# Search for API-related agents
csf search api
```

**Options:**
- `--json` - Output as JSON

### `csf install [agents...]`

Install one or more agents to your project.

```bash
# Install a single agent
csf install product-manager

# Install multiple agents
csf install react-specialist state-manager performance-optimizer

# Install all agents from a category
csf install --all-category frontend

# Install to custom directory
csf install product-manager --dest ./my-agents

# Force overwrite existing files
csf install product-manager --force
```

**Options:**
- `-d, --dest <path>` - Destination directory (default: `./.claude/agents`)
- `-f, --force` - Overwrite existing files
- `--all-category <category>` - Install all agents from a category

### `csf info <agent-id>`

Show detailed information about an agent.

```bash
# Show agent details
csf info react-specialist

# Show product manager details
csf info product-manager
```

### `csf init`

Initialize Claude Code agents structure in your project.

```bash
# Initialize in current directory
csf init

# Initialize in specific directory
csf init --dest /path/to/project
```

This creates:
- `.claude/` directory
- `.claude/agents/` directory for agents
- README file with instructions
- Updates `.gitignore`

**Options:**
- `-d, --dest <path>` - Destination directory (default: current directory)

### `csf update [agents...]`

Update installed agents to the latest version.

```bash
# Update specific agents
csf update product-manager tech-architect

# Update all installed agents
csf update --all

# Update in custom directory
csf update --all --dest ./my-agents
```

**Options:**
- `-d, --dest <path>` - Agents directory (default: `./.claude/agents`)
- `--all` - Update all installed agents

### `csf interactive` (or `csf i`)

Launch interactive mode with a guided wizard.

```bash
csf interactive
# or
csf i
```

Interactive mode features:
- 🎯 Quick install (popular agents)
- 📋 Browse agents by category
- 🔍 Search and select
- 📦 Install complete categories
- ♻️ Install more in a loop

Perfect for beginners and visual learners!

## 🗂️ Agent Categories

The framework includes 24 specialized agents across 8 categories:

### 📋 Strategists
Planning, architecture, and technical decisions
- **product-manager** - Requirements, roadmaps, PRDs
- **tech-architect** - System architecture, patterns
- **api-designer** - REST/GraphQL API design

### 🔍 Researchers
Code exploration and technical research
- **code-explorer** - Codebase analysis
- **tech-scout** - Technology research
- **dependency-analyzer** - Dependency audits

### 🎨 Designers
UI/UX design and design systems
- **ui-designer** - Interface design
- **ux-specialist** - User experience
- **design-system-builder** - Design systems

### ⚛️ Frontend
Frontend development with modern frameworks
- **react-specialist** - React development
- **state-manager** - State management
- **performance-optimizer** - Performance optimization

### 🔧 Backend
Server-side development and APIs
- **api-developer** - API implementation
- **database-specialist** - Database design
- **security-specialist** - Security & OWASP

### ✅ Testers
Testing strategies and quality assurance
- **unit-tester** - Unit testing & TDD
- **e2e-tester** - End-to-end testing
- **test-strategist** - Test strategy

### 🚀 DevOps
CI/CD, containers, and infrastructure
- **ci-cd-engineer** - CI/CD pipelines
- **docker-specialist** - Docker & containers
- **infrastructure-engineer** - Terraform & K8s

### 📊 Analytics
Data analysis and experimentation
- **event-tracker** - Event tracking
- **ab-tester** - A/B testing
- **metrics-analyst** - Metrics & KPIs

## 💡 Usage Examples

### Example 1: Setup for a React Project

```bash
# Initialize project
csf init

# Install frontend agents
csf install react-specialist state-manager performance-optimizer

# Install testing
csf install unit-tester e2e-tester

# Install DevOps
csf install docker-specialist ci-cd-engineer
```

### Example 2: Full-Stack Project

```bash
# Use interactive mode
csf interactive

# Or install specific categories
csf install --all-category frontend
csf install --all-category backend
csf install --all-category testers
```

### Example 3: Product & Planning

```bash
# Install strategists for planning
csf install product-manager tech-architect api-designer

# View details before installing
csf info product-manager
```

## 🔧 Project Structure

After running `csf init` and installing agents:

```
your-project/
├── .claude/
│   └── agents/
│       ├── README.md
│       ├── product-manager.md
│       ├── react-specialist.md
│       └── ... (other installed agents)
├── .gitignore (updated)
└── ... (your project files)
```

## 📝 Using Agents in Claude Code

Once agents are installed, use them in Claude Code:

```
Use the agent product-manager to create a PRD for a new feature
```

```
Use the agent react-specialist to create a responsive navbar component
```

```
Use the agent security-specialist to review authentication implementation
```

## 🎓 Tips for Non-Technical Users

1. **Start with Interactive Mode**: Run `csf interactive` for a guided experience
2. **Browse Before Installing**: Use `csf list` to see what's available
3. **Read Agent Details**: Use `csf info <agent-id>` to understand what each agent does
4. **Install as Needed**: You don't need all agents - install what you need when you need it
5. **Update Regularly**: Run `csf update --all` to get the latest agent versions

## 🤝 Getting Help

```bash
# Show help for main command
csf --help

# Show help for specific command
csf install --help
csf list --help
```

## 🐛 Troubleshooting

### "Command not found: csf"

If globally installed:
```bash
npm install -g claude-subagents-cli
```

If using local installation:
```bash
npm link
```

### "Failed to load registry"

Make sure you're running the CLI from the correct location or that the framework is properly installed.

### "Permission denied"

On Unix systems, make the binary executable:
```bash
chmod +x ./bin/csf.js
```

## 📄 License

MIT

## 🔗 Links

- **GitHub**: https://github.com/allysonbarros/claude-subagents-framework
- **Issues**: https://github.com/allysonbarros/claude-subagents-framework/issues
- **Docs**: See the main repository README

## 🙏 Contributing

Contributions are welcome! Please see the main repository for contribution guidelines.

---

Made with ❤️ for the Claude Code community
