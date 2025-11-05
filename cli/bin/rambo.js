#!/usr/bin/env node

/**
 * Rambo Code Experts CLI
 * Elite AI agents for code excellence
 * Entry point for the CLI application
 */

const path = require('path');
const cli = require('../src/index');

// Set the framework root directory
process.env.RAMBO_ROOT = path.resolve(__dirname, '../..');

// Run the CLI
cli.run().catch(error => {
  console.error('Error:', error.message);
  process.exit(1);
});
