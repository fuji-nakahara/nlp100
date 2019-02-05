# 25の処理時に，テンプレートの値からMediaWikiの強調マークアップ（弱い強調，強調，強い強調のすべて）を除去してテキストに変換せよ．

require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  hash[key] = val.gsub(/('{2,5})(.+?)\1/, '\2')
end
pp res
