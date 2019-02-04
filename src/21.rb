# 記事中でカテゴリ名を宣言している行を抽出せよ．

require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/^.*\[\[Category:.+\]\].*$/)
puts res
