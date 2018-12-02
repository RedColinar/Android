# 1. 泛型通配符与PECS  

## 为什么要使用泛型通配符和边界  

List泛型转换需要用到通配符 `?`
```java
A extends B

// complie error
ArrayList<B> b = new ArrayList<A>();

```
_“装A的List”_ 无法转换成 _“装B的List”_  
所以，就算容器里装的东西之间有继承关系，但容器之间是没有继承关系的。  
为了让泛型用的更舒服， Sun的大脑袋们就想出了`<? extends T>` 和 `<? super T>`的方式， 让“装A的List” 转换成 “装B的List”  


```java
List<? extends B> list1 = new ArrayList<A>();
List<? super B> list2 = new ArrayList<A>();
```

在JAVA的泛型集合中，默认都可以添加null，除此以外，还有以下三条规则。

1. “?”不能添加元素
以“?”声明的集合，不能往此集合中添加元素，所以它只能作为生产者(亦即它只能被迭代)，如下：

```java
List<?> names = new ArrayList<>();
//  通配符声明的集合，获取的元素都是Object类型
List<Object> allNames = new ArrayList<>();
allNames.addAll(names);
//  只能以Object迭代元素
for(Object name: names) {
    System.out.println(name);
}
```

2. 上界通配符 “? extends T” 不能添加元素， 只能取
以“? extends T”声明的集合，不能往此集合中添加元素，所以它也只能作为生产者，如下： 

```java
List<? extends CharSequence> names = new ArrayList<String>();
// compile error
// add (capture<? extends java.lang.CharSequence>) in List 
// cannot be applied to (java.lang.String)
names.add("a");

List<CharSequence> allNames = new ArrayList<>();

allNames.addAll(names);
```

原因是编译器只知道容器内是 `String` 或者它的派生类，但具体是什么类型不知道。  
编译器在看到后面用`new ArrayList<String>()`赋值以后，List 的泛型并没有标上 String。而是标上一个占位符：CAP#1  —— capture<? extends java.lang.CharSequence>，  
来表示捕获一个`CharSequence`或`CharSequence`的子类，具体是什么类不知道，代号CAP#1。  
然后无论是想往里插入`String`或者`StringBuffer`或者`Spannable`编译器都不知道能不能和这个CAP#1匹配，所以就都不允许。  

这个集合存放的是`CharSequence`具体子类中的某一种, 而非只要是`CharSequence`的子类就可以放入.  
所以 `List<?>` 与`List<? extends Object>`是等价的， `List<?>` 也不能直接添加元素

“? extends T”迭代元素, 元素的添加需要在转换通配符之前完成：

```java
List<String> s = new ArrayList<>();
s.add("Hello");
s.add("World");
s.add("!");

List<? extends String> names = s;
for(String name: names) {
    System.out.println(name);
}
```

3. 下界通配符 “? super T” 可以往里存，但往外取只能放在`Object`对象里  
因为下界规定了元素的最小粒度的下限， 实际上是放松了容器元素的类型控制， 所以在取出元素时，所有元素只能被转换成所有类型的基类 `Object`  

```java
List<? super String> allNames = new ArrayList<>();
//
List<String> names = new ArrayList<>();
//  可以直接添加泛型元素
allNames.addAll(names);

//  也可以添加上界通配符泛型元素
List<? extends String> names1 = new ArrayList<>();
allNames.addAll(names1);

//  只能获取到Object类型
for(Object name: allNames) {
    System.out.println(name);
}
```
---  
**结论**  

JAVA泛型通配符的使用规则就是赫赫有名的“PECS”(Producer Extends, Consumer Super)  
（生产者使用“? extends T”通配符，消费者使用“? super T”通配符）。  

1. 如果想遍历collection，并对每一项元素操作时，此时这个集合是生产者（生产出可以操作的元素），应该使用 Collection<? extends Thing>.  
通俗的说：频繁往外读取内容的，适合用上界Extends。  
2. 如果你是想添加元素到collection中去，那么此时集合是消费者（消费元素就是添加元素），应该使用Collection<? super Thing>  
通俗的说：经常往里插入的，适合用下界Super。

# 2. 泛型方法   

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
 *     5) 而泛型类中的类型参数与泛型方法中的类型参数是没有相应的联系的，泛型方法始终以自己定义的类型参数为准。  
       6) 非泛型方法与类的泛型是统一的
 */
public <T> T genericMethod(Class<T> tClass)throws InstantiationException ,
  IllegalAccessException {
        T instance = tClass.newInstance();
        return instance;
}
/** 注意在静态泛型方法中， static 关键字在最前面 */
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
* E — Element，常用在java Collection里，如：List<E>, Iterator<E>, Set<E>
* K, V — Key，Value，代表Map的键值对
* N — Number，数字
* T — Type，类型，如String，Integer等等  

# 4. 内部类泛型

非静态内部类泛型与外围类泛型是统一的， 静态内部类的泛型与外围类无关  

# 5. 类型擦除  

泛型是 Java 1.5 版本才引进的概念，在这之前是没有泛型的概念的，但显然，泛型代码能够很好地和之前版本的代码很好地兼容。

这是因为，泛型信息只存在于代码编译阶段，在进入 JVM 之前，与泛型相关的信息会被擦除掉，专业术语叫做类型擦除  

通俗的说 List<String> 和 List<Integer> 编译后都是 List<Object>

---
_更多内容： https://blog.csdn.net/briblue/article/details/76736356_  
_https://www.zhihu.com/people/pang-pang-37-37/activities_  
