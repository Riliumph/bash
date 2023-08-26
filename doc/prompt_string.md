# Prompt string

## PS1に色をつける

PS1に色を付けたい場合、二通りのやり方がある。

- 制御文字を直接埋め込む
- `tput`コマンドを使う

### 動的に色を与えたい

例えば、実行結果に応じて色を変えたいとする。  
つまり、ダブルクオートによってコマンド結果を文字列に埋め込むのではなく、コマンド自体を文字列に埋め込んでしまい、`PS1`解釈時に実行することが必要になる。

> コマンド自体を埋め込む方法
>
> - シングルクォートで囲む
> - `$`を`\$`としてエスケープする

以下の手法が有るらしいが動かなかった。

> [Bash/プロンプトのカスタマイズ](https://wiki.archlinux.org/title/Bash/Prompt_customization)  
> 置換される関数の中で terminfo/ANSI のエスケープシーケンスを使うことはできますが Bash のエスケープを使うことはできません。特に \[ \] で出力不可能な文字列を囲んでも機能しません。代わりに8進数のエスケープ \001 や \002 を使ってください (例えば printf や echo -e を使用する場合)。

## PROMPT_STRING

コマンドが実行されて結果が返り、PS1が表示される前に評価される環境変数。  
評価されるためコマンドを書いておけばそれが実行される。

汎用性のために専用の関数を用意しておくことでワンライナーでは記述しにくい複雑な処理も実行できる。

## debian_chrootってなんだ？

> - 参考
>   - [What does "${debian_chroot:+($debian_chroot)}" do in my terminal prompt?](https://askubuntu.com/questions/372849/what-does-debian-chrootdebian-chroot-do-in-my-terminal-prompt)

debian distributionにおいて、`chroot`コマンドでルートディレクトリを変更した場合にだけ表示される。
