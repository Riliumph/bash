# wsl用open関数の作り方

## 仕様

`open`は、引数に与えられたファイルをOSの設定で開くこと挙動を取る。  
基本的にはMacの`open`と同じである。

ファイルなら拡張子にあったファイラ―で開くし、ディレクトリをならエクスプローラで開くことになる。

## Windowsにおけるopen

まず、WSLで実装する前にコマンドプロンプトを経由する方法を考える。
Widowsにopenという関数はない。

方法は二つ

- `explorer.exe`を使う
- `start`コマンドを使う

## もっとも簡単な実装

WSLはLinuxの環境でWindowsコマンドが使える便利な機能がある。

```bash
alias open='explorer.exe'
```

ただし、`explorer.exe`はカレントディレクトリ以外を指定できない。

```console
$ explorer.exe ../foo/bar.txt
$ echo $?
1
```

## 改善案

`exploerer.exe`の代わりに`start`を使う方法がある。  
`start`は`cmd.exe`経由で使わないといけない注意点がある。

```bash
alias open='cmd.exe /c start'
```

## LinuxをパスをWindowsが認識しない

注意したいのは、Linuxの空間からWindowsの空間に存在するAPIへ居場所を知らせる方法である。  
上記のどちらを使ってもLinux上のパスは認識されない

```console
$ cmd.exe /c start .
'\\wsl.localhost\Ubuntu\home\username'
上記の現在のディレクトリで CMD.EXE を開始しました。
UNC パスはサポートされません。Windows ディレクトリを既定で使用します。
```

Linuxの空間は、どうやらWindowsの世界からみて`\\wsl.localhost\Ubuntu`にマウントされているようだ。  

> Linuxの世界から見てWindowsの空間は`/mnt/`にマウントされている。  
> Cドライブは`/mnt/c`だし、Dドライブは`/mnt/d`である。

`\\wsl.localhost`は一生変わらないだろうが、OS名の`Ubuntu`の部分はユーザ任意のため容易に変わってしまう。  
他にも区切り文字がLinuxは`/`だが、Windowsでは`\`であるし、もう色々表現方法が異なる。

これを変換してくれる便利な`wslpath`というコマンドをMSは用意している。

```console
$ wslpath
wslpath: Invalid argument
Usage:
    -a    force result to absolute path format
    -u    translate from a Windows path to a WSL path (default)
    -w    translate from a WSL path to a Windows path
    -m    translate from a WSL path to a Windows path, with '/' instead of '\'

EX: wslpath 'c:\users'
```

ただし、`alias`で複数のコマンドをパイプせずに使うのは辛いので関数にしてしまう手がある。

```bash
function open()
{
　　cmd.exe /c start $(wslpath -w $1)
}
```

Windowsの世界を認識しているコマンドに渡すのでWSLパスをWindowsパスへ変換する`-w`オプションを用いる。
