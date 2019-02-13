# MongoDBのインタラクティブシェルを用いて，活動場所が「Japan」となっているアーティスト数を求めよ．

system %(mongo nlp100 --quiet --eval "db.artist.distinct('name', { area: 'Japan' }).length")
