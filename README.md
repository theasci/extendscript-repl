# Overview

Read-Eval-Print-Loop (REPL) for ExtendScript via Apple Javascript for Automation.

# Requirements

1. macOS supporting [JavaScript for Automation](https://github.com/JXA-Cookbook/JXA-Cookbook/wiki)
1. Valid license for [Adobe products that use ExtendScript](https://www.adobe.com/devnet/scripting.html)
1. [Ruby](https://www.ruby-lang.org/en/)
1. [Handy ExtendScript reference](http://jongware.mit.edu/idcs6js)

# Installation

```sh
git clone https://github.com/theasci/extendscript-repl
cd extendscript-repl
bundle install
```

# run.rb

```sh
me@host$ ./run.rb
ExtendScript REPL
Application set to 'indesign'.
Type 'help' to get started.
jsx> app.toSource()
resolve("/")
jsx> app.properties.name
Adobe InDesign
jsx> app.properties.filePath
Path("/Applications/Adobe InDesign 2020")
jsx> exit
me@host$
```
# TODO

1. Bootstrap file
1. Session to handle variables already assigned
