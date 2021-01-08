Post.create(
  category_list: "Tech",
  tag_list: "apple",
  title: "MacOS10.14におけるGDBのインストールについて",
  summary: "「HACKING:美しき策謀」の環境構築をする際、gdbのインストールに失敗した。",
  body: <<-EOS
# MacOS10.14におけるGDBのインストールについて

「HACKING:美しき策謀」の環境構築をする際、gdbのインストールに失敗した。

  - [MacOS10.14におけるGDBのインストールについて](#macos1014におけるgdbのインストールについて)
  - [はじめに](#はじめに)
  - [結論1 : lldbを使う](#結論1--lldbを使う)
  - [結論2 : USBメモリを使いLinuxOSをデュアルブートさせる](#結論2--usbメモリを使いlinuxosをデュアルブートさせる)
  - [結論3 : オンラインサービスを使う](#結論3--オンラインサービスを使う)
  - [試す価値のある記事一覧](#試す価値のある記事一覧)
    - [証明書系](#証明書系)
    - [バージョン系](#バージョン系)
  
## はじめに

「HACKING:美しき策謀」の環境構築をする際、gdbのインストールに失敗した。

内容はファイルを指定した上でgdbを起動しrunをすると、証明書に関するエラーが表示される。

## 結論1 : lldbを使う

gdbを使う必要がなければ、lldbを使う

理由

- GDBに関する情報が少ない。
- 証明書の更新が再起動のため、時間がかかる
- lldbは初期ダウンロードされており、syntaxがすでにIntelようになっている。
- GDBはMacの種類によってエラーの治し方が大きく異なる。

## 結論2 : USBメモリを使いLinuxOSをデュアルブートさせる

理由

- LinuxOSにはgdbの機能が初期装備されている。
- LinuxOSは基本的に軽い
- USBメモリの設定をすればディスク容量を圧迫しない。

## 結論3 : オンラインサービスを使う

ヘッダー部にあるdebugボタンを押すと、画面下のコンソール画面でgdbが起動する。

[OnlineGdb](https://www.onlinegdb.com/)

## 試す価値のある記事一覧

### 証明書系

- [macOS Sierraでgdbを使う](https://qiita.com/kaityo256/items/d2f7ac7acc42cf2098b2)
- [mac OS 10.13(High Sierra) で gdb を使う](https://qiita.com/yuzu_afro/items/988020dd65fb4f43962a)
- [コード署名のメモ。brew install gdbだけでは動かないよという話](http://k-mawa.hateblo.jp/entry/2018/06/17/003336)
- [Apple](https://opensource.apple.com/source/lldb/lldb-69/docs/code-signing.txt)

### バージョン系

私が調査したときには、Macportにはgdbすら無く、brewでは前バージョンのgithubリンクが切れていたので、インストールができなかった。

- [macOS High Sierra 10.13 では gdb 8.1 は動かない](https://qiita.com/ryutok/items/c4124608a85071633fd0)
- [gdb を使えるようにする](http://nalab.mind.meiji.ac.jp/~mk/knowhow-2018/node23.html)
  
stackoverflow

- [MacOS端末のSierraにgdbをインストールする方法](https://stackoverflow.com/questions/41966073/how-to-install-gdb-on-macos-terminal-sierra)
- [gdb fails with “Unable to find Mach task port for process-id” error](https://stackoverflow.com/questions/11504377/gdb-fails-with-unable-to-find-mach-task-port-for-process-id-error)
EOS
)