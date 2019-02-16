# 極性分析に有用そうな素性を各自で設計し，学習データから素性を抽出せよ．
# 素性としては，レビューからストップワードを除去し，各単語をステミング処理したものが最低限のベースラインとなるであろう．

require 'fast-stemmer'

require_relative '71'

sentiment_path = File.expand_path('../output/sentiment.txt', __dir__)
features_path  = File.expand_path('../output/features.txt', __dir__)

word_to_count = Hash.new(0)
File.open(sentiment_path) do |file|
  file.each do |line|
    _, *words = line.scrub.split
    words.reject(&method(:stopword?)).map(&:stem).uniq.each do |word|
      word_to_count[word] += 1
    end
  end
end
features = word_to_count.reject { |_, count| count < 5 }.keys

puts features.size
File.open(features_path, 'w') { |f| f.puts features }
