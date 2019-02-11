# 言語処理100本ノック

[言語処理100本ノック 2015](http://www.cl.ecei.tohoku.ac.jp/nlp100/) を Ruby で解きました。  
回答は [`src`](src) ディレクトリに `#{問題番号}.rb` の形で置いてあります。  
問題文、回答、実行結果は https://fuji-nakahara.github.io/nlp100/ から一覧できます。 

## Setup

はじめに、このリポジトリをクローンします:

    $ git clone https://github.com/fuji-nakahara/nlp100.git

次に、依存する以下のソフトウェアをインストールしてください:

- [Ruby](https://www.ruby-lang.org/ja/) 2.6.1
- [MeCab](http://taku910.github.io/mecab/) 0.996 (with IPA dictionary)
- [gnuplot](http://www.gnuplot.info/) 5.2.6
- [CaboCha](https://taku910.github.io/cabocha/) 0.69
- [Graphviz](http://www.graphviz.org/) 2.40.1
- [Stanford CoreNLP](https://stanfordnlp.github.io/CoreNLP/) 3.9.2
- [Redis](https://redis.io/) 5.0.3

macOS であれば Homebrew を使ってこれらをインストールできます:

    $ brew install ruby mecab mecab-ipadic gnuplot cabocha graphviz stanford-corenlp redis

インストールができれば、スクリプト `bin/setup` を実行してください:

    $ cd nlp100 && bin/setup

このスクリプトは、課題を解くのに必要なデータのダウンロードと前処理、必要な gem のインストールを行います。

以上で、回答の Ruby プログラムを実行するのに必要な環境が整いました。

## Usage

回答の Ruby プログラムは `bundle exec ruby` コマンドで実行できます:

    $ bundle exec ruby src/01.rb

また、以下のコマンドで、すべての回答とその実行時の標準出力を記録したファイル `output/index.md` を作成できます:

    $ bundle exec rake

## References

- [素人の言語処理100本ノック:まとめ - Qiita](https://qiita.com/segavvy/items/fb50ba8097d59475f760)
- [言語処理100本ノック2015 をRubyでやる【第1章】 - ようじょのおえかきちょう](https://yamasy1549.hateblo.jp/entry/2017/12/28/222631)
