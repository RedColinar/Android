# adb 获取appPackage 和 appActivity  

`adb shell dumpsys window windows | grep -E 'mFocusedApp'`  

	
```
mFocusedApp=AppWindowToken{372f88d6 token=Token{3b7b14f1 ActivityRecord{20692498 u0 com.tencent.mm/.ui.LauncherUI t895}}}
```

```
'appPackage': 'com.tencent.mm',
'appActivity': '.ui.LauncherUI',
```