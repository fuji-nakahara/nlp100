# 文章中に出現する単語とその出現頻度を求め，出現頻度の高い順に並べよ．

require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end
res = res.sort_by { |_, count| -count }

puts res.first(10).to_h
File.open(File.expand_path('../output/36.txt', __dir__), 'w') { |f| f.puts(res.map { |e| e.join("\t") }) }
