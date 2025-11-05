const chalk = require('chalk');
const inquirer = require('inquirer');
const path = require('path');
const {
  getCategories,
  getAgentsByCategory,
  getAgentById
} = require('../utils/registry');
const {
  installMultipleAgents,
  initializeProject,
  getInstalledAgents
} = require('../utils/installer');
const { displayInstallResults, success } = require('../utils/display');

async function interactiveCommand() {
  console.log(chalk.bold.cyan('\n🤖 Claude Subagents Framework - Interactive Mode\n'));
  console.log(chalk.gray('This wizard will help you select and install agents for your project.\n'));

  try {
    // Step 1: Choose destination
    const { useCurrentDir } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'useCurrentDir',
        message: 'Install agents in current directory?',
        default: true
      }
    ]);

    let projectDir = process.cwd();

    if (!useCurrentDir) {
      const { customDir } = await inquirer.prompt([
        {
          type: 'input',
          name: 'customDir',
          message: 'Enter project directory:',
          default: process.cwd()
        }
      ]);
      projectDir = path.resolve(customDir);
    }

    const destDir = path.join(projectDir, '.claude', 'agents');

    // Check if already initialized
    const installedAgents = await getInstalledAgents(destDir);
    const isInitialized = installedAgents.length > 0;

    if (isInitialized) {
      console.log(chalk.green(`\n✓ Found ${installedAgents.length} installed agent(s)\n`));
    }

    // Step 2: Choose action
    const { action } = await inquirer.prompt([
      {
        type: 'list',
        name: 'action',
        message: 'What would you like to do?',
        choices: [
          { name: '📦 Install new agents', value: 'install' },
          { name: '🔍 Browse agents by category', value: 'browse' },
          { name: '🎯 Quick install (popular agents)', value: 'quick' },
          { name: '🚀 Install complete category', value: 'category' },
          { name: '❌ Exit', value: 'exit' }
        ]
      }
    ]);

    if (action === 'exit') {
      console.log(chalk.gray('\nGoodbye! 👋\n'));
      return;
    }

    let selectedAgents = [];

    if (action === 'browse') {
      // Browse by category
      const categories = getCategories();

      const { category } = await inquirer.prompt([
        {
          type: 'list',
          name: 'category',
          message: 'Choose a category:',
          choices: categories.map(cat => ({
            name: `${cat.name} - ${cat.description}`,
            value: cat.id
          }))
        }
      ]);

      const agents = getAgentsByCategory(category);

      const { agentIds } = await inquirer.prompt([
        {
          type: 'checkbox',
          name: 'agentIds',
          message: 'Select agents to install (Space to select, Enter to confirm):',
          choices: agents.map(agent => ({
            name: `${agent.name} - ${agent.description}`,
            value: agent.id,
            checked: false
          })),
          validate: (answer) => {
            if (answer.length < 1) {
              return 'You must choose at least one agent.';
            }
            return true;
          }
        }
      ]);

      selectedAgents = agentIds.map(id => getAgentById(id));
    } else if (action === 'quick') {
      // Quick install popular agents
      const popularAgents = [
        'product-manager',
        'tech-architect',
        'react-specialist',
        'api-developer',
        'unit-tester',
        'ci-cd-engineer'
      ];

      const { agentIds } = await inquirer.prompt([
        {
          type: 'checkbox',
          name: 'agentIds',
          message: 'Select popular agents to install:',
          choices: popularAgents.map(id => {
            const agent = getAgentById(id);
            return {
              name: `${agent.name} (${agent.category}) - ${agent.description}`,
              value: agent.id,
              checked: true
            };
          }),
          validate: (answer) => {
            if (answer.length < 1) {
              return 'You must choose at least one agent.';
            }
            return true;
          }
        }
      ]);

      selectedAgents = agentIds.map(id => getAgentById(id));
    } else if (action === 'category') {
      // Install complete category
      const categories = getCategories();

      const { category } = await inquirer.prompt([
        {
          type: 'list',
          name: 'category',
          message: 'Choose a category to install all agents:',
          choices: categories.map(cat => ({
            name: `${cat.name} - ${cat.description}`,
            value: cat.id
          }))
        }
      ]);

      selectedAgents = getAgentsByCategory(category);

      const { confirm } = await inquirer.prompt([
        {
          type: 'confirm',
          name: 'confirm',
          message: `Install all ${selectedAgents.length} agents from this category?`,
          default: true
        }
      ]);

      if (!confirm) {
        console.log(chalk.gray('\nInstallation cancelled.\n'));
        return;
      }
    } else if (action === 'install') {
      // Manual selection from all agents
      const categories = getCategories();
      const allAgents = [];

      categories.forEach(cat => {
        const agents = getAgentsByCategory(cat.id);
        allAgents.push(
          new inquirer.Separator(`\n${chalk.bold.cyan(cat.name)}`),
          ...agents.map(agent => ({
            name: `  ${agent.name} - ${agent.description}`,
            value: agent.id
          }))
        );
      });

      const { agentIds } = await inquirer.prompt([
        {
          type: 'checkbox',
          name: 'agentIds',
          message: 'Select agents to install:',
          choices: allAgents,
          pageSize: 15,
          validate: (answer) => {
            if (answer.length < 1) {
              return 'You must choose at least one agent.';
            }
            return true;
          }
        }
      ]);

      selectedAgents = agentIds.map(id => getAgentById(id));
    }

    if (selectedAgents.length === 0) {
      console.log(chalk.yellow('\nNo agents selected.\n'));
      return;
    }

    // Step 3: Confirm installation
    console.log(chalk.cyan(`\n📦 Installing ${selectedAgents.length} agent(s)...\n`));

    // Initialize project
    await initializeProject(projectDir);

    // Install agents
    const results = await installMultipleAgents(selectedAgents, destDir, { force: true });

    // Display results
    displayInstallResults(results);

    if (results.success.length > 0) {
      console.log();
      success(`Agents installed to: ${chalk.cyan(destDir)}`);
      console.log();
      console.log(chalk.bold('🎉 Installation complete!'));
      console.log();
      console.log(chalk.bold('Next steps:'));
      console.log(chalk.gray('  1. Open your project in Claude Code'));
      console.log(chalk.gray('  2. Use agents like:'), chalk.cyan(`"Use the agent ${results.success[0].id} to <task>"`));
      console.log(chalk.gray('  3. Run'), chalk.cyan('csf list'), chalk.gray('to see all available agents'));
      console.log();
    }

    // Ask if user wants to continue
    const { continue: continueAction } = await inquirer.prompt([
      {
        type: 'confirm',
        name: 'continue',
        message: 'Install more agents?',
        default: false
      }
    ]);

    if (continueAction) {
      await interactiveCommand();
    } else {
      console.log(chalk.gray('\nHappy coding! 🚀\n'));
    }
  } catch (err) {
    if (err.isTtyError) {
      console.error(chalk.red('Error: Interactive mode not supported in this environment'));
    } else {
      console.error(chalk.red('Error:'), err.message);
    }
    process.exit(1);
  }
}

module.exports = interactiveCommand;
