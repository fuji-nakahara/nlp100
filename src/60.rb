# Key-Value-Store (KVS) を用い，アーティスト名（name）から活動場所（area）を検索するためのデータベースを構築せよ．

require 'json'
require 'zlib'
require 'redis'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

redis = Redis.new(db: 0)

redis.flushdb

Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    artist = JSON.parse(line)
    redis.sadd(artist['name'], artist['area']) if artist['area']
  end
end

puts redis.dbsize
