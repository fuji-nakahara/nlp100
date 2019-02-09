# 今回用いている文章をコーパスと見なし，日本語の述語が取りうる格を調査したい．
# 動詞を述語，動詞に係っている文節の助詞を格と考え，述語と格をタブ区切り形式で出力せよ．
# ただし，出力は以下の仕様を満たすようにせよ．
#
# - 動詞を含む文節において，最左の動詞の基本形を述語とする
# - 述語に係る助詞を格とする
# - 述語に係る助詞（文節）が複数あるときは，すべての助詞をスペース区切りで辞書順に並べる
#
# 「吾輩はここで始めて人間というものを見た」という例文（neko.txt.cabochaの8文目）を考える．
# この文は「始める」と「見る」の２つの動詞を含み，「始める」に係る文節は「ここで」，「見る」に係る文節は「吾輩は」と「ものを」と解析された場合は，次のような出力になるはずである．
#
# ```
# 始める  で
# 見る    は を
# ```
#
# このプログラムの出力をファイルに保存し，以下の事項をUNIXコマンドを用いて確認せよ．
#
# - コーパス中で頻出する述語と格パターンの組み合わせ
# - 「する」「見る」「与える」という動詞の格パターン（コーパス中で出現頻度の高い順に並べよ）

require_relative '41'

output_path = File.expand_path('../output/45.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    joshis = chunk.srcs.map do |src|
      c = chunks[src]
      c.find_last_morph(pos: '助詞', pos1: '格助詞')&.base || c.find_last_morph(pos: '助詞')&.base
    end.compact
    next if joshis.empty?

    arr << [verb.base, joshis.join(' ')].join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts 'コーパス中で頻出する述語と格パターンの組み合わせ:'
system "sort #{output_path} | uniq -c | sort -r | head"

puts "\n「する」「見る」「与える」という動詞の格パターン:"
%w[する 見る 与える].each do |verb|
  system "grep '^#{verb}' #{output_path} | sort | uniq -c | sort -r | head"
  puts
end
