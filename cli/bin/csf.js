#!/usr/bin/env node

/**
 * Claude Subagents Framework CLI
 * Entry point for the CLI application
 */

const path = require('path');
const cli = require('../src/index');

// Set the framework root directory
process.env.CSF_ROOT = path.resolve(__dirname, '../..');

// Run the CLI
cli.run().catch(error => {
  console.error('Error:', error.message);
  process.exit(1);
});
