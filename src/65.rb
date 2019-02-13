# MongoDBのインタラクティブシェルを用いて，"Queen"というアーティストに関する情報を取得せよ．
# さらに，これと同様の処理を行うプログラムを実装せよ．

system %(mongo nlp100 --quiet --eval "db.artist.find({ name: 'Queen' })")
puts

require 'mongo'

artist_name = 'Queen'

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

res = collection.find(name: artist_name).to_a

pp res
