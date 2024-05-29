README
===========================

Admob Adapter
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|2.1.1|Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.6.0+|修復 Interstitial 相關 callback 未被觸發的問題|
|2.1.0|Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.6.0+|支援 Admob 10.0 版本且改用 Swift 撰寫|
|2.0.11|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.5.0+|更新 VpadnSDK 為 Swift 版本|
|2.0.9|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.2.0+|修復 Framework 內部低機率閃退的問題|
|2.0.8|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.2.0+|支援 Admob 9.0 版本且改以 xcFramework 方式提供。Admob Native 新增 CoverImage 使用 GADNativeImage 串接的解決方案。|
|2.0.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.2.0+|支援 LargeBanner 320x100。|
|2.0.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|修復 Native Icon下載時卡線程問題。|
|2.0.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|修復 Banner 請求的Bug。|
|2.0.2|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|支援 FriendlyObstruction 傳入 VponSDK 的功能。|
|2.0.1|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.1+|新增 Extra Data 傳入VponSDK 的功能。|
|2.0.0|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.0.2+|此版本使用 Vpon SDK 5.0.0 的 Interface。|
|1.1.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|因為 4.9.4 調整 BannerView 的 Class 造成 stopBeingDelegate removeFromSuperView 會 Crash 的問題，故調整 stopBeingDelegate 的實作。|
|1.1.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|前版使用 Xcode11-Beta，造成 Archive 會有 Reader 的問題，改以舊版 Xcode 封裝。|
|1.1.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|修復 Call To Action 因 AdmobSDK CustomEvent 調整而無法被點擊的問題。優化部分函式的執行效能。|

Smaato Plugin
===========================

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|1.0.0|SmaatoSDK 10+, VpadnSDK 5.0.2+|此版本使用Vpon SDK 5.0.0的Interface。|
