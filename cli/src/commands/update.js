const chalk = require('chalk');
const path = require('path');
const ora = require('ora');
const {
  getAgentById,
  getAllAgents
} = require('../utils/registry');
const {
  installMultipleAgents,
  getInstalledAgents
} = require('../utils/installer');
const { displayInstallResults, error, info, warning } = require('../utils/display');

async function updateCommand(agents, options) {
  try {
    const { dest, all } = options;

    // Determine destination
    const destDir = dest
      ? path.resolve(dest)
      : path.resolve(process.cwd(), '.claude', 'agents');

    let agentsToUpdate = [];

    if (all) {
      // Update all installed agents
      const spinner = ora('Detecting installed agents...').start();

      const installedIds = await getInstalledAgents(destDir);

      if (installedIds.length === 0) {
        spinner.fail('No agents installed');
        info(`Looking in: ${destDir}`);
        console.log(chalk.gray('\nUse'), chalk.cyan('csf install <agent-id>'), chalk.gray('to install agents'));
        process.exit(0);
      }

      spinner.succeed(`Found ${installedIds.length} installed agent(s)`);

      agentsToUpdate = installedIds
        .map(id => getAgentById(id))
        .filter(agent => agent !== null);

      if (agentsToUpdate.length < installedIds.length) {
        warning(`Some installed agents not found in registry`);
      }
    } else if (!agents || agents.length === 0) {
      error('Please specify agents to update or use --all');
      console.log(chalk.gray('\nExamples:'));
      console.log(chalk.cyan('  csf update product-manager'));
      console.log(chalk.cyan('  csf update react-specialist state-manager'));
      console.log(chalk.cyan('  csf update --all'));
      process.exit(1);
    } else {
      // Update specific agents
      for (const agentId of agents) {
        const agent = getAgentById(agentId);

        if (!agent) {
          error(`Agent not found: ${agentId}`);
          console.log(chalk.gray('Use'), chalk.cyan('csf list'), chalk.gray('to see available agents'));
          process.exit(1);
        }

        agentsToUpdate.push(agent);
      }
    }

    // Update agents (force overwrite)
    console.log(chalk.cyan(`\nUpdating ${agentsToUpdate.length} agent(s)...\n`));

    const results = await installMultipleAgents(agentsToUpdate, destDir, { force: true });

    // Display results
    displayInstallResults(results);

    if (results.success.length > 0) {
      console.log();
      info(`Updated agents in: ${chalk.cyan(destDir)}`);
      console.log();
    }

    // Exit with error code if any updates failed
    if (results.failed.length > 0) {
      process.exit(1);
    }
  } catch (err) {
    error(err.message);
    process.exit(1);
  }
}

module.exports = updateCommand;
