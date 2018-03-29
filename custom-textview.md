首先在`/assets/font/`目录下添加字体文件  

然后在`/attrs.xml`加入自定义属性
  
```xml
<declare-styleable name="FontView">
    <attr name="fontStyle" format="enum">
        <enum name="regular" value="0" />
        <enum name="light" value="1"/>
        <enum name="thin" value="2" />
        <enum name="medium" value="3" />
        <enum name="bold" value="4" />
    </attr>
</declare-styleable>
```

自定义FontView:  

```java
public class FontView extends AppCompatTextView {
    private final static int REGULAR = 0;
    private final static int LIGHT = 1;
    private final static int THIN = 2;
    private final static int MEDIUM = 3;
    private final static int BOLD = 4;

    private static final SparseArray<String> fontMap = new SparseArray<>();

    static {
        fontMap.put(REGULAR, "font/Roboto-Regular.ttf");
        fontMap.put(LIGHT, "font/Roboto-Light.ttf");
        fontMap.put(THIN, "font/Roboto-Thin.ttf");
        fontMap.put(MEDIUM, "font/Roboto-Medium.ttf");
        fontMap.put(BOLD, "font/Roboto-Bold.ttf");
    }

    public FontView(Context context) {
        this(context, null);
    }

    public FontView(Context context, @Nullable AttributeSet attrs) {
        this(context, attrs, 0);
    }

    public FontView(Context context, AttributeSet attrs, int defStyleAttr) {
        super(context, attrs, defStyleAttr);

        TypedArray typedArray = context.obtainStyledAttributes(attrs, R.styleable.FontView);
        int fontStyle = typedArray.getInt(R.styleable.FontView_fontStyle, REGULAR);
        if (fontStyle >= 0) {
            Typeface typeface = Typeface.createFromAsset(context.getAssets(), fontMap.get(fontStyle));
            this.setTypeface(typeface);
        }

        typedArray.recycle();
    }
}
```
使用方法:
```xml
    <FontView
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="@string/strings"
        app:fontStyle="medium" />
```