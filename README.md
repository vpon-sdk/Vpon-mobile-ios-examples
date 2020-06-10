README
===========================

Admob Adapter
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|2.0.1|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.1+|新增Extra Data傳入VponSDK的功能。|
|2.0.0|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.0.2+|此版本使用Vpon SDK 5.0.0的Interface。|
|1.1.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|因為4.9.4調整BannerView的Class造成stopBeingDelegate removeFromSuperView會Crash的問題，故調整stopBeingDelegate的實作。|
|1.1.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|前版使用Xcode11-Beta，造成Archive會有Reader的問題，改以舊版Xcode封裝。|
|1.1.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|修復Call To Action因AdmobSDK CustomEvent調整而無法被點擊的問題。優化部分函式的執行效能。|

Mopub Custom Event
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|2.0.2|mopub-ios-sdk 5.10.0+, VpadnSDK 5.1.1+|新增LocalExtra傳入VponSDK的功能。|
|2.0.1|mopub-ios-sdk 5.10.0+, VpadnSDK 5.0.2+|調整Native registerViewForInteraction的邏輯，原因Mopub告知SDK Register的時候尚未加載至superview。|
|2.0.0|mopub-ios-sdk 5.10.0+, VpadnSDK 5.0.2+|此版本使用Vpon SDK 5.0.0的Interface。|

Smaato Plugin
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|1.0.0|SmaatoSDK 10+, VpadnSDK 5.0.2+|此版本使用Vpon SDK 5.0.0的Interface。|
