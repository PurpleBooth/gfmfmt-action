# gfmfmt action

Uses pandoc to lint and optionally format markdown to a standard format

## Inputs

### `fix`

**Optional** Fix the markdown. Default `"false"`.

### `path`

**Required** Path to the markdown, which may include globbing.

## Example usage

``` yaml
uses: PurpleBooth/gfmfmt-action@v0.1.11
with:
  path: "*.md"
  fix: "false"
```
