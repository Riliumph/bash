# Quoting

> - 参考
>   - [3.1.2 Quoting](https://www.gnu.org/software/bash/manual/bash.html#Quoting)
>   - [3.1.2.4 ANSI-C Quoting](https://www.gnu.org/software/bash/manual/bash.html#ANSI_002dC-Quoting)
>   - [Bashの文字列で特殊文字を使う方法](https://azisava.sakura.ne.jp/programming/0010.html)

## シングルクォートをエスケープする

ダブルクォートとシングルクォートを組み合わせてエスケープする手法はよく使われる。  
しかし、シングルクォートの中でシングルクォートを使うとそこで文字列を閉じてしまってエスケープすることはできない。  
それをしたい場合、一旦文字列を閉じてシングルクォーテーション単体をエスケープする必要がある。

例えば、以下のようなコマンドを変数に入れて、後で`eval`したいとする。  
特に、今回は`awk`コマンドは少し特殊な事情を抱えている。  
それは、変数`$0`はあくまで`awk`コマンドに与えられた引数の0番目としたいため、`awk`コマンド側で解釈できるように`$0`という文字列そのままで渡したい。  

> これをダブルクオートで囲んでしまうと`bash`が`bash`実行時の`$0`でコマンドを上書きしてしまう。

```terminal
$ echo 'awk '\''!dictionary[$0]++'\'
awk '!dictionary[$0]++'
```

上記のコードは以下の３つの文字列に分割して解釈される。  

- `'awk'`
- `\'`
- `!dictionary[$0]++`
- `\'`

また、Bashは文字列を並べて書くと一つにまとめて解釈してくれるのでその性質を使って解決している。

## Git for Windows (Cygwin)環境の改行文字

> - 参考：
>   - [Git for Windows 2.xでプロンプトの設定(PS1)にブランチ名と改行を入れるとsyntax errorになる](https://orangeclover.hatenablog.com/entry/2017/02/18/220750)
>   - [PS1 bash command substitution not working on windows 10](https://stackoverflow.com/questions/33220492/ps1-bash-command-substitution-not-working-on-windows-10)
>   - [PS1 command substitution fails when containing newlines on msys bash](https://stackoverflow.com/questions/21517281/ps1-command-substitution-fails-when-containing-newlines-on-msys-bash)
>   - [Cygwin のプロンプトに Git のブランチを表示する（シンタックスエラーが発生した場合の対策あり）](https://qiita.com/amano41/items/5d2aed152a16f9d884df)

Git for Windows2.xを使ってPromptString1（`$PS1`）に改行（`\n`）を含ませている場合に以下のエラーに遭遇した。

```bash
GIT_BRANCH='$(__git_ps1)'
ps1+="${user}\u${norm}@${host}\h${norm}:${path}\w${norm}|${git}${GIT_BRANCH}"$'\n'
```

```terminal
bash: command substitution: line 1: syntax error near unexpected token `)'
bash: command substitution: line 1: `__git_ps1)'
```

このエラーは以下が確認されている。

- Git for Windows 1.xでは発生しない。
- Linuxでは発生しない

明らかにmsys側（Giw for Windows含む）の問題である。  
どうやら、Cygwin独自の`igncr`オプションが有効な時に「`$PS1`内で`$(command)`形式のコマンド置換の後に`\n`が続く」と構文解析に失敗する模様。

> `igncr`オプションが設定されている場合、CRLFの文字コードのCRを無視する挙動を取る。

回避策としては以下が考えられる

- `igncr`オプションを無効化する
- `$(command)`ではなく`` `command` ``を使う
  - ShellCheckでエラーとなるので論外
- ANSI-C Quoting(`$'string'`)で改行をエスケープする
