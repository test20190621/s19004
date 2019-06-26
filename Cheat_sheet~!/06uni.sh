{0604} シェル内のコマンドはすべて一般ユーザで実行する
[1] キーボードからファイルのパスを１つ入力して、その容量を表示
    但し、入力したパスが通常のファイルでない場合以下のエラーメッセージを表示
    入力したファイルパス: 通常のファイルではありません
if [ -f "$1" ]; then
    # duでファイル容量を求める
    du "$1"
else
    # エラーメッセージ
    echo "${1}: 通常のファイルではありません"
fi


[2] キーボードからファイルのパスを複数入力して、その容量を表示
    ファイル名のみ: ファイル容量
    但し、入力したパスが通常のファイルでない場合以下のエラーメッセージを表示
    入力したファイルパス: 通常のファイルではありません
for file in "$@"
do
    if [ -f "$1" ]; then
        # duでファイル容量を求める
         du "$file"
    else
        # エラーメッセージ
       echo "${file}: 通常のファイルではありません"
    fi
done


[3] 指定したディレクトリパス(サブディレクトリは含まない)の実行可能ファイルの一覧表示
    但し、入力したパスがディレクトリでない場合以下のエラーメッセージを表示
    入力したパス: ディレクトリではありません
if [ -d "$1" ]; then
        # ディレクトリ内のファイルが実行可能ファイルかチェックして
        # 実行可能ファイルであれば表示
    for file in $(find "$1" -maxdepth 1 -type f)
    do
        # fileが実行ファイルであれば表示
        # if [ -x "${1}/${file}" ] && [ ! -d "${1}/${file}" ]; then
        if [ -x "$file" ]; then
            # echo "$file"
            # echo `basename "$file"`
            echo $(basename "$file")
            # echo ls -l "${file}"
        fi
    done
else
    # エラーメッセージ
    echo "${1}: ディレクトリではありません"
fi


[4] 指定したディレクトリパス(サブディレクトリは含まない)の読み込みができないファイルの一覧表示
    但し、入力したパスがディレクトリでない場合以下のエラーメッセージを表示
    入力したパス: ディレクトリではありません
if [ -d "$1" ]; then
        # ディレクトリ内のファイルが読み込みできないファイルかチェックして
        #読み込みできないファイルの一覧表示
    for file in $(find "$1" -maxdepth 1 -type f)
    do
        if [ ! -r "$file" ]; then
            echo $(basename "$file")
        fi
    done
else
    # エラーメッセージ
    echo "${1}: ディレクトリではありません"
fi


[5] unix1.shの改造、case文を利用してgit add/commit/pushを個別に実行できるようにする
    git add -i
    git commit
    git push
    スクリプトの終了

#!/bin/bash

function cont() {
    echo -n 'continue?(y/n)'
    read yesno
    if [ $yesno = 'n' ]; then
        echo 'end...'
        exit
    fi
    echo 'continue...'
}
cd $HOME/rep/unix1/
git status
while :
do
    # git add/commit/pushの選択画面
    echo '1) git add -i'
    echo '2) git commit'
    echo '3) git push'
    echo '*) exit'
    echo '-n select?(1/2/3/*): '
    read select
    case "$select" in
    # git add -i 選択
    1)
        git add -i
        git status
        ;;
    # git commit 選択
    2)
        echo -n 'comment: '
        read comment
        git commit -m "$comment"
        git log --oneline
        ;;
    # git push 選択
    3)
        git push
        ;;
    *)
        echo 'end...'
        exit
        ;;
    esac
done



{0612}
[1] 060402.shのスクリプトで引数が指定されていない場合にヘルプを表示
    ファイル名は変更しない
    使い方: 060402.sh FILEPATH...
    FILEPATHで指定したファイルの容量を表示
    FILEPATH - 容量を求めるファイルのパスを指定、複数指定可


usage()
{
    local script_name=$(basename "$0")

    cat << END
使い方: 060402.sh FILEPATH...
FILEPATHで指定したファイルの容量を表示
FILEPATH - 容量を求めるファイルのパスを指定、複数指定可
END
}

for file in "$@"
do
    if [ -f "$1" ]; then
        # duでファイル容量を求める
         du "$file"
    else
        # エラーメッセージ
       echo "${file}: 通常のファイルではありません"
    fi
done


[2] 060403.shのスクリプトで引数が指定されていない場合にヘルプを表示
    ファイル名は変更しない
    使い方: 060403.sh DIRPATH
    DIRPATHで指定したディレクトリ下の実行可能ファイルの一覧表示
    DIRPATH - 実行可能ファイルの一覧表示を行うディレクトリパスを指定

usage()
{
    local script_name=$(basename "$0")

    cat << END
使い方: 060403.sh DIRPATH
DIRPATHで指定したディレクトリ下の実行可能ファイルの一覧表示
DIRPATH - 実行可能ファイルの一覧表示を行うディレクトリパスを指定
END
}

if [ -d "$1" ]; then
        # ディレクトリ内のファイルが実行可能ファイルかチェックして
        # 実行可能ファイルであれば表示
    for file in $(find "$1" -maxdepth 1 -type f)
    do
        # fileが実行ファイルであれば表示
        # if [ -x "${1}/${file}" ] && [ ! -d "${1}/${file}" ]; then
        if [ -x "$file" ]; then
            # echo "$file"
            # echo `basename "$file"`
            echo $(basename "$file")
            # echo ls -l "${file}"
        fi
    done
else
    # エラーメッセージ
    echo "${1}: ディレクトリではありません"
fi


[3] 060404.shのスクリプトで引数が指定されていない場合にヘルプを表示
    ファイル名は変更しない
    使い方: 060404.sh DIRPATH
    DIRPATHで指定したディレクトリ下の読み取り不可ファイルの一覧表示
    DIRPATH - 読み取り不可ファイルの一覧表示を行うディレクトリパスを指定

usage()
{
    local script_name=$(basename "$0")

    cat << END
使い方: 060404.sh DIRPATH
DIRPATHで指定したディレクトリ下の読み取り不可ファイルの一覧表示
DIRPATH - 読み取り不可ファイルの一覧表示を行うディレクトリパスを指定
END
}

if [ -d "$1" ]; then
        # ディレクトリ内のファイルが読み込みできないファイルかチェックして
        #読み込みできないファイルの一覧表示
    for file in $(find "$1" -maxdepth 1 -type f)
    do
        if [ ! -r "$file" ]; then
            echo $(basename "$file")
        fi
    done
else
    # エラーメッセージ
    echo "${1}: ディレクトリではありません"
fi

