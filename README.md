# Becky PopMessage
Beckyの新着通知にPopMessageを用いるスクリプト

メーラー[Becky](http://www.rimarts.co.jp/becky-j.htm)の新着通知に、[PopMessage](http://www.u670.com/category/popmessage/)を用いるスクリプトファイル  
PopMessageの機能により、邪魔にならない新着通知が実現可能です。

## 使い方
* v.vbsを[ダウンロード](https://raw.githubusercontent.com/tatky/Becky_PopMessage/master/v.vbs)、任意の場所に配置
* PopMessageをダウンロード・解凍し、v.vbsと同じ場所にPopMessage.exeを配置
* Beckyの[プログラムを実行する機能](https://goo.gl/XE2Rse)を用いて、v.vbsを呼び出す

## 呼び出し方（オプション）
>wscript "[1で配置した場所]\v.vbs" "%1" 3600 14 TFCBA  

#### オプション
|No  |必須| Center align |
|:--:|:--:|:---------------------------------------------|
|   1|○   |Beckyの出力するメールファイル、そのまま       |
|   2|―   |表示秒数、PopMessageの/w                      |
|   3|―   |アイコン番号、PopMessageの/i                  |
|   4|―   |表示内容、書いた順番に内容表示、無い場合は本文|

#### No4の内容
|||
|:--:|:--------|
|T|Toアドレス  |
|F|Fromアドレス|
|C|Ccアドレス  |
|B|Bccアドレス |
|A|本文        |


