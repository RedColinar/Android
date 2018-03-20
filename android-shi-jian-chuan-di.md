说到touch事件的传递，首先想到touch事件的3个类型
ACTION_DOWN, ACTION_MOVE, ACTION_UP
其次想到touch事件传递的三个阶段
1. 分发（dispatch）
-> dispatchTouchEvent(MotionEvent ev)
2. 拦截（intercept）
-> onInterceptTouchEvent(MotionEvent ev)
3. 消费（consume）
-> onTouchEvent(MotionEvent ev)

Activity, ViewGroup, View 都有分发和消费的能力(dispatchTouchEvent & onTouchEvent)
同时只有 ViewGroup有拦截的能力(onInterceptTouchEvent)
view和viewGroup还有请求父ViewGroup跳过拦截的能力(parent.requestDisallowInterceptTouchEvent)

 W/TestTouchEventActivity: dispatchTouchEvent: 
 W/MyViewGroup: dispatchTouchEvent: 
 W/MyViewGroup: onInterceptTouchEvent: 
 W/FontView: dispatchTouchEvent: 
 W/FontView: onTouchEvent: 
 W/MyViewGroup: onTouch: 
 W/MyViewGroup: onTouchEvent: 

 W/TestTouchEventActivity: dispatchTouchEvent: 
 W/MyViewGroup: dispatchTouchEvent: 
 W/MyViewGroup: onClick: 
 W/MyViewGroup: onTouch: 
 W/MyViewGroup: onTouchEvent: 
 W/MyViewGroup: onClick: 