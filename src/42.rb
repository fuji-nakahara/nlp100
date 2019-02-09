# 係り元の文節と係り先の文節のテキストをタブ区切り形式ですべて抽出せよ．
# ただし，句読点などの記号は出力しないようにせよ．

require_relative '41'

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if !chunk.dst? || chunk.original.empty?
    arr << "#{chunk.original}\t#{chunks[chunk.dst].original}"
  end
end

puts res.first(10)
File.open(File.expand_path('../output/42.txt', __dir__), 'w') { |f| f.puts res }
