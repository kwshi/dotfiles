local fennel = require('fennel')
fennel.path = fennel.path .. ';.config/awesome/?.fnl'
table.insert(package.searchers, fennel.searcher)
require('main')
