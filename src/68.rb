# "dance"というタグを付与されたアーティストの中でレーティングの投票数が多いアーティスト・トップ10を求めよ．

require 'mongo'

tag = 'dance'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection
        .find('tags.value': tag)
        .sort('rating.count': -1)
        .projection(name: 1, area: 1, rating: 1)
        .limit(10)
        .to_a

pp res
