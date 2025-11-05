const chalk = require('chalk');
const path = require('path');
const ora = require('ora');
const { initializeProject } = require('../utils/installer');
const { success, error, info } = require('../utils/display');

async function initCommand(options) {
  try {
    const { dest } = options;

    // Determine project directory
    const projectDir = dest ? path.resolve(dest) : process.cwd();

    console.log(chalk.cyan(`\nInitializing Claude Code agents structure...\n`));
    info(`Project directory: ${projectDir}`);
    console.log();

    const spinner = ora('Creating directories...').start();

    const paths = await initializeProject(projectDir);

    spinner.succeed('Directories created');

    console.log();
    success('Project initialized successfully!');
    console.log();
    console.log(chalk.bold('Created:'));
    console.log(`  ${chalk.cyan(paths.claudeDir)}`);
    console.log(`  ${chalk.cyan(paths.agentsDir)}`);
    console.log(`  ${chalk.cyan(paths.readmePath)}`);
    console.log();
    console.log(chalk.bold('Next steps:'));
    console.log(chalk.gray('  1.'), chalk.cyan('csf list'), chalk.gray('- Browse available agents'));
    console.log(chalk.gray('  2.'), chalk.cyan('csf install <agent-id>'), chalk.gray('- Install agents'));
    console.log(chalk.gray('  3.'), chalk.cyan('csf interactive'), chalk.gray('- Use interactive mode'));
    console.log();
  } catch (err) {
    error(err.message);
    process.exit(1);
  }
}

module.exports = initCommand;
