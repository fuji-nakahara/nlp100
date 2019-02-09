# 動詞のヲ格にサ変接続名詞が入っている場合のみに着目したい．46のプログラムを以下の仕様を満たすように改変せよ．
#
# - 「サ変接続名詞+を（助詞）」で構成される文節が動詞に係る場合のみを対象とする
# - 述語は「サ変接続名詞+を+動詞の基本形」とし，文節中に複数の動詞があるときは，最左の動詞を用いる
# - 述語に係る助詞（文節）が複数あるときは，すべての助詞をスペース区切りで辞書順に並べる
# - 述語に係る文節が複数ある場合は，すべての項をスペース区切りで並べる（助詞の並び順と揃えよ）
#
# 例えば「別段くるにも及ばんさと、主人は手紙に返事をする。」という文から，以下の出力が得られるはずである．
#
# ```
# 返事をする      と に は        及ばんさと 手紙に 主人は
# ```
#
# このプログラムの出力をファイルに保存し，以下の事項をUNIXコマンドを用いて確認せよ．
#
# - コーパス中で頻出する述語（サ変接続名詞+を+動詞）
# - コーパス中で頻出する述語と助詞パターン

require_relative '41'

class Chunk
  def last_joshi
    morph = find_last_morph(pos: '助詞', pos1: '格助詞') || find_last_morph(pos: '助詞')
    morph&.base
  end

  def sahen_setsuzoku_meishi_with_wo
    find_continuous_morphs({ pos: '名詞', pos1: 'サ変接続' }, { base: 'を', pos: '助詞' })&.map(&:base)&.join
  end

  private

  def find_continuous_morphs(*conditions)
    morphs.each_cons(conditions.size).find do |ms|
      ms.zip(conditions).all? do |morph, condition|
        condition.all? { |key, val| morph[key] == val }
      end
    end
  end
end

output_path = File.expand_path('../output/47.txt', __dir__)

res = NEKO_CHUNKS_LIST.each_with_object([]) do |chunks, arr|
  chunks.each do |chunk|
    next if chunk.srcs.empty?

    verb = chunk.find_morph(pos: '動詞')
    next if verb.nil?

    src_chunks   = chunk.srcs.map { |src| chunks[src] }
    target_chunk = src_chunks.find(&:sahen_setsuzoku_meishi_with_wo)
    next if target_chunk.nil?

    src_chunks.delete(target_chunk)
    joshis, kous = src_chunks
                     .map { |c| [c.last_joshi, c.original] }
                     .reject { |joshi, _| joshi.nil? }
                     .sort_by { |joshi, _| joshi }
                     .transpose

    arr << ["#{target_chunk.sahen_setsuzoku_meishi_with_wo}#{verb.base}", joshis&.join(' '), kous&.join(' ')].compact.join("\t")
  end
end

File.open(output_path, 'w') { |f| f.puts res }

puts 'コーパス中で頻出する述語:'
system "cut -f 1 #{output_path} | sort | uniq -c | sort -r | head"

puts "\nコーパス中で頻出する述語と助詞パターン:"
system "cut -f 1,2 #{output_path} | sort | uniq -c | sort -r | head"
