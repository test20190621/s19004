{0509}
[1] /binディレクトリ下のファイルで1文字目がcで3文字のファイルの一覧
ls /bin/c??
# cd /bin
# ls c??
# cd -


[2] カレントディレクトリにディレクトリ(dir1/dir2/dir3)作成
mkdir -p dir1/dir2/dir3


[3] ディレクトリdir3下にファイル(file01からfile10の10ファイル)を作成
touch dir1/dir2/dir3/file{01..10}


[4] ディレクトリdir3下にファイル(file01からfile05の5ファイル)を削除
rm -r dir1/dir2/dir3/file{01..05}


[5] ディレクトリdir1を全て削除
rm -r dir1



{0515}
[1] findを使用して/var/logディレクトリ以下で拡張子が「log」ファイルの一覧を検索
find /var/log -name '*.log'


[2] findを使用して/homeディレクトリ以下で「.vim」ディレクトリを検索
find /home -type d -name '.vim'


[3] locateを使用してファイル名に「syslog」を含むファイルの一覧を検索
locate -b syslog


[4] manを使用して「date」コマンドのマニュアルを表示
man date


[5] whichを使用して「unix1.sh」シェルスクリプトを探す
which unix1.sh



{0516}
[1] 「unix1.sh」シェルスクリプトをエイリアスを「u1」で作成
    「u1」がエイリアスであることを確認
    「u1」エイリアスを削除
alias u1='unix1.sh'
type u1
unalias u1


[2] 現在のロケールを表示
echo $LANG


[3] 現在使用しているシェルのパスを表示
echo $SHELL


[4] コマンド検索パスを表示
echo $PATH


[5] 変数「NLS_LANG」に「JAPANESE_JAPAN.AL32UTF8」という値を環境変数として設定
    環境変数に正しく設定できていることを確認
export NLS_LANG='JAPANESE_JAPAN.AL32UTF8'
printenv | grep NLS



{0521} コマンドは一般ユーザで実行し、標準エラー出力は/dev/nullへリダイレクトする
[1] ホームディレクトリ以下(サブディレクトリも含む)にあるファイル数を表示する
find ~ -type f 2> /dev/null | wc -l


[2] ホームディレクトリ以下(サブディレクトリも含む)にあるファイルをファイルパスの昇順でソートして上位5件を表示する
find ~ -type f 2> /dev/null | sort | head -n 5


[3] ホームディレクトリ以下(サブディレクトリも含む)にあるファイルをファイルパ3の降順でソートして上位5件を表示する
find ~ -type f 2> /dev/null | sort -r | head -n 5


[4] /etc/passwdの第1フィールドのユーザ名の降順にソートして上位5件を表示する
cut -d : -f 1 /etc/passwd | sort -r | head -n 5


[5] /etc/passwdの第7フィールドのログインシェルから使用しているログインシェルの種類の一覧を表示する
cut -d : -f 7 /etc/passwd | sort | uniq



{0523} コマンドは一般ユーザで実行し、標準エラー出力は/dev/nullへリダイレクトする
[1] /etc/passwdファイルからログインシェルとして/bin/bashを使用しているユーザのユーザ名のみの一覧をユーザ名の昇順で表示する
cat /etc/passwd | grep '/bin/bash' | cut -d : -f 1 | sort


[2] /etcディレクトリ配下(サブディレクトリも含む)から「network.conf」を検索する
find /etc/ -type f 2> /dev/null | grep '/network.conf'


[3] ホームディレクトリ以下(サブディレクトリも含む)にあるファイルをファイル名の昇順でソートして上位5件を表示する
    ファイル名の一覧を取得する際、「ls -R」を使用する
ls -R ~ | grep -v '^$' | grep -v 'home' | sort | head -n 5


[4] ホームディレクトリ以下(サブディレクトリも含む)にあるファイルをファイル名の降順でソートして上位5件を表示する
    ファイル名の一覧を取得する際、「ls -R」を使用する
ls -R ~ | grep -v '^$' | grep -v 'home' | sort -r | head -n 5


[5] /etc ディレクトリ以下のファイルについて「172.16.40.1」の記述があるファイル名の一覧を表示する
#find /etc/ -type f 2> /dev/null | xargs grep -L '172.16.40.1' 2> /dev/null
find /etc/ -type f -print0 2> /dev/null |xargs -0 grep -l '172.16.40.1' 2> /dev/null
#grep -rl '172.16.40.1' /etc 2> /dev/null



{0528} 必要であればコマンドは管理者ユーザで実行する
[1] /etc/passwdファイルから現在のログインユーザの情報を表示
    現在のログインユーザはシェル変数「USER」を参照
grep $USER /etc/passwd


[2] /etc/servicesファイルから「80/tcp」の行を抽出する
cat /etc/services | grep '80/tcp' | grep 'www'


[3] ホームディレクトリ以下(サブディレクトリも含む)にある
    ファイル及びディレクトリの数をそれぞれ表示する
sudo find ~ -type f | wc -l
sudo find ~ -type d | wc -l


[4] /varディレクトリ以下(サブディレクトリも含む)にあるファイルの容量の多い
上位5件を表示する
sudo ls -lR /var | awk '{print $9, $5}' | sort -nr -k 2 | head -n 5


[5] /varディレクトリ以下(サブディレクトリも含む)にあるファイルの容量が0のファイルをすべて表示する
sudo find /var -type f | xargs sudo du | awk '$1 ~ /^0$/{print $0}'

