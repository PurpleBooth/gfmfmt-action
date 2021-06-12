# gfmfmt action

Uses pandoc to lint and optionally format markdown to a standard format

## Inputs

### `fix`

**Optional** Fix the markdown. Default `"false"`.

## Outputs

### `changed`

`"true"` if the markdown has changed

## Example usage

``` yaml
uses: PurpleBooth/gfmfmt-action@v0.1.2
with:
  fix: "true"
```
