const chalk = require('chalk');
const { getAgentById, readAgentFile } = require('../utils/registry');
const { displayAgentInfo, error } = require('../utils/display');

async function infoCommand(agentId) {
  try {
    const agent = getAgentById(agentId);

    if (!agent) {
      error(`Agent not found: ${agentId}`);
      console.log(chalk.gray('\nUse'), chalk.cyan('rambo list'), chalk.gray('to see available agents'));
      console.log(chalk.gray('Use'), chalk.cyan('rambo search <query>'), chalk.gray('to search for agents'));
      process.exit(1);
    }

    // Read agent markdown file
    const content = readAgentFile(agent);

    // Display agent information
    displayAgentInfo(agent, content);
  } catch (err) {
    error(err.message);
    process.exit(1);
  }
}

module.exports = infoCommand;
