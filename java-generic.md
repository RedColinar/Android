# 1. 泛型通配符与PECS
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

1. 如果想遍历collection，并对每一项元素操作时，此时这个集合是生产者（生产出可以操作的元素），应该使用 Collection<? extends Thing>.  
2. 如果你是想添加元素到collection中去，那么此时集合是消费者（消费元素就是添加元素），应该使用Collection<? super Thing>  

# 2. 泛型方法 和 静态泛型方法  

```java
/**
 * 泛型方法的基本介绍
 * @param tClass 传入的泛型实参
 * @return T 返回值为T类型
 * 说明：
 *     1）public 与 返回值中间<T>非常重要，可以理解为声明此方法为泛型方法。
 *     2）只有声明了<T>的方法才是泛型方法，泛型类中的使用了泛型的成员方法并不是泛型方法。
 *     3）<T>表明该方法将使用泛型类型T，此时才可以在方法中使用泛型类型T。
 *     4）与泛型类的定义一样，此处T可以随便写为任意标识，常见的如T、E、K、V等形式的参数常用于表示泛型。
 */
public <T> T genericMethod(Class<T> tClass)throws InstantiationException ,
  IllegalAccessException {
        T instance = tClass.newInstance();
        return instance;
}
/** 注意 static 关键字在最前面 */
public static <T> T genericMethod(Class<T> tClass)throws InstantiationException , IllegalAccessException {
        T instance = tClass.newInstance();
        return instance;
}

```
# 3. 多泛型变量  

类泛型的多泛型变量  
```java
class MorePoint<T, U>{  
}  
```
方法泛型的多类型变量  
```java
public class Util {
    public static <K, V> void compare(Pair<K, V> p1, Pair<K, V> p2) {
        ...
    }
}
```

## 常见泛型字母表示
* E — Element，常用在java Collection里，如：List<E>,Iterator<E>,Set<E>
* K,V — Key，Value，代表Map的键值对
* N — Number，数字
* T — Type，类型，如String，Integer等等