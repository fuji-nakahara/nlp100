# 特定の（指定した）別名を持つアーティストを検索せよ．

require 'mongo'

alias_name = ARGV[0] || '女王'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection.find('aliases.name': alias_name).to_a

pp res
