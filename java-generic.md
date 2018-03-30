List泛型转换需要用到通配符 `?`
```java
A implements Group

List<? extends Group> list = new ArrayList<A>();
List<? super Group> list = new ArrayList<A>();
```

在JAVA的泛型集合中，默认都可以添加null，除此以外，还有以下三条规则。

1. “?”不能添加元素
以“?”声明的集合，不能往此集合中添加元素，所以它只能作为生产者(亦即它只能被迭代)，如下：

```java
List<?> names = Lists.newArrayList("");
//  通配符声明的集合，获取的元素都是Object类型
List<Object> allNames = Lists.newArrayList("");
allNames.addAll(names);
//  只能以Object迭代元素
for(Object name: names) {
    System.out.println(name);
}
```

2. “? extends T”也不能添加元素
以“? extends T”声明的集合，不能往此集合中添加元素，所以它也只能作为生产者，如下：

```java
List<? extends String> names = Lists.newArrayList("");
//  声明消费者
List<String> allNames = Lists.newArrayList("");
//  消费生产者的元素
allNames.addAll(allNames);
```

相对于以“?”声明的集合，“? extends T”能更轻松地迭代元素：

```java
List<? extends String> names = Lists.newArrayList("");
//  能更精确地确认元素类型
for(String name: names) {
    System.out.println(name);
}
```

3. “? super T”能添加元素
在通配符的表达式中，只有“? super T”能添加元素，所以它能作为消费者（消费其他通配符集合）。
```java
List<? super String> allNames = Lists.newArrayList("");
//
List<String> names = Lists.newArrayList("");
//  可以直接添加泛型元素
allNames.addAll(names);
//  也可以添加通配符泛型元素
List<? extends String> names1 = Lists.newArrayList("");
allNames.addAll(names1);
```

针对采用“? super T”通配符的集合，对其遍历时需要多一次转型，如下：

//  只能获取到Object类型  
```java
for(Object name: allNames) {
    //  这里需要一次转型
    System.out.println(name);
}
```

结论
JAVA泛型通配符的使用规则就是赫赫有名的“PECS”(Producer Extends, Consumer Super)  
（生产者使用“? extends T”通配符，消费者使用“? super T”通配符）。