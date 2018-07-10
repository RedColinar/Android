# 布局中动态添加View

给 LinearLayout 中添加带有 `weight` 的view  
```java
    RelativeLayout relativeLayout = (RelativeLayout) LayoutInflater.from(this).inflate(R.layout.item_relativelayout, null);
    parentLinearLayout.addView(relativeLayout);
    LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(0, ViewGroup.LayoutParams.MATCH_PARENT, 1);
    // 这里的 1 是权重
    // layoutParams 不管是从View中获取的，还是 new 的，设置后都要重新 Set 给view，否则 layoutParams 会无效
    relativeLayout.setLayoutParams(params);
```