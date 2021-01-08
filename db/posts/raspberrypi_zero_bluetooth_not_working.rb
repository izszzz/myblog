Post.create(
  category_list: "Tech",
  tag_list: "linux, raspberry-pi",
  title: "bluetoothctlのpairは成功するが、connectが失敗する",
  summary: "RaspberryPiのbluetoothctlコマンドのconnectが失敗するときの解決方法",
  body: <<-EOS
# bluetoothctlのpairは成功するが、connectが失敗する

- [bluetoothctlのpairは成功するが、connectが失敗する](#bluetoothctlのpairは成功するがconnectが失敗する)
  - [はじめに](#はじめに)
  - [connectが失敗する](#connectが失敗する)
  - [解決策](#解決策)
    - [sap-server: Operation not permitted (1)が表示された場合](#sap-server-operation-not-permitted-1が表示された場合)
    - [a2dp-source profile connect failed for Protocol not availableが表示された場合](#a2dp-source-profile-connect-failed-for-protocol-not-availableが表示された場合)

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

### sap-server: Operation not permitted (1)が表示された場合

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

### a2dp-source profile connect failed for Protocol not availableが表示された場合

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