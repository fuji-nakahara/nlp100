# 45のプログラムを改変し，述語と格パターンに続けて項（述語に係っている文節そのもの）をタブ区切り形式で出力せよ．
# 45の仕様に加えて，以下の仕様を満たすようにせよ．
#
# - 項は述語に係っている文節の単語列とする（末尾の助詞を取り除く必要はない）
# - 述語に係る文節が複数あるときは，助詞と同一の基準・順序でスペース区切りで並べる
#
# 「吾輩はここで始めて人間というものを見た」という例文（neko.txt.cabochaの8文目）を考える．
# この文は「始める」と「見る」の２つの動詞を含み，「始める」に係る文節は「ここで」，「見る」に係る文節は「吾輩は」と「ものを」と解析された場合は，次のような出力になるはずである．
#
# ```
# 始める  で      ここで
# 見る    は を   吾輩は ものを
# ```

require_relative '41'

class Chunk
  def last_joshi
    morph = find_last_morph(pos: '助詞', pos1: '格助詞') || find_last_morph(pos: '助詞')
    morph&.base
  end
end

output_path = File.expand_path('../output/46.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    joshis, kous = chunk.srcs
                     .map { |src| chunks[src] }
                     .map { |c| [c.last_joshi, c.original] }
                     .reject { |joshi, _| joshi.nil? }
                     .transpose
    next if joshis.nil?

    arr << [verb.base, joshis.join(' '), kous.join(' ')].join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts res.first(10)
