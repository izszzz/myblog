# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: Rails.application.credentials.yahoo[user_name], password: Rails.application.credentials.yahoo[password])

Post.create(
  category_list: "Tech",
  tag_list: "raspberry-pi, linux",
  title: "RaspberryPi ZeroでWifiにつながらない場合にやること",
  summary: "RaspberryPiのWifiの設定でつまずいたときの解決方法",
  body: <<-EOS
# RaspberryPi ZeroでWifiにつながらない場合にやること

RaspberryPiのWifiの設定でつまづいたときの解決方法。

- [RaspberryPi ZeroでWifiにつながらない場合にやること](#raspberrypi-zeroでwifiにつながらない場合にやること)
  - [wpa_supplicant.confに問題がある](#wpa_supplicantconfに問題がある)
    - [必要な設定がない](#必要な設定がない)
    - [ssid & pskに間違いがある](#ssid-&-pskに間違いがある)
    - [Wifiがステルスされている](#wifiがステルスされている)
    - [地域設定が必要な場合がある](#地域設定が必要な場合がある)
    - [ap_scanが必要な場合がある](#ap_scanが必要な場合がある)
    - [手動でwpa_supplicantを立ち上げてみる](#手動でwpa_supplicantを立ち上げてみる)
      - [WLAN soft blockedが表示された場合](#wlan-soft-blockedが表示された場合)
      - [手動でのネットワーク接続に成功した場合](#手動でのネットワーク接続に成功した場合)
        - [dhcpcdのログに10-wpa_supplicantが実行されているが、起動しない場合](#dhcpcdのログに10-wpa_supplicantが実行されているが起動しない場合)

## wpa_supplicant.confに問題がある

[wpa_supplicantの日本語Wiki][1]
wpa_supplicantの編集を行った後、下記を参考にwlanかRaspberry Piを再起動すること。
RaspberryPiの再起動のほうが確実に設定を反映させることができる。

raspberry piを再起動する

```cmd
sudo reboot
```

wlanを再起動する

```cmd
sudo ifconfig wlan0 down
sudo ifconfig wlan0 up
```

`wpa_supplicant.conf`を編集したあと、wpa_cliを再起動する

```cmd
wpa_cli -i wlan0 reconfigure
```

### 必要な設定がない

RaspberryPiのOSをインストールした時点での`wpa_supplicant.conf`の設定を、削除または上書き、を行った可能性がある。
下記の2行は必須である。

```conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
```

### ssid & pskに間違いがある

- 誤字脱字
- 右辺がダブルクオーテーションで囲われているか
- スペースとタブを削除する

### Wifiがステルスされている

Wifiがステルスされている場合は、`scan_ssid=1`が必要。

```conf
network={
    ssid=""
    psk=""
    scan_ssid=1
}
```

### 地域設定が必要な場合がある

地域設定を行うと接続できる場合がある。

```conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
country=JP
network={
    ssid=""
    psk=""
}
```

### ap_scanが必要な場合がある

[wiki][1]によると、ネットワークによっては`ap_scan=1`の設定が必要な場合がある

```conf
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1
ap_scan=1
country=JP
network={
    ssid=""
    psk=""
}
```

### 手動でwpa_supplicantを立ち上げてみる

[wiki][1]に記載されているwpa_supplicantコマンドを使用し、動作確認を行う
以下コマンドを入力

```cmd
sudo killall wpa_supplicant
sudo wpa_supplicant -B -c /etc/wpa_supplicant/wpa_supplicant.conf -iwlan0
ifconfig => inetなどが表示されれば成功
```

#### WLAN soft blocked　が表示された場合

[参考][2]

#### 手動でのネットワーク接続に成功した場合

手動では動作するが起動時に動作しない場合は、基本的にsystemdかdhcpcdのどちらかで問題が発生している。以下コマンドでsystemdのログを確認する

```cmd
sudo systemctl status dhcpcd
sudo systemctl status wpa_supplicant
```

##### dhcpcdのログに10-wpa_supplicantが実行されているが、起動しない場合

`/lib/dhcpcd/dhcpcd-hooks/10-wpa_supplicant`に`-nl180211,wext`または`-wext,nl180211`が含まれた行がある。

- `-nl180211,wext`の場合`-wext,nl180211`に変更
- `-wext,nl180211`の場合`-nl180211,wext`に変更

再起動する。

[1]:https://wiki.archlinux.jp/index.php/Wpa_supplicant
[2]:https://qiita.com/nanbuwks/items/b44b51eed264e246736c
EOS
)

Post.create(
  category_list: "Tech",
  tag_list: "react, js",
  title: "react-monaco-editorでaddCommandを使う",
  summary: "react-monaco-editorでaddCommandを使うときの注意点",
  body: <<-EOS
# react-monaco-editorでaddCommandを使う

react-monaco-editorでaddCommandを使うときの注意点

- [react-monaco-editorでaddCommandを使う](#react-monaco-editorでaddcommandを使う)
    - [はじめに](#はじめに)
    - [editorDidMountの問題](#editordidmountの問題)
    - [解決策](#解決策)

## はじめに

react-monaco-editorをFunctional Componentで使用した際に起きた問題と解決方法を記載する。
[react-monaco-editor(github)][1]

## editorDidMountの問題

今回の問題は、monaco-editorに`Ctrl+S`コマンドを追加してセーブ機能を追加する際に起きた。

```jsx
const [editorText, setEditorText] = useState("")

const editorDidMount = (editor)=> {
    editor.addCommand(monaco.KeyMod.CtrlCmd | monaco.KeyCode.Key_S, ()=>{
        console.log(editorText)　//ファイルにエディターのテキストの内容を保存
    })
}
return(
    <MonacoEditor
        onChange={setEditorText} //エディターが更新されるたびにeditorTextを更新する
        editorDidMount={editorDidMount} //　マウントされた時、addCommandをする。
    />
)
```

これで、MonacoEditorにテキストを入力し`Ctrl+S`を押すと空文字が返される。
原因は、editorDidMountがstateやpropsの変更を検知せず、更新しないからである。
`Ctrl+S`を押す度、ステートの初期値が返されている。
命名規則からも、クラスコンポーネントをもとに作られた関数なので更新されない。

## 解決策

Hooksでは以下のように行う。

```jsx
const editorRef = useRef(null)
const [editorText, setEditorText] = useState("")

useEffect(() => {
    const editor = editorRef.current?.editor;
    editor.addCommand(
        monaco.KeyMod.CtrlCmd | monaco.KeyCode.KEY_S,
        console.log(editoText)
    );
}, [editorText]); // editorTextが更新されるたびにアップデート

return(
    <MonacoEditor
        ref={editorRef}
        onChange={setEditorText} 
    />
)
```

これで、editoTextが更新されるたびにuseEffectが発火し、editorTextが最新の状態でaddCommandに渡されるようになる

[1]:https://github.com/react-monaco-editor/react-monaco-editor
EOS
)

Post.create(
  category_list: "Tech",
  tag_list: "linux, raspberry-pi",
  title: "bluetoothctlのpairは成功するが、connectが失敗する",
  summary: "RaspberryPiのbluetoothctlコマンドのconnectが失敗するときの解決方法",
  body: <<-EOS
# bluetoothctlのpairは成功するが、connectが失敗する

RaspberryPiのbluetoothctlコマンドのconnectが失敗するときの解決方法

- [bluetoothctlのpairは成功するが、connectが失敗する](#bluetoothctlのpairは成功するがconnectが失敗する)
    - [はじめに](#はじめに)
    - [connectが失敗する](#connectが失敗する)
    - [解決策](#解決策)
      - [`sap-server: Operation not permitted (1)` が表示された場合](#sap-server-operation-not-permitted-1-が表示された場合)
      - [`a2dp-source profile connect failed for Protocol not available`　が表示された場合](#a2dp-source-profile-connect-failed-for-protocol-not-availableが表示された場合)

## はじめに

Raspberry Pi ZeroとMacBook間でBluetooth通信を行う際に起きた問題と解決方法を記載する

## connectが失敗する

pairは成功したが、connectが以下のように失敗する。

```log
Attempting to connect to 
Failed to connect: org.bluez.Error.Failed
```

## 解決策

bluetoothが正常に動いているか確認する。

```cmd
sudo service bluetooth status
```

私の場合は以下が表示された

```log
Dec 02 13:08:34  bluetoothd[351]: Sap driver initialization failed.
Dec 02 13:08:34  bluetoothd[351]: sap-server: Operation not permitted (1)
Dec 02 13:08:35  bluetoothd[351]: Failed to set privacy: Rejected (0x0b)
Dec 31 13:50:55  bluetoothd[351]: a2dp-source profile connect failed for 38:F9:D3:83:75:33: Protocol not available
Dec 31 13:59:10  systemd[1]: bluetooth.service: Current command vanished from the unit file, execution of the command list won't be resumed.
```

### `sap-server: Operation not permitted (1)` が表示された場合

`/etc/systemd/system/bluetooth.target.wants/bluetooth.service`を変更

```js
// ExecStart=/usr/lib/bluetooth/bluetoothd 変更前
ExecStart=/usr/lib/bluetooth/bluetoothd --noplugin=sap //変更後
```

systemdを再起動

```cmd
sudo systemctl daemon-reload
```

Bluetoothを再起動

```cmd
sudo service bluetooth restart
```

[参考][1]

### `a2dp-source profile connect failed for Protocol not available`　が表示された場合

pulseaudio-module-bluetoothパッケージをインストール

```cmd
sudo apt install pulseaudio-module-bluetooth
```

pulseaudioを再起動

```cmd
sudo killall pulseaudio
sudo pulseaudio --start //sudoでwarningが出た場合、sudoなしで実行
```

bluetoothを再起動

```cmd
sudo systemctl restart bluetooth
```

[1]:https://qastack.jp/raspberrypi/40839/sap-error-on-bluetooth-service-status
EOS
)

Post.create(
  category_list: "Tech",
  tag_list: "raspberry-pi, linux",
  title: "RaspberryPi Zeroでgattlibのインストールが失敗する",
  summary: "RaspberryPi Zeroでpybluez[ble]のgattlibのインストールに失敗したときの解決方法",
  body:  <<-EOS
# RaspberryPi Zeroでgattlibのインストールが失敗する

RaspberryPi Zeroでpybluez[ble]のgattlibのインストールに失敗したときの解決方法

## はじめに

[こちらの記事][1]を確認することを推奨する。

- [RaspberryPi Zeroでgattlibのインストールが失敗する](#raspberrypi-zeroでgattlibのインストールが失敗する)
  - [はじめに](#はじめに)
  - [発生したエラー](#発生したエラー)
  - [解決](#解決)
    - [スワップファイルサイズを変更する](#スワップファイルサイズを変更する)
      - [`/etc/dphys-swapfile`を変更する](#etcdphys-swapfileを変更する)
      - [スワップファイルの再起動](#スワップファイルの再起動)
    - [インストールをする](#インストールをする)
      - [pybluez[ble]をインストールし、gattlibのバージョンを確認する](#pybluezbleをインストールしgattlibのバージョンを確認する)
      - [pipからダウンロードをする](#pipからダウンロードをする)
      - [解凍する](#解凍する)
      - [boost_pythonのバージョンを確認する](#boost_pythonのバージョンを確認する)
      - [setup.pyを編集する](#setuppyを編集する)
      - [インストールする](#インストールする)
    - [/usr/bin/ld: cannot find -lboost_python-py37と出る場合](#usrbinld-cannot-find--lboost_python-py37と出る場合)

## 発生したエラー

```log
$ sudo pip3 install gattlib
    arm-linux-gnueabihf-gcc: fatal error: Killed signal terminated program cc1plus
    compilation terminated.
    error: command 'arm-linux-gnueabihf-gcc' failed with exit status 1

    ----------------------------------------
    Failed building wheel for gattlib
    Running setup.py clean for gattlib
    Failed to build gattlib
```

```log
$ dmesg
[ 1166.930902] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),global_oom,task_memcg=/,task=cc1plus,pid=493,uid=0
[ 1166.930952] Out of memory: Killed process 493 (cc1plus) total-vm:480436kB, anon-rss:376708kB, file-rss:148kB, shmem-rss:0kB, UID:0 pgtables:470kB oom_score_adj:0
[ 1167.168126] oom_reaper: reaped process 493 (cc1plus), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB
```

[こちらの記事][1]でも同じエラーが発生しており、RaspberryPi Zeroではメモリが足りないと記述している。

## 解決

### スワップファイルサイズを変更する

[こちらの記事][4]を参考にする。

#### `/etc/dphys-swapfile`を変更する

```cmd
sudo vi /etc/dphys-swapfile
```

```conf
CONF_SWAPSIZE=100 //変更前
CONF_SWAPSIZE=1024 //変更後
```

#### スワップファイルの再起動

```cmd
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start
```

### インストールをする

[こちらの記事][2]を参考にする。

#### pybluez[ble]をインストールし、gattlibのバージョンを確認する

確認したら、`Ctrl+C`で中止する。

```log
pip3 install pybluez[ble]

Collecting gattlib==0.20150805; extra == "ble" (from pybluez[ble])
```

この場合gattlib==`0.20150805`がバージョンになる。
[PyPi(gattlib)][3]でも確認ができる。

#### pipからダウンロードをする

```cmd
pip download gattlib==0.20150805
```

#### 解凍する

```cmd
tar xvzf ./gattlib-0.20150805.tar.gz
```

#### boost_pythonのバージョンを確認する

最新のバージョンを確認する。

```log
sudo find / -name "libboost_python*"

/usr/lib/arm-linux-gnueabihf/libboost_python37.a
/usr/lib/arm-linux-gnueabihf/libboost_python27.a
/usr/lib/arm-linux-gnueabihf/libboost_python37.so
/usr/lib/arm-linux-gnueabihf/libboost_python3.a
/usr/lib/arm-linux-gnueabihf/libboost_python27.so.1.67.0
/usr/lib/arm-linux-gnueabihf/libboost_python3.so
/usr/lib/arm-linux-gnueabihf/libboost_python3-py37.a
/usr/lib/arm-linux-gnueabihf/libboost_python37.so.1.67.0
/usr/lib/arm-linux-gnueabihf/libboost_python.so
/usr/lib/arm-linux-gnueabihf/libboost_python3-py37.so
/usr/lib/arm-linux-gnueabihf/libboost_python27.so
/usr/lib/arm-linux-gnueabihf/libboost_python.a
```

この場合は`37`...?

#### setup.pyを編集する

[boost_pythonのバージョンを確認する](#boost_pythonのバージョンを確認する)で取得したバージョンを、以下のコマンドに入れる。

```cmd
sed -ie 's/boost_python-py34/boost_python-py{XX}/' setup.py
私の場合は  sed -ie 's/boost_python-py34/boost_python-py37/' setup.py
```

#### インストールする

```cmd
sudo pip3 install .
```

```cmd
sudo pip3 pybluez[ble]
```

### /usr/bin/ld: cannot find -lboost_python-py37と出る場合

sedを変更する

```cmd
sed -ie 's/boost_python-py{XX}/boost_python3/' setup.py
```

[1]:https://qiita.com/utsuki/items/5e66b53c55359efbec66
[2]:https://gist.github.com/stonehippo/d56d626927d0d4d137428341ac95b87b
[3]:https://pypi.org/project/gattlib/#history
[4]:https://www.bitpi.co/2015/02/11/how-to-change-raspberry-pis-swapfile-size-on-rasbian/
EOS
)

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