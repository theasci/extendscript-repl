# Overview

Read-Eval-Print-Loop (REPL) for ExtendScript via Apple Javascript for Automation.

# Requirements

1. macOS supporting [JavaScript for Automation](https://github.com/JXA-Cookbook/JXA-Cookbook/wiki)
1. Valid license for [Adobe products that use ExtendScript](https://www.adobe.com/devnet/scripting.html). Currently supports Photoshop and InDesign.
1. [Ruby](https://www.ruby-lang.org/en/)
1. [Handy ExtendScript reference](http://jongware.mit.edu/idcs6js)

# Installation

Clone and use directly:

```sh
git clone https://github.com/theasci/extendscript-repl
cd extendscript-repl
./run.rb -h
```

Or, add as development dependency in your `package.json` file.
```json
"devDependencies": {
  "extendscript-repl": "^0.0.1"
}
```

Install with `npm install`. You should now be able to create a script (`repl.sh`) that loads your bootstrap JSX, if desired.

```sh
#!/bin/bash
DIRECTORY=$(cd `dirname $0` && pwd)
"$DIRECTORY/node_modules/extendscript-repl/run.rb" -b "$DIRECTORY/bootstrap.jsx"
```

# run.rb

```sh
me@host$ ./run.rb -a photoshop
ExtendScript REPL - photoshop
Type 'help' to get started.
jsx> app.name
Adobe Photoshop
jsx> app.version
21.0.3
jsx> exit

me@host$ ./run.rb -a indesign
ExtendScript REPL - indesign
Type 'help' to get started.
jsx> app.properties.name
Adobe InDesign
jsx> app.properties.version
15.0.1.209
jsx> app.activeDocument.stories[0].texts.firstItem()
Application("Adobe InDesign 2020").documents.byId(510).stories.byId(216)
jsx> app.activeDocument.stories[0].texts.firstItem().toSpecifier()
/document[@id=510]/story[0]/text[@location=first]
jsx> quit

me@host$ ./run.rb -b lib/bootstrap.jsx
jsx> Global.toSource()
({rootPath:new Folder ("~/projects/extendscript-repl")})
jsx> Global.rootPath
Path("/Users/me/projects/extendscript-repl")
```

# Gotchas
1. Backslashes (\\) need to be escaped. `jsx> 'test'.match(/\\w/)`

# NPM Release Tasks

1. Update `package.json` version number
1. `npm install` to update package lock.
1. Ensure tests pass: `npm test`
1. Update `CHANGELOG.md` with changes since last release.
1. Check them all into the repository.
1. `git tag -a <version> -m <version>; git push --tags`
1. `npm publish` to deploy the release to npm.

# TODO

1. ExtendScript session to handle variables introduced. Not sure how this would be done.
1. History writes to a file so they exist beyond a single Session
1. Handle multiline commands
