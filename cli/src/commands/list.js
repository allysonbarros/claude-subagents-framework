const chalk = require('chalk');
const {
  getAllAgents,
  getAgentsByCategory,
  filterAgentsByTags,
  getCategories
} = require('../utils/registry');
const { displayAgentsTable, displayCategories } = require('../utils/display');

async function listCommand(options) {
  try {
    const { category, tags, json } = options;

    let agents;

    if (category) {
      // List agents by category
      agents = getAgentsByCategory(category);

      if (agents.length === 0) {
        console.log(chalk.yellow(`No agents found in category: ${category}`));
        console.log(chalk.gray('\nAvailable categories:'));
        const categories = getCategories();
        categories.forEach(cat => {
          console.log(`  - ${cat.id}`);
        });
        return;
      }
    } else if (tags) {
      // List agents by tags
      const tagArray = tags.split(',').map(t => t.trim());
      agents = filterAgentsByTags(tagArray);

      if (agents.length === 0) {
        console.log(chalk.yellow(`No agents found with tags: ${tags}`));
        return;
      }
    } else {
      // List all agents
      agents = getAllAgents();
    }

    if (json) {
      // Output as JSON
      console.log(JSON.stringify(agents, null, 2));
    } else {
      // Display as table
      if (!category && !tags) {
        console.log(chalk.bold.cyan('\nAvailable Claude Code Subagents\n'));
        displayCategories(getCategories());
        console.log();
      }

      displayAgentsTable(agents, {
        showCategory: !category,
        showTags: true
      });

      console.log();
      console.log(chalk.gray('Use'), chalk.cyan('rambo info <agent-id>'), chalk.gray('for more details'));
      console.log(chalk.gray('Use'), chalk.cyan('rambo install <agent-id>'), chalk.gray('to install an agent'));
    }
  } catch (error) {
    console.error(chalk.red('Error:'), error.message);
    process.exit(1);
  }
}

module.exports = listCommand;
