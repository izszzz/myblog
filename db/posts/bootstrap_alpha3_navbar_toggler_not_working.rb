Post.create(
  category_list: "Tech",
  tag_list: "bootstrap",
  title: "bootstrap-rubygem-v5.0.0.alpha3の注意点",
  summary: "bootstrap-rubygem-v5.0.0.alpha3でJSがうまく動かない場合の解決方法",
  body:  <<-EOS
# bootstrap-rubygem-v5.0.0.alpha3の注意点

- [bootstrap-rubygem-v5.0.0.alpha3の注意点](#bootstrap-rubygem-v500alpha3の注意点)
  - [はじめに](#はじめに)
  - [NavbarをトグルするJSが動かない問題](#navbarをトグルするjsが動かない問題)
  - [解決策](#解決策)

## はじめに

bootstrap-rubygem-v5.0.0.alpha3を使用する際の注意点
修正される可能性があるので、

## NavbarをトグルするJSが動かない問題

[Bootstrap-Navbar-Toggler](https://getbootstrap.com/docs/5.0/components/navbar/#toggler)
上記のコードを参考にトグルを実装したが、動作しなかった。

- コンソールにロードエラーはない
- 検証ツールの`EventListenerBreakpoints`でMouseEvent-Clickを確認したが、bootstrapのjsが機能していない
- Githubのissueに該当するものがない

## 解決策

[bootstrap-rubygem](https://github.com/twbs/bootstrap-rubygem)
[bootstrap-rubygem/Search by data-toggle](https://github.com/twbs/bootstrap-rubygem/search?q=data-toggle)

data-bs-toggleで検索したところ、ヒットせず、data-toggleがヒットした。
つまり

`data-bs-属性`は対応しておらず`data-属性`を使わなければならない。

Navbar Togglerの場合は以下のようになる

```html
<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarToggler" aria-controls="navbarToggler" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
</button>
```
  EOS
)