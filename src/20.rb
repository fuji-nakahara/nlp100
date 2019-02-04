# Wikipedia記事のJSONファイルを読み込み，「イギリス」に関する記事本文を表示せよ．
# 問題21-29では，ここで抽出した記事本文に対して実行せよ．

require 'json'
require 'zlib'

file_path = File.expand_path('../data/jawiki-country.json.gz', __dir__)

res = ''
Zlib::GzipReader.open(file_path) do |gz|
  gz.each do |line|
    article = JSON.parse(line)
    break res = article['text'] if article['title'] == 'イギリス'
  end
end

puts res.lines.first(5), '...', res.lines.last(5) if $PROGRAM_NAME == __FILE__

BRITISH_ARTICLE_BODY = res
