# サ変接続の名詞をすべて抽出せよ．

require_relative '30'

res = NEKO_MORPHS_LIST.map do |morphs|
  morphs
    .select { |morph| morph[:pos1] == 'サ変接続' && morph[:pos] == '名詞' }
    .map { |morph| morph[:base] }
end.flatten

p res.first(20)
File.open(File.expand_path('../output/33.txt', __dir__), 'w') { |f| f.puts res }
