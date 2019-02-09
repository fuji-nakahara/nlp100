# 40に加えて，文節を表すクラス `Chunk` を実装せよ．
# このクラスは形態素（`Morph` オブジェクト）のリスト（`morphs`），係り先文節インデックス番号（`dst`），係り元文節インデックス番号のリスト（`srcs`）をメンバ変数に持つこととする．
# さらに，入力テキストのCaboChaの解析結果を読み込み，１文を `Chunk` オブジェクトのリストとして表現し，8文目の文節の文字列と係り先を表示せよ．
# 第5章の残りの問題では，ここで作ったプログラムを活用せよ．

require_relative '40'

class Chunk
  attr_accessor :morphs
  attr_reader :dst, :srcs

  def initialize(dst: -1, srcs: [], morphs: [])
    @dst    = dst
    @srcs   = srcs
    @morphs = morphs
  end

  def original
    morphs.map(&:surface).join
  end
end

file_path = File.expand_path('../data/neko.txt.cabocha', __dir__)

res = []
File.open(file_path) do |file|
  chunks = []
  morphs = []
  file.each_line(chomp: true) do |line|
    if line == 'EOS'
      chunks.last.morphs = morphs unless chunks.empty?

      res << chunks
      chunks = []
    elsif line.start_with?('*')
      chunks.last.morphs = morphs unless chunks.empty?

      md   = line.match(/\A\* (?<idx>\d+) (?<dst>-?\d+)D/)
      srcs = chunks.map.with_index { |chunk, i| chunk.dst == md[:idx].to_i ? i : nil }.compact
      chunks << Chunk.new(dst: md[:dst].to_i, srcs: srcs)
      morphs = []
    else
      arr = line.split(/[\t,]/)
      morphs << Morph.new(surface: arr[0], base: arr[7], pos: arr[1], pos1: arr[2])
    end
  end
end

puts(res[7].map.with_index { |chunk, i| "#{chunk.original}\t#{i} #{chunk.dst}D" }) if $PROGRAM_NAME == __FILE__

NEKO_CHUNKS_LIST = res
