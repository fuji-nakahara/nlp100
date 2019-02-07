# 単語の出現頻度順位を横軸，その出現頻度を縦軸として，両対数グラフをプロットせよ．

require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/39.svg', __dir__)

word_to_count = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end

res = word_to_count.values.sort.reverse

ds   = GnuplotRB::Dataset.new(res, with: 'points', ps: 0.5, pt: 7, notitle: true)
plot = GnuplotRB::Plot.new(ds, logscale: 'xy')
plot.to_svg(output_path)
puts 'See output/39.svg'
