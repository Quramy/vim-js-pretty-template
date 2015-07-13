# vim-js-pretty-template

A Vim plgin to apply other filetype's syntax to JavaScript [Template Strings](http://tc39wiki.calculist.org/es6/template-strings/).

This plugin highlights ES6 Template Strings syntax with other filetype's syntax rule which you want.

```js
var template = `
  <html>
    <body id="main"></body>
  </html>
`;
```

Template Strings is available with [Babel](https://babeljs.io/), [google/traceur-compile](https://github.com/google/traceur-compiler) and [TypeScript](http://www.typescriptlang.org/).

## Install 

### Vundle

Place this in your `.vimrc`:

```vim
Plugin 'Quramy/tsuquyomi'
```

then run the following in Vim:

```vim
:source %
:PluginInstall
```

### NeoBundle

```vim
NeoBundle 'Quramy/vim-js-pretty-template'
```

then run the following in Vim:

```vim
:source %
:NeoBundleInstall
```

### Pathogen
Run the following in a terminal:

```sh
cd ~/.vim/bundle
git clone https://github.com/Quramy/tsuquyomi
```

## Usage

This plugin provides the `:JsPre` command.

```vim
:JsPre html
```

This command requires an argument. It's a filetype name which you can apply into templates in your JavaScripts code.

For example, if you apply 

```vim
autocmd filetype javascript JsPre html
```

## License
This software is released under the MIT License, see LICENSE.txt.

