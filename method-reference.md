# 方法引用

| 方法引用 | 对应的lambda表达式 |
| :--- | :--- |
| String::valueOf | x -> String.valueOf(x) |
| Object::toString | x -> x.toString() |
| x::toString | () -> x.toString() |
| ArrayList::new | () -> new ArrayList<>() |