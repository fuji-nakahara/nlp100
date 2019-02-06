# 2つの名詞が「の」で連結されている名詞句を抽出せよ．

require_relative '30'

res = NEKO_MORPHS_LIST.each_with_object([]) do |morphs, arr|
  morphs.each_cons(3).each do |ms|
    if ms[0][:pos] == '名詞' && ms[1][:surface] == 'の' && ms[2][:pos] == '名詞'
      arr << ms.map { |m| m[:surface] }.join
    end
  end
end

p res.first(20)
File.open(File.expand_path('../output/34.txt', __dir__), 'w') { |f| f.puts res }
