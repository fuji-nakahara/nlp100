# 27の処理に加えて，テンプレートの値からMediaWikiマークアップを可能な限り除去し，国の基本情報を整形せよ．

require_relative '20'

basic_info = BRITISH_ARTICLE_BODY[/{{\s*基礎情報 国\s*((\|\s*.+?\s*=\s*.+?)*)}}/m, 1]
res        = basic_info.scan(/^\|\s*(.+?)\s*=\s*(.+?)(?=(?:\n\||\n\z))/m).each_with_object({}) do |(key, val), hash|
  val = val.gsub(/('{2,5})(.+?)\1/, '\2')
  val = val.gsub(/\[\[(?:ファイル|File):(.+?)(?:\|.+?)*\]\]/i, '\1')
  val = val.gsub(/\[\[.+?\]\]/i) do |link|
    md = link.match(/\[\[(.+?)(?:\|(.+?))?\]\]/)
    md[2].nil? ? md[1] : md[2]
  end
  val = val.gsub(/{{lang\|\w+?\|(.*?)}}/, '\1')
  val = val.gsub(%r{(<ref.*?>.*?</ref>|<ref.*?/>)}m, '')
  val = val.gsub(%r{<br ?/>}, "\n")

  hash[key] = val
end
pp res
