# エイリアスを渡す

`sudo`を使っているとき、エイリアスをrootアカウントに持ち越せない。

## 解決方法

```bash
# 最後に半角スペースを入れるのがポイント
alias sudo='sudo '
```

## 解説

aliasは行頭に無い限り解釈されない。

```console
$ type ll
ll is aliased to `clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"'
```

`type clear && la -l --color=auto --human-readable --time-style="+%y-%m-%d %H:%M:%S"`として解釈されていないないことに気付くべき。  
`ll`は`ll`として扱われている。

つまり、この`ll`をroot空間に持っていくと、`ll`として解釈されるので、当然。

```console
$ sudo ll
sudo: ll: command not found
```

エラーになる。

しかし、aliasの末尾が空白であれば、次の文字列もaliasとして再解釈してくれる。

> 裏技的だがbashの仕様である

## 参考

- [Passing aliases（英語）](https://wiki.archlinux.org/title/sudo)
- [エイリアスを渡す（日本語）](https://www.gnu.org/savannah-checkouts/gnu/bash/manual/bash.html#Aliases)

### manコマンド

The first word of each simple command, if unquoted, is checked to see if it has an alias.  
最初のコマンドが引用符で囲まれていない場合に alias を確認する。  
[…]  
（中略）  
If the last character of the alias value is a space or tab character, then the next command word following the alias is also checked for alias expansion.  
alias の値がスペースかタブで終わっていればその次のコマンドも確認する
