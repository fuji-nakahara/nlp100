# 文中のすべての名詞を含む文節に対し，その文節から構文木の根に至るパスを抽出せよ．
# ただし，構文木上のパスは以下の仕様を満たすものとする．
#
# - 各文節は（表層形の）形態素列で表現する
# - パスの開始文節から終了文節に至るまで，各文節の表現を"`->`"で連結する
#
# 「吾輩はここで始めて人間というものを見た」という文（neko.txt.cabochaの8文目）から，次のような出力が得られるはずである．
#
# ```
# 吾輩は -> 見た
# ここで -> 始めて -> 人間という -> ものを -> 見た
# 人間という -> ものを -> 見た
# ものを -> 見た
# ```

require_relative '41'

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.select { |chunk| chunk.any_morphs?(pos: '名詞') }.each do |chunk|
    chained_chunks = chunk.chained_chunks(chunks)
    arr << chained_chunks.map(&:original).join(' -> ')
  end
end

puts res.first(10)
File.open(File.expand_path('../output/48.txt', __dir__), 'w') { |f| f.puts res }
