# Creating Plugins

## Creating the plugin

TODO

## Plugin description

In your `plugin.json` file, you can define various aspects,
such as version, dependencies or contact data for your plugin:
```json
{
	"name": "your-plugin",
	"display_name": "Your Plugin",
	"group": "net.yourname",
	"version": "1.0.0-PRE.1-SNAPSHOT",
	"authors": [
		{
			"name": "Your Name",
			"email": "contact@example.com",
			"website": "https://github.com/Lua"
		}
	],
	"contact": {
		"email": "contact@example.com",
		"website": "https://your-site.com/"
	},
	"repository": {
		"type": "git",
		"source": "https://github.com/YourName/YourProject"
	},
	"dependencies": [
		"com.facepunch:ai-lib",
		"jet:blue-penguin:2.^3.0"
	],
	"soft_dependencies": [
		"jet:red-penguin:^4.3.^!2"
	]
}
```

## Lua

TODO

## Folder Structure

The folder of your plugin should then look something like this:
```
└ lua/
  └ plugins/
    └ your-plugin/
      ├ cl_init.lua
      ├ plugin.json
      ├ sh_init.lua
      ├ sv_init.lua
      ├ entities/
      │ ├ entity1.lua
      │ ├ entity2/
      │ │ ├ cl_init.lua
      │ │ └ sv_init.lua
      │ └ ...
      └ weapons/
        ├ weapon1.lua
        ├ weapon2/
        │ ├ cl_init.lua
        │ └ sv_init.lua
        └ ...
```
