fpm cookery recipe with for packaging Ark mods for install on an ubuntu server

Requirement:
This has only been tested on windows 10 using the Ubuntu subsystem

Requires ruby

Setup:
run 'bundle install' to add the required gems

Configuration:
All configs go in the config.yaml file.  Currently there are only a few settings.

source_dir: path to the Mods directory for Ark on your windows system
target_dir: path to the Mods directory on the server where you want to install the mods
mods: nested hash with a human friendly name for the mod as the key and a child key of 'id' with the mod id as the value

Usage:

Environment variables:
MODNAME: set this to match the name of the mod as specified in the mods key in config.yaml
VERSION: version you want the package set to
REV: package revision
SOURCEDIR: this overrides the source_dir setting in config.yaml
TARGETDIR:  this overrides the target_dir setting in config.yaml

Example: MODNAME=structures_plus VERSION=20170330 REV=2 fpm cook

will generate the package in the pkg directory

packages won't currently have any post install scripts and don't manage permissions so you'll need to chown/chmod the mods directory as necessary
