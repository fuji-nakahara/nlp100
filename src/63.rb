# KVSを用い，アーティスト名（name）からタグと被タグ数（タグ付けされた回数）のリストを検索するためのデータベースを構築せよ．
# さらに，ここで構築したデータベースを用い，アーティスト名からタグと被タグ数を検索せよ．

require 'json'
require 'zlib'
require 'redis'

artist_name = ARGV[0] || 'Cornelius'

file_path = File.expand_path('../data/artist.json.gz', __dir__)

redis = Redis.new(db: 1)

unless redis.dbsize.positive?
  Zlib::GzipReader.open(file_path) do |gz|
    gz.each do |line|
      artist       = JSON.parse(line)
      name         = artist['name']
      tag_to_count = artist.fetch('tags', []).map { |tag| [tag['value'], tag['count']] }.to_h

      if redis.exists(name)
        existing_tag_to_count = redis.hgetall(name)
        tag_to_count.merge!(existing_tag_to_count) { |_, val, existing_val| val.to_i + existing_val.to_i }
      end

      redis.mapped_hmset(name, tag_to_count) unless tag_to_count.empty?
    end
  end
end

res = redis.hgetall(artist_name).sort_by { |_, val| -val.to_i }.to_h
puts res
