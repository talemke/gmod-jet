# Jet
A plugin & dependency system for Garry's Mod addons.



---

**Currently undergoing maintenance.**

---



## Documentation

All functions/hooks/classes are well documented. You can find the
documentation [here](https://ldoc.tassia.net/TASSIA710/Jet/main/).
Please keep in mind that the documentation software is still a work
in progress and does not work completely, however the basics should
be working.



## Features

- **Command Line Interface**\
  *Interact with the Jet installation through our CLI.\
  Type `jet help` for a list of available commands.*

- **Utilities**\
  *A lot of Lua utilities are being added to reduce boilerplate\
  code for all addons and make developing easier.*

- **Test Suites**\
  *Ensure your plugins are all working as they should\
  by running test suites: `jet test`.*



## Pre-Installed Plugins

- [Jet/CLI](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/cli)\
  *The Jet command line interface.*

- [Jet/Config](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/config)\
  *Provides an interface for getting & setting configuration values, globally and plugin-specific.*

- [Jet/Database](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/database)\
  *Goal of this plugin is to allow for global database connections, instead of each addon using their own.*

- [Jet/Generic](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/generic)\
  *Boilerplate for a bunch of addons. Made to make developing easier.*

- [Jet/Stack](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/stack)\
  *Adds a nice stack with a couple of features.*

- [Jet/StringUtility](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/string_utility)\
  *Adds a bunch of new features for strings.*

- [Jet/Updater](https://github.com/TASSIA710/Jet/tree/main/lua/plugins/updater)\
  *Allows for semi-automatic updating.*



## Console Commands

- `jet benchmark <iterations> <expression>`\
  *Benchmark an expression.*

- `jet help`\
  *Shows this help.*

- `jet license`\
  *Shows the license.*

- `jet map`\
  *Change map.*

- `jet restart`\
  *Soft-Restarts the server.*

- `jet test <plugin/all/*>`\
  *Run test suites.*

- `jet version`\
  *Shows the current version.*

More commands may be added by installing plugins.
