# 26の処理に加えて，テンプレートの値からMediaWikiの内部リンクマークアップを除去し，テキストに変換せよ

require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  val = val.gsub(/('{2,5})(.+?)\1/, '\2')
  val = val.gsub(/\[\[.+?\]\]/i) do |link|
    md = link.match(/\[\[(.+?)(?:\|(.+?))?\]\]/)
    if md[1].start_with?(/(ファイル|File):/i)
      link
    else
      md[2].nil? ? md[1] : md[2]
    end
  end
  val = val

  hash[key] = val
end
pp res
