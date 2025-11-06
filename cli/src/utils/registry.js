const fs = require('fs-extra');
const path = require('path');

function getRegistryPath() {
  if (!process.env.RAMBO_ROOT) {
    // Fallback: calculate from current file location
    return path.join(__dirname, '../../..', 'registry.json');
  }
  return path.join(process.env.RAMBO_ROOT, 'registry.json');
}

const REGISTRY_PATH = getRegistryPath();

/**
 * Load the agents registry
 * @returns {Object} Registry object with categories and agents
 */
function loadRegistry() {
  try {
    return fs.readJsonSync(REGISTRY_PATH);
  } catch (error) {
    throw new Error(`Failed to load registry: ${error.message}`);
  }
}

/**
 * Get all agents
 * @returns {Array} Array of all agents
 */
function getAllAgents() {
  const registry = loadRegistry();
  return registry.agents || [];
}

/**
 * Get agent by ID
 * @param {string} agentId - Agent ID
 * @returns {Object|null} Agent object or null if not found
 */
function getAgentById(agentId) {
  const agents = getAllAgents();
  return agents.find(agent => agent.id === agentId) || null;
}

/**
 * Get agents by category
 * @param {string} category - Category ID
 * @returns {Array} Array of agents in the category
 */
function getAgentsByCategory(category) {
  const agents = getAllAgents();
  return agents.filter(agent => agent.category === category);
}

/**
 * Get all categories
 * @returns {Array} Array of categories
 */
function getCategories() {
  const registry = loadRegistry();
  return registry.categories || [];
}

/**
 * Get category by ID
 * @param {string} categoryId - Category ID
 * @returns {Object|null} Category object or null if not found
 */
function getCategoryById(categoryId) {
  const categories = getCategories();
  return categories.find(cat => cat.id === categoryId) || null;
}

/**
 * Search agents by query
 * @param {string} query - Search query
 * @returns {Array} Array of matching agents
 */
function searchAgents(query) {
  const agents = getAllAgents();
  const lowerQuery = query.toLowerCase();

  return agents.filter(agent => {
    // Search in ID, name, description
    const matchesText =
      agent.id.toLowerCase().includes(lowerQuery) ||
      agent.name.toLowerCase().includes(lowerQuery) ||
      agent.description.toLowerCase().includes(lowerQuery);

    // Search in tags
    const matchesTags = agent.tags.some(tag =>
      tag.toLowerCase().includes(lowerQuery)
    );

    return matchesText || matchesTags;
  });
}

/**
 * Filter agents by tags
 * @param {Array} tags - Array of tags to filter by
 * @returns {Array} Array of matching agents
 */
function filterAgentsByTags(tags) {
  const agents = getAllAgents();
  const lowerTags = tags.map(tag => tag.toLowerCase());

  return agents.filter(agent => {
    return agent.tags.some(tag =>
      lowerTags.includes(tag.toLowerCase())
    );
  });
}

/**
 * Get agent file path
 * @param {Object} agent - Agent object
 * @returns {string} Absolute path to agent markdown file
 */
function getAgentFilePath(agent) {
  return path.join(
    process.env.RAMBO_ROOT,
    'agents',
    agent.category,
    `${agent.id}.md`
  );
}

/**
 * Read agent markdown file
 * @param {Object} agent - Agent object
 * @returns {string} Agent markdown content
 */
function readAgentFile(agent) {
  const filePath = getAgentFilePath(agent);
  try {
    return fs.readFileSync(filePath, 'utf-8');
  } catch (error) {
    throw new Error(`Failed to read agent file: ${error.message}`);
  }
}

module.exports = {
  loadRegistry,
  getAllAgents,
  getAgentById,
  getAgentsByCategory,
  getCategories,
  getCategoryById,
  searchAgents,
  filterAgentsByTags,
  getAgentFilePath,
  readAgentFile
};
