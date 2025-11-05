const fs = require('fs-extra');
const path = require('path');
const { getAgentFilePath } = require('./registry');

/**
 * Install an agent to a destination directory
 * @param {Object} agent - Agent object
 * @param {string} destDir - Destination directory
 * @param {Object} options - Installation options
 * @returns {boolean} True if installed successfully
 */
async function installAgent(agent, destDir, options = {}) {
  const { force = false } = options;

  // Ensure destination directory exists
  await fs.ensureDir(destDir);

  // Source and destination paths
  const sourcePath = getAgentFilePath(agent);
  const destPath = path.join(destDir, `${agent.id}.md`);

  // Check if file already exists
  if (!force && await fs.pathExists(destPath)) {
    throw new Error(`Agent already exists: ${destPath}. Use --force to overwrite.`);
  }

  // Copy the file
  await fs.copy(sourcePath, destPath);

  return true;
}

/**
 * Install multiple agents
 * @param {Array} agents - Array of agent objects
 * @param {string} destDir - Destination directory
 * @param {Object} options - Installation options
 * @returns {Object} Results object with success and failed installations
 */
async function installMultipleAgents(agents, destDir, options = {}) {
  const results = {
    success: [],
    failed: []
  };

  for (const agent of agents) {
    try {
      await installAgent(agent, destDir, options);
      results.success.push(agent);
    } catch (error) {
      results.failed.push({ agent, error: error.message });
    }
  }

  return results;
}

/**
 * Check if agent is installed
 * @param {Object} agent - Agent object
 * @param {string} destDir - Destination directory
 * @returns {boolean} True if agent is installed
 */
async function isAgentInstalled(agent, destDir) {
  const destPath = path.join(destDir, `${agent.id}.md`);
  return await fs.pathExists(destPath);
}

/**
 * Get list of installed agents
 * @param {string} destDir - Destination directory
 * @returns {Array} Array of installed agent IDs
 */
async function getInstalledAgents(destDir) {
  try {
    const files = await fs.readdir(destDir);
    return files
      .filter(file => file.endsWith('.md'))
      .map(file => file.replace('.md', ''));
  } catch (error) {
    return [];
  }
}

/**
 * Initialize Claude Code agents structure
 * @param {string} projectDir - Project directory
 * @returns {Object} Paths created
 */
async function initializeProject(projectDir) {
  const claudeDir = path.join(projectDir, '.claude');
  const agentsDir = path.join(claudeDir, 'agents');

  // Create directories
  await fs.ensureDir(agentsDir);

  // Create .gitignore if it doesn't exist
  const gitignorePath = path.join(projectDir, '.gitignore');
  let gitignoreContent = '';

  if (await fs.pathExists(gitignorePath)) {
    gitignoreContent = await fs.readFile(gitignorePath, 'utf-8');
  }

  // Add .claude to .gitignore if not present
  if (!gitignoreContent.includes('.claude')) {
    const newContent = gitignoreContent
      ? `${gitignoreContent}\n\n# Claude Code\n.claude/\n`
      : '# Claude Code\n.claude/\n';
    await fs.writeFile(gitignorePath, newContent);
  }

  // Create README in agents directory
  const readmePath = path.join(agentsDir, 'README.md');
  const readmeContent = `# Rambo Code Experts Agents

This directory contains Claude Code subagents installed from Rambo Code Experts.

## Installed Agents

Use \`rambo list\` to see available agents.
Use \`rambo install <agent-id>\` to install more agents.
Use \`rambo info <agent-id>\` to see agent details.

## Usage

In Claude Code, you can invoke agents like:
\`\`\`
Use the agent <agent-id> to <task>
\`\`\`

## Learn More

GitHub: https://github.com/allysonbarros/claude-subagents-framework
`;

  await fs.writeFile(readmePath, readmeContent);

  return {
    claudeDir,
    agentsDir,
    readmePath
  };
}

/**
 * Uninstall an agent
 * @param {string} agentId - Agent ID
 * @param {string} destDir - Destination directory
 * @returns {boolean} True if uninstalled successfully
 */
async function uninstallAgent(agentId, destDir) {
  const destPath = path.join(destDir, `${agentId}.md`);

  if (!await fs.pathExists(destPath)) {
    throw new Error(`Agent not installed: ${agentId}`);
  }

  await fs.remove(destPath);
  return true;
}

module.exports = {
  installAgent,
  installMultipleAgents,
  isAgentInstalled,
  getInstalledAgents,
  initializeProject,
  uninstallAgent
};
