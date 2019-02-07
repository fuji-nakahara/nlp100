# 出現頻度が高い10語とその出現頻度をグラフ（例えば棒グラフなど）で表示せよ．

require 'gnuplotrb'

require_relative '30'

output_path = File.expand_path('../output/37.svg', __dir__)

res = NEKO_MORPHS_LIST.each_with_object(Hash.new(0)) do |morphs, hash|
  morphs.each do |morph|
    hash[morph[:base]] += 1
  end
end
res = res.sort_by { |_, count| -count }.first(10).transpose

ds   = GnuplotRB::Dataset.new(res, with: 'histograms', using: '2:xtic(1)', notitle: true)
plot = GnuplotRB::Plot.new(ds, yrange: '[0:]')
plot.to_svg(output_path)
puts 'See output/37.svg'
