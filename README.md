# iptables のコマンドを実行するスクリプト

**参考**

[Simple stateful firewall](https://wiki.archlinux.org/index.php/Simple_stateful_firewall)

## reset.sh
iptables に初期設定を適用します。

## default.sh
iptables にデフォルトの設定を適用します。

> ssh 接続のみ許可します。

> スクリプトの先頭で任意のポート番号を設定できます。(デフォルト: 22)

## save.sh
iptables に適用した設定を保存します。

## 備考
### iptables サービス操作
```
$ systemctl [start|stop|status|restart] iptables 
```

### iptables の状態確認
```
$ iptables -nvL

# 直接ファイルを見る場合。
$ cat /etc/iptables/iptables.rules
```

### iptables のルール削除
```
# 削除するルールのチェインと番号を確認する。
$ iptables -nvL --line-numbers

# チェインと番号を指定して削除する。
$ iptables -D <チェイン> <番号>
```
