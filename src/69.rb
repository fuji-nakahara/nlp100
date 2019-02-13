# ユーザから入力された検索条件に合致するアーティストの情報を表示するWebアプリケーションを作成せよ．
# アーティスト名，アーティストの別名，タグ等で検索条件を指定し，アーティスト情報のリストをレーティングの高い順などで整列して表示せよ．

require 'erb'
require 'webrick'
require 'mongo'

HTML_TEMPLATE = <<~'HTML'.freeze
  <!DOCTYPE html>
  <html lang="ja">
    <head>
      <meta charset="utf-8">
      <title>言語処理100本ノック 69</title>
    </head>
    <body>
      <form action="/" method="get">
        <div>
          <label for="name">名前</label>
          <input type="text" id="name" name="name" value="<%= h query['name']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <label for="alias_name">別名</label>
          <input type="text" id="alias_name" name="aliases.name" value="<%= h query['aliases.name']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <label for="tag">タグ</label>
          <input type="text" id="tag" name="tags.value" value="<%= h query['tags.value']&.force_encoding('utf-8') %>">
        </div>
        <div>
          <button type="submit">送信</button>
        </div>
      </form>
      <% if !query.empty? && results.empty? %>
        <p>
          該当するアーティストは見つかりませんでした。
        </p>
      <% elsif !results.empty? %>
        <hr>
        <table>
          <thead>
            <tr>
              <th>名前</th>
              <th>別名</th>
              <th>活動場所</th>
              <th>活動開始年</th>
              <th>活動終了年</th>
              <th>タグ</th>
              <th>レーティング</th>
            </tr>
          </thead>
          <tbody>
            <% results.each do |artist| %>
              <tr>
                <td><%= artist['name'] %></td>
                <td><%= artist['aliases']&.map { |a| a['name'] }&.join(', ') %></td>
                <td><%= artist['area'] %></td>
                <td><%= artist.dig('begin', 'year') %></td>
                <td><%= artist.dig('end', 'year') %></td>
                <td><%= artist['tags']&.map { |tag| "#{tag['value']} (#{tag['count']})" }&.join(' / ') %></td>
                <td><%= artist['rating'] ? "#{artist['rating']['value']} (#{artist['rating']['count']})" : '' %></td>
              </tr>
            <% end %>
          </tbody>
        </table>
      <% end %>
    </body>
  </html>
HTML

mongo_client = Mongo::Client.new('mongodb://127.0.0.1:27017/nlp100')
collection   = mongo_client[:artist]

server = WEBrick::HTTPServer.new(BindAddress: '127.0.0.1', Port: 10080)
server.mount_proc('/') do |req, res|
  include ERB::Util

  query   = req.query.slice('name', 'aliases.name', 'tags.value').reject { |_, val| val.nil? || val.empty? }
  results = if query.empty?
              []
            else
              collection.find(query).sort('rating.value': -1).limit(50).to_a
            end

  res.body = ERB.new(HTML_TEMPLATE).result(binding)
end
server.start
