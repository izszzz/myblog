Post.create(
  category_list: "Tech",
  tag_list: "linux",
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
      - [/etc/dphys-swapfileを変更する](#etcdphys-swapfileを変更する)
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

#### /etc/dphys-swapfileを変更する

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
