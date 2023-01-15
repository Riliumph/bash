# 制御コード

`ctrl+↑`などのキーコードは制御コードを用いて実装する。  
この制御コードを記述する際にはANSI-C Quotingを用いる。

## ANSI-C Quotingとは

> - 参考
>   - [3.1.2.4 ANSI-C Quoting](https://www.gnu.org/software/bash/manual/bash.html#ANSI_002dC-Quoting)

制御コードを書くときは以下のどちらかを使う

- `\e`
- `\E`  
  ANSI-Cサポート外のエスケープ文字

## ANSI Escape Sequence Table

設定しているANSIテーブル

> `^[`はESCキーのキーコード

| Key | Terminal.app | Natural Encoding |
|:--:|:--:|:--:|
| ⌥↑ | ^[[A | \e[1;3A |
| ⌥↓ | ^[[B | \e[1;3B |
| ⌥← | ^[[C | \e[1;3C |
| ⌥→ | ^[[D | \e[1;3D |
| ⌥DEL | ^[[D | \e[1;3D |
