# 動詞の表層形をすべて抽出せよ．

require_relative '30'

res = NEKO_MORPHS_LIST.map do |morphs|
  morphs
    .select { |morph| morph[:pos] == '動詞' }
    .map { |morph| morph[:surface] }
end.flatten

p res.first(20)
File.open(File.expand_path('../output/31.txt', __dir__), 'w') { |f| f.puts res }
