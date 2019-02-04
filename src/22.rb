# 記事のカテゴリ名を（行単位ではなく名前で）抽出せよ．

require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/\[\[Category:(.+?)(?:\|.*)?\]\]/)
puts res
