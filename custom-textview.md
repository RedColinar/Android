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