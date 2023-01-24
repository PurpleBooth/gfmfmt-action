# gfmfmt action

Format your markdown into a standard format, and check users have
formatted their markdown formatted uniformly using
[pandoc](https://pandoc.org/)

## A note on Markdown Flavours

While it may appear that Markdown is a single standard, that's not quite
true, there's lots of little extensions to it that make it not exactly
the same across the board. This is intended for use with "[GitHub
Flavoured
Markdown](https://docs.github.com/en/github/writing-on-github)". You can
read more about this on the [pandoc
docs](https://pandoc.org/MANUAL.html#markdown-variants).

The name comes from this fact: gfmfmt, GitHub Flavoured Markdown
Formatter.

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
    - uses: PurpleBooth/gfmfmt-action@v2.0.11
```

### Checking some markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v1.0.3
      with:
        pattern: 'README.md$'
```

### Fixing all markdown files

``` yaml
  lint-markdown:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v2
    - uses: PurpleBooth/gfmfmt-action@v1.0.3
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
    - uses: PurpleBooth/gfmfmt-action@v1.0.3
      with:
        check: 'false'
        pattern: 'README.md$'
    - run: git add . 
    - run: git commit -m "Formatting markdown"
    - run: git push
```

## Annotations

The annotations look like this

<img width="1211" alt="A red annotation with the diff on it" src="https://user-images.githubusercontent.com/133327/121780729-f2e1f580-cba1-11eb-971e-b6c64661af3f.png">

## CLI Tool

See [PurpleBooth/gfmfmt](https://github.com/PurpleBooth/gfmfmt)
