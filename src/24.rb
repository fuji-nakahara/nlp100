# 記事から参照されているメディアファイルをすべて抜き出せ．

require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/(?:ファイル|File):(.+?)(?:\||\]\]|$)/i)
puts res
