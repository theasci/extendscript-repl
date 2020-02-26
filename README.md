# Overview

Read-Eval-Print-Loop (REPL) for ExtendScript via Apple Javascript for Automation.

# Requirements

1. macOS supporting [JavaScript for Automation](https://github.com/JXA-Cookbook/JXA-Cookbook/wiki)
1. Valid license for [Adobe products that use ExtendScript](https://www.adobe.com/devnet/scripting.html). Currently supports Photoshop and InDesign.
1. [Ruby](https://www.ruby-lang.org/en/)
1. [Handy ExtendScript reference](http://jongware.mit.edu/idcs6js)

# Installation

```sh
git clone https://github.com/theasci/extendscript-repl
cd extendscript-repl
./run.rb
```

# run.rb

```sh
me@host$ ./run.rb photoshop
ExtendScript REPL - photoshop
Type 'help' to get started.
jsx> app.name
Adobe Photoshop
jsx> app.version
21.0.3
jsx> exit

me@host$ ./run.rb indesign
ExtendScript REPL - indesign
Type 'help' to get started.
jsx> app.properties.name
Adobe InDesign
jsx> app.properties.version
15.0.1.209
```
# TODO

1. Bootstrap file
1. Session to handle variables already assigned
