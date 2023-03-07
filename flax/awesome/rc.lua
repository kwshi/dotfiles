local fennel = require 'fennel'
fennel.path = fennel.path .. ';.config/awesome/?.fnl;.config/awesome/?/init.fnl'
table.insert(package.searchers, fennel.searcher)
require 'ks'
