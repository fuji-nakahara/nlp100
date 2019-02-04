# 自然数Nをコマンドライン引数などの手段で受け取り，入力のファイルを行単位でN分割せよ．
# 同様の処理をsplitコマンドで実現せよ．

require 'tmpdir'

n = ARGV[0]&.to_i || 3

file_path = File.expand_path('../data/hightemp.txt', __dir__)

lines      = File.readlines(file_path)
line_count = (lines.size / n.to_f).ceil
results    = lines.each_slice(line_count).map(&:join)

Dir.mktmpdir do |dir|
  system "cd #{dir} && split -l #{line_count} #{file_path}"
  answers = Dir.children(dir).sort.map { |path| File.read(File.join(dir, path)) }
  raise 'Failed!' if results.zip(answers).any? { |res, ans| res != ans }
end

results.each.with_index(1) do |res, i|
  puts i, res, ''
end
