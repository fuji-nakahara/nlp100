# 形態素を表すクラス `Morph` を実装せよ．
# このクラスは表層形（`surface`），基本形（`base`），品詞（`pos`），品詞細分類1（`pos1`）をメンバ変数に持つこととする．
# さらに，CaboChaの解析結果（neko.txt.cabocha）を読み込み，各文を `Morph` オブジェクトのリストとして表現し，3文目の形態素列を表示せよ．

Morph = Struct.new(:surface, :base, :pos, :pos1, keyword_init: true)

return if $PROGRAM_NAME != __FILE__

file_path = File.expand_path('../data/neko.txt.cabocha', __dir__)

res = []
File.open(file_path) do |file|
  morphs = []
  file.each_line(chomp: true) do |line|
    next if line.start_with?('*')

    if line == 'EOS'
      res << morphs
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << Morph.new(surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2])
    end
  end
end

pp res[2]
