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