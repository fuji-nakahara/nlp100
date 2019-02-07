# 単語の出現頻度のヒストグラム（横軸に出現頻度，縦軸に出現頻度をとる単語の種類数を棒グラフで表したもの）を描け．

require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/38.svg', __dir__)

word_to_count = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end

res = Array.new(word_to_count.values.max + 1) { 0 }
word_to_count.each do |_, count|
  res[count] += 1
end

ds   = GnuplotRB::Dataset.new(res, with: 'histograms', notitle: true)
plot = GnuplotRB::Plot.new(ds)
plot.to_svg(output_path)
puts 'See output/38.svg'
