# Razorpay-related keep rules
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }

-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**
