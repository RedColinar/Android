# Java类加载机制  
类的生命周期是：加载->验证->**准备**->解析->**初始化**->使用->卸载，  
只有在**准备阶段**和**初始化阶段**才会涉及类变量的初始化和赋值  

```java
public class StaticTest {
    public static void main(String[] args) {
        staticFunction();
    }

    static StaticTest st = new StaticTest();

    // 静态代码块，如果static代码块有多个，JVM将按照它们在类中出现的先后顺序依次执行它们，每个代码块只会被执行一次
    static {
        System.out.println("1");
    }

    // 非静态代码块，在类new一个实例的时候执行，而且是每次new对象实例都会执行
    {
        System.out.println("2");
    }

    StaticTest() {
        System.out.println("3");
        System.out.println("a = " + a + ",b = " + b + ",c = " + c);
    }

    public static void staticFunction() {
        System.out.println("4");
    }

    int a = 110;
    static int b = 112;
    static final int c = 114;
}
```  

输出答案：  
```java  
2
3
a = 110,b = 0,c = 114
1
4
```  

类的准备阶段需要做是为类变量分配内存并设置默认值，因此类变量st为null、b为0；  
（需要注意的是如果类变量是`final`，编译时javac将会为value生成ConstantValue属性，在准备阶段虚拟机就会根据ConstantValue的设置将变量设置为指定的值，如果这里这么定义：static final int b=112,那么在准备阶段b的值就是112，而不再是0了。）  

  类的初始化阶段需要做是执行类构造器（**类构造器是编译器收集所有静态语句块和静态变量的赋值语句按语句在源码中的顺序合并生成类构造器，对象的构造方法是 `<init>()`，类的构造方法是 `<clinit>()`**），因此先执行第一条静态变量的赋值语句即 `st = new StaticTest ()`，此时会进行对象的初始化，**对象的初始化是先初始化成员变量和非静态代码块再执行构造方法**，因此设置a为110->打印2->执行构造方法(打印3,此时a已经赋值为110，但是b只是设置了默认值0，并未完成赋值动作)，等对象的初始化完成后继续执行之前的类构造器的语句，接下来就不详细说了，按照语句在源码中的顺序执行即可。  

## 实例初始化出现在静态初始化之前?  
这里面还牵涉到一个冷知识，就是在嵌套初始化时有一个特别的逻辑。特别是内嵌的这个变量恰好是个静态成员，而且是本类的实例。  
这会导致一个有趣的现象：“实例初始化竟然出现在静态初始化之前”。  
其实并没有提前，你要知道java记录初始化与否的时机。  
看一个简化的代码，把关键问题解释清楚：  

```java
public class Test {
    public static void main(String[] args) {
        func();
    }
    static Test st = new Test();
    static void func(){}
}
```

  根据上面的代码，有以下步骤：

首先在执行此段代码时，首先由main方法的调用触发静态初始化。  
在初始化Test 类的静态部分时，遇到st这个成员, 但凑巧这个变量引用的是本类的实例。  
那么问题来了，此时静态初始化过程还没完成就要初始化实例部分了。是这样么？  
从人的角度是的。但从java的角度，一旦开始初始化静态部分，无论是否完成，后续都不会再重新触发静态初始化流程了。  
因此在实例化st变量时，实际上是把实例初始化嵌入到了静态初始化流程中，并且在楼主的问题中，嵌入到了静态初始化的起始位置。这就导致了实例初始化完全至于静态初始化之前。这也是导致a有值b没值的原因。  

## 类不初始化的3种情况
1. 对于静态字段，只有直接定义这个字段的类才会被初始化，因此通过其子类来引用父类中定义的静态字段，只会触发父类的初始化而不会触发子类的初始化。  

```java
public class SSClass {
    static {
        System.out.println("SSClass");
    }
}

public class SuperClass extends SSClass {
    static {
        System.out.println("SuperClass init!");
    }
 
    public static int value = 123;
 
    public SuperClass() {
        System.out.println("init SuperClass");
    }
}

public class SubClass extends SuperClass {
    static {
        System.out.println("SubClass init");
    }
 
    static int a;
 
    public SubClass() {
        System.out.println("init SubClass");
    }
}

public class NotInitialization {
    public static void main(String[] args) {
        System.out.println(SubClass.value);
    }
}
```
输出：
```java
SSClass
SuperClass init!
123
```  
2. 通过数组定义来引用类，不会触发此类的初始化：

```java
public class NotInitialization {
    public static void main(String[] args) {
        SuperClass[] sca = new SuperClass[10];
    }
}
```  
输出：无  

3. 常量在编译阶段会存入调用类的常量池中，本质上并没有直接引用到定义常量的类，因此不会触发定义常量的类的初始化：  
```java 
public class ConstClass {
    static {
        System.out.println("ConstClass init!");
    }
    public static  final String HELLOWORLD = "hello world";
}

public class NotInitialization {
    public static void main(String[] args) {
        System.out.println(ConstClass.HELLOWORLD);
    }
}
```
输出：
```java 
hello world
```