# 形態素解析結果（neko.txt.mecab）を読み込むプログラムを実装せよ．
# ただし，各形態素は表層形（surface），基本形（base），品詞（pos），品詞細分類1（pos1）をキーとするマッピング型に格納し，1文を形態素（マッピング型）のリストとして表現せよ．
# 第4章の残りの問題では，ここで作ったプログラムを活用せよ．

file_path = File.expand_path('../data/neko.txt.mecab', __dir__)

res = []
File.open(file_path) do |file|
  morphs = []
  file.each_line(chomp: true) do |line|
    if line == 'EOS'
      res << morphs
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << { surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2] }
    end
  end
end

pp res.first(5) if $PROGRAM_NAME == __FILE__

NEKO_MORPHS_LIST = res
