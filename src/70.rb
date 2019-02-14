# 文に関する極性分析の正解データを用い，以下の要領で正解データ（sentiment.txt）を作成せよ．
#
# 1. rt-polarity.posの各行の先頭に"+1 "という文字列を追加する（極性ラベル"+1"とスペースに続けて肯定的な文の内容が続く）
# 2. rt-polarity.negの各行の先頭に"-1 "という文字列を追加する（極性ラベル"-1"とスペースに続けて否定的な文の内容が続く）
# 3. 上述1と2の内容を結合（concatenate）し，行をランダムに並び替える
#
# sentiment.txtを作成したら，正例（肯定的な文）の数と負例（否定的な文）の数を確認せよ．

pos_file_path = File.expand_path('../data/rt-polaritydata/rt-polarity.pos', __dir__)
neg_file_path = File.expand_path('../data/rt-polaritydata/rt-polarity.neg', __dir__)

sentiment_file_path = File.expand_path('../output/sentiment.txt', __dir__)

pos = File.readlines(pos_file_path).map { |line| "+1 #{line}" }
neg = File.readlines(neg_file_path).map { |line| "-1 #{line}" }

puts "正例の数: #{pos.size}"
puts "負例の数: #{neg.size}"

res = pos + neg
File.open(sentiment_file_path, 'w') { |f| f.puts res }
puts 'See output/sentiment.txt'
