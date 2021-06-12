# gfmfmt action

Format your markdown into a standard format, and check PRs have markdown
formatted in a standard way using pandoc

## Inputs

### `fix`

**Optional** Fix the markdown. Default `"false"`.

### `path`

**Required** Path to the markdown, which may include globbing.

## Example usage

``` yaml
uses: PurpleBooth/gfmfmt-action@v0.1.13
with:
  path: "*.md"
  fix: "false"
```

## Annotations

The annotations look like this

<img width="1211" alt="grafik" src="https://user-images.githubusercontent.com/133327/121780729-f2e1f580-cba1-11eb-971e-b6c64661af3f.png">
