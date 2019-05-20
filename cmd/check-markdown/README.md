* [Overview](#overview)
* [Tool summary](#tool-summary)
* [Usage](#usage)
    * [Basic](#basic)
    * [Generate a TOC](#generate-a-toc)
    * [Full details](#full-details)

# Overview

The Kata Project comprises
[a number of GitHub repositories](https://github.com/kata-containers).
All these repositories contain documents written in
[GitHub-Flavoured Markdown](https://github.github.com/gfm)
format.

[Linking in documents is strongly encouraged](https://github.com/kata-containers/documentation/blob/master/Documentation-Requirements.md)
but due to the number of internal and external document links, it is easy for
mistakes to be made. Also, links can become stale when one document is updated
but the documents it depends on are not.

# Tool summary

The `kata-check-markdown` tool checks a markdown document to ensure all links
within it are valid. All internal links are checked and by default all
external links are also checked. The tool is able to suggest corrections for
some errors it finds. It can also generate a TOC (table of contents).

# Usage

## Basic

```sh
$ kata-check-markdown README.md
```

## Generate a TOC

```sh
$ kata-check-markdown --create-toc README.md
```

## Full details

Lists all available options:

```sh
$ kata-check-markdown -h
```