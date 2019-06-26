{0611} シェル内のコマンドはすべて一般ユーザで実行する
[1] スクリプト実行時より夏休み(9/1から)までの日数を表示する
expr \( `date --date "20190901" +%s` - `date --date "today" +%s` \) / 60 / 60 / 24


[2] 5/7よりスクリプト実行時までの日数を表示する
expr \( `date --date "today" +%s` - `date --date "20190507" +%s` \) / 60 / 60 / 24



{0620} シェル内のコマンドはすべて一般ユーザで実行する
[1] 郵便番号検索APIを使用して、引数で「xxxxxxx」の形式で指定した郵便番号の住所を表示
zipcode=$1
curl http://zip.cgis.biz/csv/zip.php?zn=${zipcode} 2> /dev/null | nkf -wLu


[2] 路線/駅名検索APIを使用して、引数で指定した都道府県の路線を一覧表示
pref=$1
curl "http://express.heartrails.com/api/json?method=getLines&prefecture=${pref}" 2> /dev/null | jq '.response.line[]'


[3] 路線/駅名検索APIを使用して、引数で指定した路線の駅名を一覧表示
line=$1
curl "http://express.heartrails.com/api/json?method=getStations&line=${line}" 2> /dev/null | jq '.response.station[].name'


[4] 引数でしていたURLのページに外部リンク切れが無いかをチェックする
url=$1
curl ${url} | grep -o 'href="[^"]*"' | grep http | sed 's/^href=//' | awk '{print "curl -f",$1,"> /dev/null"}' | tee list | bash -e
