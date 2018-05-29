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