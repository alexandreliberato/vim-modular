# Design 
## Architecture
    node                 loading order
/
	init.vim             -- 1. 
	infra.vim            -- 2.
	style-plugins.vim    -- 3.
	ux-plugins.vim       -- 4.
	modules/*            -- 5.
	---
	lua/*                -- 6.
	style.vim            -- 7.
	ux.vim               -- 8.
	---
	languages.vim        -- 9.
	coc-settings.json    -- 10.
	---
	colors/              ?


## Layers
	- Infra: /infra.vim - main plugins used by other layers 
	- Modules: /modules/<lang> - plugins used by language modules
	- Extensions: /lua/<lang> + /lua/extensions/<component>


## Loading order

	plugins [infra, modules, ux, style] -> sleep(200ms) -> extensions [modules, ux, style]
