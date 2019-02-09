# 言語処理100本ノック

[言語処理100本ノック 2015](http://www.cl.ecei.tohoku.ac.jp/nlp100/) を Ruby で解きました。

## Requirements

- [MeCab](http://taku910.github.io/mecab/) 0.996 (with IPA dictionary)
- [gnuplot](http://www.gnuplot.info/) 5.2.6
- [CaboCha](https://taku910.github.io/cabocha/) 0.69
- [Graphviz](http://www.graphviz.org/) 2.40.1

macOS であれば Homebrew を使ってこれらをインストールできます:

    $ brew install mecab mecab-ipadic gnuplot cabocha graphviz

## Usage

```
$ git clone https://github.com/fuji-nakahara/nlp100.git
$ cd nlp100
$ bin/setup
$ bundle exec rake
```
