# campusmedia-fillins
Campus Media Reference Configuration

To inspect the validity of your YAML before publishing, use an online tool such as [YAML Validator](https://codebeautify.org/yaml-validator) or [YAML Lint](http://www.yamllint.com/)

**Key-value pairs**
```yaml
key: value 1
key2: value 2 # Values can be safetly written without quotation marks
"key 3": value 3 # But do use quotation marks with spaces in the key
"12345": value 4 # or with numbers as keys
```

**Multi-line values:** (use when Markdown especially)
```yaml
body: |
  I can write arbitrary text here:
  Including [formatted markdown](https://guides.github.com/features/mastering-markdown/)!
  I can even write multiple lines.
  # With headers!
  * But I always make sure each subsequent line is indented!
  * YAML understands when my text ends when it sees an unindented line.
key:
  key2:
    body: |
      If my multi-line text is deeply nested, I make sure to continue indenting two more lines than the preceding key.
      So I can continue writing here!
    published: true
```
*but...*
```yaml
confused_yaml: # When we write markdown here (sees as comment)
```

**Lists:**
```yaml
key:
  - value 1
  - value 2
```
