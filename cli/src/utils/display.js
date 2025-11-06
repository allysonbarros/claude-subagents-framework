const chalk = require('chalk');
const { table } = require('table');

/**
 * Display agents in a formatted table
 * @param {Array} agents - Array of agent objects
 * @param {Object} options - Display options
 */
function displayAgentsTable(agents, options = {}) {
  const { showCategory = true, showTags = true } = options;

  if (agents.length === 0) {
    console.log(chalk.yellow('No agents found.'));
    return;
  }

  const headers = ['ID', 'Name', 'Description'];
  if (showCategory) headers.push('Category');
  if (showTags) headers.push('Tags');

  const rows = [
    headers.map(h => chalk.bold.cyan(h))
  ];

  agents.forEach(agent => {
    const row = [
      chalk.green(agent.id),
      agent.name,
      truncate(agent.description, 50)
    ];

    if (showCategory) {
      row.push(chalk.blue(agent.category));
    }

    if (showTags) {
      row.push(agent.tags.slice(0, 3).join(', '));
    }

    rows.push(row);
  });

  const config = {
    columns: headers.map(() => ({ wrapWord: true })),
    columnDefault: {
      width: 20
    }
  };

  console.log(table(rows, config));
  console.log(chalk.gray(`Total: ${agents.length} agent(s)`));
}

/**
 * Display categories in a formatted list
 * @param {Array} categories - Array of category objects
 */
function displayCategories(categories) {
  console.log(chalk.bold.cyan('\nAvailable Categories:\n'));

  categories.forEach(category => {
    console.log(
      `  ${chalk.green('●')} ${chalk.bold(category.name)} ${chalk.gray(`(${category.id})`)}`
    );
    console.log(`    ${chalk.gray(category.description)}\n`);
  });
}

/**
 * Display agent details
 * @param {Object} agent - Agent object
 * @param {string} content - Agent markdown content
 */
function displayAgentInfo(agent, content) {
  console.log(chalk.bold.cyan(`\n${agent.name}`));
  console.log(chalk.gray('='.repeat(agent.name.length + 1)));

  console.log(chalk.bold('\nID:'), chalk.green(agent.id));
  console.log(chalk.bold('Category:'), chalk.blue(agent.category));
  console.log(chalk.bold('Version:'), agent.version);

  console.log(chalk.bold('\nDescription:'));
  console.log(wrapText(agent.description, 80));

  console.log(chalk.bold('\nTags:'));
  console.log(agent.tags.map(tag => chalk.cyan(`#${tag}`)).join('  '));

  // Extract key sections from markdown
  const capabilities = extractSection(content, '## Capacidades');
  const whenToUse = extractSection(content, '## Quando Usar');

  if (capabilities) {
    console.log(chalk.bold('\nCapabilities:'));
    console.log(capabilities);
  }

  if (whenToUse) {
    console.log(chalk.bold('\nWhen to Use:'));
    console.log(whenToUse);
  }

  console.log(chalk.bold('\nInstall:'));
  console.log(chalk.cyan(`  rambo install ${agent.id}`));

  console.log();
}

/**
 * Display installation results
 * @param {Object} results - Results object from installation
 */
function displayInstallResults(results) {
  if (results.success.length > 0) {
    console.log(chalk.bold.green(`\n✓ Successfully installed ${results.success.length} agent(s):`));
    results.success.forEach(agent => {
      console.log(`  ${chalk.green('●')} ${agent.name} ${chalk.gray(`(${agent.id})`)}`);
    });
  }

  if (results.failed.length > 0) {
    console.log(chalk.bold.red(`\n✗ Failed to install ${results.failed.length} agent(s):`));
    results.failed.forEach(({ agent, error }) => {
      console.log(`  ${chalk.red('●')} ${agent.name}: ${error}`);
    });
  }
}

/**
 * Display success message
 * @param {string} message - Success message
 */
function success(message) {
  console.log(chalk.green(`✓ ${message}`));
}

/**
 * Display error message
 * @param {string} message - Error message
 */
function error(message) {
  console.log(chalk.red(`✗ ${message}`));
}

/**
 * Display warning message
 * @param {string} message - Warning message
 */
function warning(message) {
  console.log(chalk.yellow(`⚠ ${message}`));
}

/**
 * Display info message
 * @param {string} message - Info message
 */
function info(message) {
  console.log(chalk.cyan(`ℹ ${message}`));
}

// Helper functions

function truncate(str, length) {
  if (str.length <= length) return str;
  return str.substring(0, length - 3) + '...';
}

function wrapText(text, width) {
  const words = text.split(' ');
  const lines = [];
  let currentLine = '';

  words.forEach(word => {
    if ((currentLine + word).length > width) {
      lines.push(currentLine.trim());
      currentLine = word + ' ';
    } else {
      currentLine += word + ' ';
    }
  });

  if (currentLine.trim()) {
    lines.push(currentLine.trim());
  }

  return lines.map(line => `  ${line}`).join('\n');
}

function extractSection(content, heading) {
  const lines = content.split('\n');
  const startIndex = lines.findIndex(line => line.trim() === heading);

  if (startIndex === -1) return null;

  const endIndex = lines.findIndex((line, index) =>
    index > startIndex && line.startsWith('## ')
  );

  const sectionLines = endIndex === -1
    ? lines.slice(startIndex + 1)
    : lines.slice(startIndex + 1, endIndex);

  return sectionLines
    .filter(line => line.trim())
    .map(line => `  ${line}`)
    .join('\n')
    .substring(0, 500);
}

module.exports = {
  displayAgentsTable,
  displayCategories,
  displayAgentInfo,
  displayInstallResults,
  success,
  error,
  warning,
  info
};
