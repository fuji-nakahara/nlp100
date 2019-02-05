# 記事中に含まれるセクション名とそのレベル（例えば"== セクション名 =="なら1）を表示せよ．

require_relative '20'

res = BRITISH_ARTICLE_BODY.scan(/(={2,}) ?(.+?) ?\1/).each_with_object([]) do |(mark, name), arr|
  arr << { name: name, level: mark.size - 1 }
end
puts res
