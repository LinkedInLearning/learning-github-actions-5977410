{
  "name": "random-number-generator",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "build": "bun build --compile --minify --sourcemap --target bun-linux-x64 --outfile random-number-generator-linux ./random-number-generator.js && bun build --compile --minify --sourcemap --target bun-darwin-arm64 --outfile random-number-generator-macos ./random-number-generator.js",
    "test": "bun random-number-generator.js test-seed"
  },
  "dependencies": {
    "@stdlib/random-base-mt19937": "^0.2.1"
  }
}
