# TwitterSample  
Fabricを利用したTwitterクライアントサンプル、一通りやりたいこと試す

## 参考サイトメモ  
- [TwitStockerの作者のブログ](http://www.tejitak.com/blog/?p=940)…自分のアプリに応用がきく
- [正しいTLの取得の仕方を日本語訳してくれてるブログ](http://nonbiri-tereka.hatenablog.com/entry/2014/03/06/220015)…理屈はわかるけど実装方法が示されていない△
- [参考サイトなどまとめてる人](http://tasuwo.github.io/blog/2015/04/12/title/)…実際のコードがあればよかったけど無し、でもリンク集としてつかえそう
- [スライドとサンプルコードあるけど](http://lo-upe.hatenablog.com/entry/20140916/1410794248)…扱いにくい
- [APIが一覧して見れる](http://dx.24-7.co.jp/twitterapi1-1-rest-api/)…参考になる
- [公式ドキュメント](https://docs.fabric.io/ios)…何故かそのままだとエラーでるコードがのってる謎
- [Fabric入門記事](http://dev.classmethod.jp/series/fabric-入門/)…Objective-Cなのが△
- [Qiitaにあった記事](http://qiita.com/mokumoku/items/bf0460f420acac3c04fc)…とりあえずTLを表示するには一番しっかりしてる

## 機能  
- TLの表示
- リプライの表示
- アカウント切り替えはまだ
- ツイート編集画面も実装途中
- Fabric純正のTweetCellViewを使っているけどいいねなどのアクションボタンの仕様が普通のクライアントとかけ離れているので△
- idまわりの実装はわりと無理矢理
- ！ツイート画面まで実装しツイートできることが確認できたら画像APIのプロトタイプ作成に移行する
