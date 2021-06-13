# gfmfmt action

Format your markdown into a standard format, and check PRs have markdown
formatted in a standard way using pandoc

## Inputs

### `check`

**Optional** Only check the markdown, don't fix it. Default `"true"`.

### `path`

**Required** Path to the markdown, which may include globbing.

## Example usage

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v0.2.0
      with:
        path: '*.md'
        check: 'true'
```

## Annotations

The annotations look like this

<img width="1211" alt="grafik" src="https://user-images.githubusercontent.com/133327/121780729-f2e1f580-cba1-11eb-971e-b6c64661af3f.png">
