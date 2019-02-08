task default: :build

desc 'Execute each script and generate output/results.md'
task :build do
  CHAPTER_TITLES = %w[準備運動 UNIXコマンドの基礎 正規表現 形態素解析 係り受け解析 英語テキストの処理 データベース 機械学習 ベクトル空間法\ (I) ベクトル空間法\ (II)].freeze
  File.open('output/index.md', 'w') do |file|
    Dir.glob('src/*.rb').sort.each_slice(10).with_index do |paths, i|
      file.puts "## 第#{i + 1}章: #{CHAPTER_TITLES[i]}"
      paths.each do |path|
        number           = File.basename(path, '.rb')
        question, answer = File.read(path).split(/^\n/, 2)
        output           = `bundle exec ruby #{path}`

        raise output unless Process.last_status.success?

        file.puts <<~MARKDOWN
          ### #{number}

          #{question.gsub(/^#/, '>').chomp}

          ```ruby
          #{answer.chomp}
          ```

          ```
          #{output.chomp}
          ```

        MARKDOWN

        print number, ' '
      end
    end
  end
  puts "\nCompleted!"
end
