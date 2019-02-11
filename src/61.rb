# 60で構築したデータベースを用い，特定の（指定された）アーティストの活動場所を取得せよ．

require 'redis'

artist_name = ARGV[0] || 'Cornelius'

redis = Redis.new(db: 0)

areas = redis.smembers(artist_name)
puts areas.sort
