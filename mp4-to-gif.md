# 用adb截屏和录制

| 命令 | 功能 |
| :---  :--- |
| adb shell screencap –p path/file | 手机截图 |  
| adb shell screenrecord [options] | 屏幕录像 |  

在cmd或powershell下路径前加`/`，用MINGW64不加`/`  
C:\Users\Administrator>adb shell screenrecord --size 320x480 /sdcard/s1.mp4  
^C

拷贝到电脑  
adb pull /sdcard/s1.mp4 C:\Users\Administrator\Desktop

转换gif  
./ffmpeg.exe -i D:\bear.wmv D:\a.gif -s 320x480

[下载ffmpeg](http://ffmpeg.org/)  
