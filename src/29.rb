# テンプレートの内容を利用し，国旗画像のURLを取得せよ．
# （ヒント: MediaWiki APIのimageinfoを呼び出して，ファイル参照をURLに変換すればよい）

require 'json'
require 'open-uri'
require 'uri'

require_relative '20'

flag_file_name = BRITISH_ARTICLE_BODY[/国旗画像\s*=\s*(.*)/, 1]

uri       = URI.parse('https://ja.wikipedia.org/w/api.php')
uri.query = URI.encode_www_form(
  action: 'query',
  titles: "File:#{flag_file_name}",
  prop:   'imageinfo',
  iiprop: 'url',
  format: 'json'
)

res = JSON.parse(uri.open.read)['query']['pages']['-1']['imageinfo'][0]['url']
puts res
