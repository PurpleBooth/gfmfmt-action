# gfmfmt action

Format your markdown into a standard format, and check PRs have markdown
formatted in a standard way using pandoc

## Inputs

### `check`

**Optional** Only check the markdown, don't fix it. Default `"true"`.

### `pattern`

**Optional** Pattern to filter files by. Default `".*\.md$"`.

## Example usage

### Checking all markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v1.0.3
```

### Checking some markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v0.2.1
      with:
        path: 'README.md$'
```

### Fixing all markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v0.2.1
      with:
        check: 'false'
    - run: git add . 
    - run: git commit -m "Formatting markdown"
    - run: git push
```

### Fixing some markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v0.2.1
      with:
        check: 'false'
        path: 'README.md$'
    - run: git add . 
    - run: git commit -m "Formatting markdown"
    - run: git push
```

## Annotations

The annotations look like this

<img width="1211" alt="A red annotation with the diff on it" src="https://user-images.githubusercontent.com/133327/121780729-f2e1f580-cba1-11eb-971e-b6c64661af3f.png">
