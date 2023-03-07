require 'hotpot'.setup {
	compiler = {
		modules = {
			correlate = true,
		},
		macros = {
			env = '_COMPILER',
		},
	},
}
require 'ks'
