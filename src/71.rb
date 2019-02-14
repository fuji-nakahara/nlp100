# 英語のストップワードのリスト（ストップリスト）を適当に作成せよ．
# さらに，引数に与えられた単語（文字列）がストップリストに含まれている場合は真，それ以外は偽を返す関数を実装せよ．
# さらに，その関数に対するテストを記述せよ．

require 'open-uri'

stopwords_url  = 'https://raw.githubusercontent.com/stanfordnlp/CoreNLP/master/data/edu/stanford/nlp/patterns/surface/stopwords.txt'
stopwords_path = File.expand_path('../data/stopwords.txt', __dir__)

STOPWORDS = if File.exist?(stopwords_path)
              File.readlines(stopwords_path, chomp: true)
            else
              OpenURI.open_uri(stopwords_url).readlines(chomp: true).tap do |lines|
                File.open(stopwords_path, 'w') { |f| f.puts lines }
              end
            end

def stopword?(word)
  STOPWORDS.include?(word)
end

return unless $PROGRAM_NAME == __FILE__

require 'minitest/autorun'

class TestStopword < Minitest::Test
  def test_that_it_is_stopword
    assert_equal stopword?('it'), true
  end

  def test_that_stopword_is_not_stopword
    assert_equal stopword?('stopword'), false
  end
end
