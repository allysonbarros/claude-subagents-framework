const chalk = require('chalk');
const { searchAgents } = require('../utils/registry');
const { displayAgentsTable } = require('../utils/display');

async function searchCommand(query, options) {
  try {
    const { json } = options;

    const results = searchAgents(query);

    if (results.length === 0) {
      console.log(chalk.yellow(`No agents found matching: "${query}"`));
      console.log(chalk.gray('\nTry:'));
      console.log(chalk.cyan('  csf list'), chalk.gray('- to see all available agents'));
      console.log(chalk.cyan('  csf search <different-query>'), chalk.gray('- to search with different terms'));
      return;
    }

    if (json) {
      console.log(JSON.stringify(results, null, 2));
    } else {
      console.log(chalk.bold.cyan(`\nSearch results for: "${query}"\n`));
      displayAgentsTable(results);

      console.log();
      console.log(chalk.gray('Use'), chalk.cyan('csf info <agent-id>'), chalk.gray('for more details'));
      console.log(chalk.gray('Use'), chalk.cyan('csf install <agent-id>'), chalk.gray('to install an agent'));
    }
  } catch (error) {
    console.error(chalk.red('Error:'), error.message);
    process.exit(1);
  }
}

module.exports = searchCommand;
