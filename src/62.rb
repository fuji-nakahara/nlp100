# 60で構築したデータベースを用い，活動場所が「Japan」となっているアーティスト数を求めよ．

require 'redis'

redis = Redis.new(db: 0)

res = redis.keys.count { |key| redis.sismember(key, 'Japan') }
puts res
