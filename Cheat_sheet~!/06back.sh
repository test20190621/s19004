{0613} シェル内のコマンドはすべて一般ユーザで実行する
       ログインユーザのホームディレクトリ以下(サブディレクトリを含む)をバックアップするスクリプト(backup.sh)
touch backup.sh


       tarコマンドでアーカイブ
       gzipで圧縮
tar czf backup.sh.tar.gz backup.sh


       /tmpディレクトリに作成
       アーカイブファイル名: home-yyyymmdd.tar.gz(yyyymmddは作成年月日)
       ホームディレクトリ直下のアーカイブから除外するファイル/ディレクトリ一覧(ex.cnf)を読み込む
 tar czf /tmp/home-`date '+%Y%m%d'`.tar.gz -X ~/ex.cnf "$HOME"

