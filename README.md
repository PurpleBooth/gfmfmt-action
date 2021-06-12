# gfmfmt action

Uses pandoc to lint and optionally format markdown to a standard format

* Item 1
* Item 2
* Item 3
* Item 4

## Inputs

### `fix`

**Optional** Fix the markdown. Default `"false"`.

### `path`

**Required** Path to the markdown, which may include globbing.

## Example usage

``` yaml
uses: PurpleBooth/gfmfmt-action@v0.1.12
with:
  path: "*.md"
  fix: "false"
```
