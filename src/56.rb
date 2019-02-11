# Stanford Core NLPの共参照解析の結果に基づき，文中の参照表現（mention）を代表参照表現（representative mention）に置換せよ．
# ただし，置換するときは，「代表参照表現（参照表現）」のように，元の参照表現が分かるように配慮せよ．

require 'rexml/document'

file_path = File.expand_path('../data/nlp.txt.xml', __dir__)

doc = REXML::Document.new(File.open(file_path))

sentences = []
doc.elements.each('/root/document/sentences/sentence') do |sentence|
  sentence_id = sentence.attributes['id']

  words         = []
  next_token_id = 0
  sentence.elements.each('tokens/token') do |token|
    token_id = token.attributes['id'].to_i
    next if token_id < next_token_id

    mention_predicate = "not(@representative='true') and sentence/text()=#{sentence_id} and start/text()=#{token_id}"
    mention           = doc.elements["/root/document/coreference/coreference/mention[#{mention_predicate}]"]
    next words << token.elements['word'].text if mention.nil?

    original_text       = mention.elements['text'].text
    representative_text = mention.elements['preceding-sibling::mention[@representative="true"]/text'].text
    words << "#{representative_text} (#{original_text})"

    next_token_id = mention.elements['end'].text.to_i
  end

  sentences << words.join(' ')
end

puts sentences.first(10)
File.open(File.expand_path('../output/56.txt', __dir__), 'w') { |f| f.puts sentences }
