const chalk = require('chalk');
const path = require('path');
const ora = require('ora');
const {
  getAgentById,
  getAgentsByCategory,
  getCategoryById
} = require('../utils/registry');
const {
  installMultipleAgents,
  initializeProject
} = require('../utils/installer');
const { displayInstallResults, success, error } = require('../utils/display');

async function installCommand(agents, options) {
  try {
    const { dest, force, allCategory } = options;

    // Determine destination
    const destDir = dest
      ? path.resolve(dest)
      : path.resolve(process.cwd(), '.claude', 'agents');

    let agentsToInstall = [];

    if (allCategory) {
      // Install all agents from a category
      const category = getCategoryById(allCategory);

      if (!category) {
        error(`Category not found: ${allCategory}`);
        console.log(chalk.gray('\nUse'), chalk.cyan('rambo list'), chalk.gray('to see available categories'));
        process.exit(1);
      }

      agentsToInstall = getAgentsByCategory(allCategory);

      if (agentsToInstall.length === 0) {
        error(`No agents found in category: ${allCategory}`);
        process.exit(1);
      }

      console.log(chalk.cyan(`Installing all ${agentsToInstall.length} agents from category: ${category.name}\n`));
    } else if (!agents || agents.length === 0) {
      // No agents specified
      error('Please specify at least one agent to install');
      console.log(chalk.gray('\nExamples:'));
      console.log(chalk.cyan('  rambo install product-manager'));
      console.log(chalk.cyan('  rambo install react-specialist state-manager'));
      console.log(chalk.cyan('  rambo install --all-category frontend'));
      console.log();
      console.log(chalk.gray('Use'), chalk.cyan('rambo list'), chalk.gray('to see available agents'));
      process.exit(1);
    } else {
      // Install specific agents
      for (const agentId of agents) {
        const agent = getAgentById(agentId);

        if (!agent) {
          error(`Agent not found: ${agentId}`);
          console.log(chalk.gray('Use'), chalk.cyan('rambo list'), chalk.gray('to see available agents'));
          process.exit(1);
        }

        agentsToInstall.push(agent);
      }
    }

    // Initialize project structure if needed
    const projectDir = path.dirname(path.dirname(destDir));
    const spinner = ora('Initializing project structure...').start();

    try {
      await initializeProject(projectDir);
      spinner.succeed('Project structure initialized');
    } catch (err) {
      spinner.fail('Failed to initialize project structure');
      throw err;
    }

    // Install agents
    const installSpinner = ora(`Installing ${agentsToInstall.length} agent(s)...`).start();

    const results = await installMultipleAgents(agentsToInstall, destDir, { force });

    installSpinner.stop();

    // Display results
    displayInstallResults(results);

    if (results.success.length > 0) {
      console.log();
      success(`Agents installed to: ${chalk.cyan(destDir)}`);
      console.log();
      console.log(chalk.bold('Next steps:'));
      console.log(chalk.gray('  1. Open your project in Claude Code'));
      console.log(chalk.gray('  2. Use agents like:'), chalk.cyan(`"Use the agent ${results.success[0].id} to <task>"`));
      console.log();
    }

    // Exit with error code if any installations failed
    if (results.failed.length > 0) {
      process.exit(1);
    }
  } catch (err) {
    error(err.message);
    process.exit(1);
  }
}

module.exports = installCommand;
