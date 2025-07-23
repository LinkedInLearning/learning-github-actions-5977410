#!/usr/bin/env node

const fs = require('fs');
const mt19937 = require('@stdlib/random-base-mt19937');

const MAX_UINT32 = 0xFFFFFFFF; // 2^32 - 1

// Get the seed from CLI args or use timestamp-based fallback
const seedArg = process.argv[2];
const seedStr = seedArg || (Date.now() % (MAX_UINT32 + 1)).toString();

// Convert to numeric seed (safely constrained to 32-bit range)
const seed = isNaN(Number(seedStr))
  ? hashString(seedStr)
  : Math.min(Number(seedStr), MAX_UINT32);

// Initialize PRNG
const prng = mt19937.factory({ seed });

// Generate 5 pseudo-random numbers
const numbers = Array.from({ length: 5 }, () => prng());

// Format the report
const report = `
Seed value used: ${seedArg || '(timestamp) ' + seedStr}
Random values:
${numbers.map((n, i) => `  ${i + 1}: ${n.toFixed(6)}`).join('\n')}
`;

// Write to report file
fs.writeFileSync('report.txt', report.trim() + '\n');
console.log(report.trim());

/**
 * Convert a string to a bounded positive 32-bit integer
 */
function hashString(str) {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = ((hash << 5) - hash) + str.charCodeAt(i);
    hash |= 0; // Convert to 32-bit signed int
  }
  return Math.abs(hash) % (MAX_UINT32 + 1);
}
