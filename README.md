# ros_roomba

## 事前準備
1. roomba と PCを繋ぐ
2. デバイス名を特定する `ls /dev/tty*` とかしながら抜き差ししてみる (ドキュメントは /dev/ttyACM0 として記述)
3. `sudo chmod a+rw /dev/ttyACM0` （無くてもよさそうだけど一応）
4. `sudo usermod -aG dialout $USER`
5. PC再起動

## docker ビルド＆実行
1. `docker build -t ros_roomba .`
2. `docker run -it --privileged ros_roomba bash` (これだとrvizとかは出ないので出したい場合は設定を変える必要あり) <br>
※ docker run 起動時に/dev/ttyACM0 (roombaのデバイス名[環境ごとに変わる])が認識されていないと <br>
docker側に共有されないので注意 docker内で/dev/ttyXXXを探してみてあればOK
3. /root/ros_ws/src/create_autonomy/create_bringup/config/default.yaml を開き devをroombaのデバイスに設定
4. roslaunch create_bringup create_1.launch <br>
ちなみに900番はcreate_1.launchで動く(https://qiita.com/minomonter/items/02c61aa3f23731fae4d4#fn3) <br>
自分の型番に合わせて起動スクリプトは変更
