# 記事中に含まれる「基礎情報」テンプレートのフィールド名と値を抽出し，辞書オブジェクトとして格納せよ．

require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  hash[key] = val
end
pp res
