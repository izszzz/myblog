Post.create(
  category_list: "Tech",
  tag_list: "rails, ruby",
  title: "google-analytics-railsが正しく動作しない",
  summary: "gemのgoogle-analytics-railsが正しく動作しない時の解決方法",
  body: <<-EOS
# google-analytics-railsが正しく動作しない

- [google-analytics-railsが正しく動作しない](#google-analytics-railsが正しく動作しない)
  - [はじめに](#はじめに)
  - [問題](#問題)
  - [解決](#解決)


## はじめに

gemの[google-analytics-rails][2]が正しく動作しない。

## 問題

[google-analytics-rails][2]を使用して、google-analyticsにサイトを登録しようとしたが、動作しなかった。
chrome拡張機能の、[GoogleAnalyticsDebugger][1]を導入し、ログを確認したところ、以下のワーニングが表示された。

```log
The tracking Id should only be of the format UA-NNNNNN-N.
```

## 解決

おそらく、[GoogleAnalyticsDebugger][1]と[google-analytics-rails][2]がGからはじまるトラッキングIDに対応していない。

headタグにコピペするだけで動作するので、素直にコピペして進める。
hamlの場合は以下をコピーする。

```haml
- if Rails.env.production?  
    %script{async: "", src: "https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"}
        :javascript
            window.dataLayer = window.dataLayer || [];
            function gtag(){dataLayer.push(arguments);}
            gtag('js', new Date());
            gtag('config', 'G-XXXXXXXXXX');
```

[1]:https://chrome.google.com/webstore/detail/google-analytics-debugger/jnkmfdileelhofjcijamephohjechhna?hl=ja
[2]:https://github.com/bgarret/google-analytics-rails/issues/45
EOS
)