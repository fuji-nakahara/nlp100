# 名詞の連接（連続して出現する名詞）を最長一致で抽出せよ．

require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object([]) do |morphs, arr|
  nouns = []
  morphs.each do |morph|
    if morph[:pos] == '名詞'
      nouns << morph[:surface]
    else
      arr << nouns.join if nouns.size > 1
      nouns = []
    end
  end
end

p res.first(20)
File.open(File.expand_path('../output/35.txt', __dir__), 'w') { |f| f.puts res }
