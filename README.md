# iptables のコマンドを実行するスクリプト

## 参考
[Simple stateful firewall](https://wiki.archlinux.org/index.php/Simple_stateful_firewall)

## 使い方
1. `reset.sh`を実行し、初期設定を適用します。
1. `default.sh`を実行し、iptablesに規定値を設定します。
1. `save.sh`を実行し、iptablesに適用した設定を保存します。
1. iptablesサービスを再起動します。

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

### ログの確認方法
```
# マシンが最後に起動したときから記録されたパケットを全て表示する。
$ sudo journalctl -k | grep "IN=.*OUT=.*" | less
```
