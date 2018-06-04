# gradle 常见错误及处理


```java
Gradle sync failed: Could not find builder.jar (com.android.tools.build:builder:3.1.2).
		Searched in the following locations:
		https://jcenter.bintray.com/com/android/tools/build/builder/3.1.2/builder-3.1.2.jar
		Consult IDE log for more details (Help | Show Log) (731ms)
```

连接 jcenter 库默认使用 https 协议，出现这个错，多数情况下都是因为连接失败了。
可以尝试将 `jcenter()` 改成默认使用 http 连接：  

``` js
jcenter {
    url "http://jcenter.bintray.com/"
}
```

## 代理导致的问题

Android开发中 可以设置代理的地方有三处：  
1. 操作系统设置的代理  
2. Android Studio -> File -> Settings -> Http Proxy  
3. Gradle 设置的代理 C:\Users\Administrator\\.gradle\gradle.properties

任何代理发生了问题，可以在这三处排查