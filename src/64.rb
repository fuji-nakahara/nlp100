# アーティスト情報（artist.json.gz）をデータベースに登録せよ．
# さらに，次のフィールドでインデックスを作成せよ: name, aliases.name, tags.value, rating.value

require 'json'
require 'zlib'
require 'mongo'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

Mongo::Logger.logger.level = Logger::INFO

client     = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection = client[:artist]

client.database.drop

collection.indexes.create_many(
  [
    { key: { name: 1 } },
    { key: { 'aliases.name': 1 } },
    { key: { 'tags.value': -1 } },
    { key: { 'rating.value': -1 } }
  ]
)

docs = []
Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    docs << JSON.parse(line)
  end
end

res = collection.insert_many(docs)

puts 'Inserted count:', res.inserted_count
puts 'Indexes:'
collection.indexes.each(&method(:puts))
