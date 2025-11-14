const { program } = require('commander');
const chalk = require('chalk');
const packageJson = require('../package.json');

// Import commands
const listCommand = require('./commands/list');
const searchCommand = require('./commands/search');
const installCommand = require('./commands/install');
const infoCommand = require('./commands/info');
const initCommand = require('./commands/init');
const interactiveCommand = require('./commands/interactive');
const updateCommand = require('./commands/update');

// Rambo ASCII Art (updated to match pixel-style logo)
const RAMBO_ART = `
${chalk.green('                ██████████                ')}
${chalk.green('             ████        ████             ')}
${chalk.green('           ███              ███           ')}
${chalk.green('         ███                  ███         ')}
${chalk.green('        ██      ')}${chalk.gray('████████████')}${chalk.green('      ██        ')}
${chalk.green('       ██     ')}${chalk.gray('██')}${chalk.green('          ')}${chalk.gray('██')}${chalk.green('     ██       ')}
${chalk.green('      ██      ')}${chalk.gray('██')}${chalk.green('          ')}${chalk.gray('██')}${chalk.green('      ██      ')}
${chalk.green('      ██      ')}${chalk.gray('██')}${chalk.green('   ████  ████ ')}${chalk.gray('██')}${chalk.green('      ██      ')}
${chalk.green('      ██      ')}${chalk.gray('██')}${chalk.green('  ██  ████  ██')}${chalk.gray('██')}${chalk.green('      ██      ')}
${chalk.green('       ██     ')}${chalk.gray('████████████')}${chalk.green('     ██       ')}
${chalk.green('        ██                  ██        ')}
${chalk.green('         ███                ███         ')}
${chalk.green('           ███            ███           ')}
${chalk.green('             ████      ████             ')}
${chalk.green('                ██████████                ')}

${chalk.bold.white('   R A M B O   C O D E   E X P E R T S')}
${chalk.gray('   -----------------------------------')}
${chalk.cyan('   Elite AI Agent Squadron — Mission: Code Excellence')}
`;

async function run() {
  program
    .name('rambo')
    .description('Rambo Code Experts Agents - Elite AI agents for code excellence')
    .version(packageJson.version)
    .addHelpText('before', RAMBO_ART)
    .addHelpText('after', `
${chalk.bold('Examples:')}
  ${chalk.cyan('rambo list')}                    List all available agents
  ${chalk.cyan('rambo list --category frontend')} List agents in a specific category
  ${chalk.cyan('rambo search react')}            Search for agents
  ${chalk.cyan('rambo info react-specialist')}   Show agent details
  ${chalk.cyan('rambo install product-manager')} Install an agent
  ${chalk.cyan('rambo init')}                    Initialize project with agents
  ${chalk.cyan('rambo interactive')}             Interactive mode (recommended for beginners)

${chalk.bold('Categories:')}
  ${chalk.green('strategists')}     - Planning and architecture
  ${chalk.green('researchers')}     - Code exploration and research
  ${chalk.green('design-and-ux')}   - UI/UX design and content
  ${chalk.green('frontend')}        - Frontend development
  ${chalk.green('backend')}         - Backend development
  ${chalk.green('testers')}         - Testing and QA
  ${chalk.green('devops')}          - CI/CD and infrastructure
  ${chalk.green('analytics')}       - Analytics and experiments
  ${chalk.green('ai-ml')}           - AI and machine learning
  ${chalk.green('data-engineering')} - Data engineering and platforms

${chalk.bold('Learn more:')}
  GitHub: https://github.com/allysonbarros/claude-subagents-framework
    `);

  // List command
  program
    .command('list')
    .description('List all available agents')
    .option('-c, --category <category>', 'Filter by category')
    .option('-t, --tags <tags>', 'Filter by tags (comma-separated)')
    .option('--json', 'Output as JSON')
    .action(listCommand);

  // Search command
  program
    .command('search <query>')
    .description('Search for agents by name, description, or tags')
    .option('--json', 'Output as JSON')
    .action(searchCommand);

  // Install command
  program
    .command('install [agents...]')
    .description('Install one or more agents to your project')
    .option('-d, --dest <path>', 'Destination directory (default: ./.claude/agents)')
    .option('-f, --force', 'Overwrite existing files')
    .option('--all-category <category>', 'Install all agents from a category')
    .action(installCommand);

  // Info command
  program
    .command('info <agent-id>')
    .description('Show detailed information about an agent')
    .action(infoCommand);

  // Init command
  program
    .command('init')
    .description('Initialize Claude Code agents structure in your project')
    .option('-d, --dest <path>', 'Destination directory (default: ./.claude)')
    .action(initCommand);

  // Update command
  program
    .command('update [agents...]')
    .description('Update installed agents to latest version')
    .option('-d, --dest <path>', 'Agents directory (default: ./.claude/agents)')
    .option('--all', 'Update all installed agents')
    .action(updateCommand);

  // Interactive command
  program
    .command('interactive')
    .alias('i')
    .description('Interactive mode - guided agent selection and installation')
    .action(interactiveCommand);

  await program.parseAsync(process.argv);

  // Show help if no command provided
  if (!process.argv.slice(2).length) {
    program.outputHelp();
  }
}

module.exports = { run };
