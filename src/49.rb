# 文中のすべての名詞句のペアを結ぶ最短係り受けパスを抽出せよ．
# ただし，名詞句ペアの文節番号がiとj（i<j）のとき，係り受けパスは以下の仕様を満たすものとする．
#
# - 問題48と同様に，パスは開始文節から終了文節に至るまでの各文節の表現（表層形の形態素列）を"`->`"で連結して表現する
# - 文節iとjに含まれる名詞句はそれぞれ，XとYに置換する
#
# また，係り受けパスの形状は，以下の2通りが考えられる．
#
# - 文節iから構文木の根に至る経路上に文節jが存在する場合: 文節iから文節jのパスを表示
# - 上記以外で，文節iと文節jから構文木の根に至る経路上で共通の文節kで交わる場合: 文節iから文節kに至る直前のパスと文節jから文節kに至る直前までのパス，文節kの内容を"`|`"で連結して表示
#
# 例えば，「吾輩はここで始めて人間というものを見た。」という文（neko.txt.cabochaの8文目）から，次のような出力が得られるはずである．
#
# ```
# Xは | Yで -> 始めて -> 人間という -> ものを | 見た
# Xは | Yという -> ものを | 見た
# Xは | Yを | 見た
# Xで -> 始めて -> Y
# Xで -> 始めて -> 人間という -> Y
# Xという -> Y
# ```

require_relative '41'

class Chunk
  def original_with_meishiku_replacement(replacement, symbol: false)
    ms = symbol ? morphs : morphs_without_symbol
    ms.map { |morph| morph.pos == '名詞' ? replacement : morph.surface }.join.sub(/(#{replacement})+/, replacement)
  end
end

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chained_chunk_combinations = chunks
                                 .select { |chunk| chunk.any_morphs?(pos: '名詞') }
                                 .map { |chunk| chunk.chained_chunks(chunks) }
                                 .combination(2)
  chained_chunk_combinations.each do |chained_chunks1, chained_chunks2|
    if (j = chained_chunks1.index(chained_chunks2.first))
      path = chained_chunks1[0...j].map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('X') : chunk.original
      end.push('Y').join(' -> ')
      arr << path
    else
      common_chunks = chained_chunks1 & chained_chunks2
      x_path        = (chained_chunks1 - common_chunks).map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('X') : chunk.original
      end.join(' -> ')
      y_path        = (chained_chunks2 - common_chunks).map.with_index do |chunk, i|
        i.zero? ? chunk.original_with_meishiku_replacement('Y') : chunk.original
      end.join(' -> ')
      common_path   = common_chunks.map(&:original).join(' -> ')
      arr << [x_path, y_path, common_path].join(' | ')
    end
  end
end

puts res.first(10)
File.open(File.expand_path('../output/49.txt', __dir__), 'w') { |f| f.puts res }
