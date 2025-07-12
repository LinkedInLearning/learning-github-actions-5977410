# 00_03 Working With YAML Files

Workflows used with GitHub Actions are coded in YAML format.

1. **What is YAML?**

   - YAML = “YAML Ain’t Markup Language” (recursive acronym).
   - Not a markup language — it's used for data serialization.

2. **Purpose of YAML in GitHub Actions**

   - Defines workflows and actions by describing their attributes.
   - Serialization = structured, readable format for both humans and machines.

3. **YAML File Extensions**

   - Common extensions: `.yml` and `.yaml`
   - Both are valid for GitHub workflows.

4. **Formatting Rules**

   - Relies on **indentation**, **colons**, **dashes**, etc.
   - Proper formatting is crucial (YAML is whitespace-sensitive).

5. **Recommended Editors**

   - Many modern code editors support YAML formatting including but not limited to:

      - [**Neovim**](https://neovim.io/)
      - [**Visual Studio Code**](https://code.visualstudio.com/)
      - [**GitHub’s web editor**](https://docs.github.com/en/codespaces/the-githubdev-web-based-editor).

   - These and other tools help manage indentation and catch formatting errors.

## Whitespace and Other Considerations

- **Leading/Trailing Whitespace:** Should be handled carefully as YAML is sensitive to indentation. It's best practice to avoid them or use quotes to explicitly preserve them.
- **Tabs:** YAML considers tab characters as illegal for indentation. You must use spaces instead.
- **Unicode Control Characters:** Are explicitly excluded in YAML streams for readability.
- **"Yes" and "No":** Should be quoted if intended as literal strings, otherwise, they may be interpreted as the boolean values `True` and `False`.
- **Numbers:** If a string starts with a number but should be a string (e.g., a version number), it should be quoted.

## Characters with Special Meaning in YAML

YAML uses several characters for its syntax and structuring data. These characters are considered restricted or special and require careful handling to avoid syntax errors.

Here are some of the most common restricted characters and how they are used:

| Character | Name | Description |
| --------- | --- | --- |
| `#`       | Hash/Pound Sign | Starts a comment, ignoring the rest of the line. |
| `:`       | Colon | Separates keys from values in key-value pairs. |
| `-`       | Dash/Hyphen | Indicates an item in a sequence (list or array). |
| `[ ]`     | Square Brackets | Enclose sequences or arrays. |
| `\|`      | Pipe | Indicates a literal block style for multi-line strings, preserving newlines. |
| `>`       | Greater Than Sign | Indicates a folded block style for multi-line strings, converting newlines to spaces. |
| `!`       | Exclamation Mark | Specifies custom data types (tags). |
| `\`       | Backslash | Used for escape sequences in double-quoted strings, like `\n` for a newline or `\"` for a double quote. |
| `?`       | Question Mark | Used in complex keys, often to indicate the beginning of a mapping key in some contexts. |
| `{ }`     | Curly Braces | Indicate inline mappings (objects). |
| `&`       | Ampersand | Creates an anchor, marking a position for reuse. |
| `*`       | Asterisk | References an anchor (alias). |

In addition to these, other characters can also be considered special depending on their context or location within a string. These include: `<`, `>`, `=`, `%`, `@`, `/`, `` ` ``

## Handling Special Characters in YAML

When these characters are part of a string value, especially at the beginning of a string, or within key names, they can be misinterpreted by the YAML parser, causing syntax errors. To avoid this, it's crucial to handle these characters correctly.

### Use Quotes

The most common way to handle special characters is to enclose the string containing them in quotes.

- **Double Quotes (`"`):** Allow the use of escape sequences like `\n` for a newline, `\\` for a backslash, and `\"` to include a double quote within the string.
- **Single Quotes (`'`):** Treat all characters literally, meaning escape sequences are not interpreted, according to Educative. To include a single quote within a single-quoted string, you use two consecutive single quotes (`''`).

**For example:**

```yaml
message: "This string contains a colon: and a quote\"."
another_message: 'This string contains a single quote: ''Hello''.'
```

### Validate YAML Files

- Validate your YAML files with a linter or parser to catch potential errors before deployment.
- Use a modern editor that reports errors in YAML files

<!-- FooterStart -->
---
[← 00_02 What You Should Know](../00_02_what_you_should_know/README.md) | [00_04 Your First Action →](../00_04_your_first_action/README.md)
<!-- FooterEnd -->
