README
===========================

Admob Adapter
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|1.1.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|因為4.9.4調整BannerView的Class造成stopBeingDelegate removeFromSuperView會Crash的問題，故調整stopBeingDelegate的實作。|
|1.1.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|前版使用Xcode11-Beta，造成Archive會有Reader的問題，改以舊版Xcode封裝。|
|1.1.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|修復Call To Action因AdmobSDK CustomEvent調整而無法被點擊的問題。優化部分函式的執行效能。|
===========================

Mopub Custom Event
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|2.0.0|mopub-ios-sdk 5.10.0+, VpadnSDK 5.0.0+|因為mopub custom event interface調整而調整|
