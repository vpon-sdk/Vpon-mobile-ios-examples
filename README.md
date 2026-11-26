# Vpon iOS 範例程式

[English](README.en.md) | 繁體中文

Vpon iOS SDK（VpadnSDK）與 AdMob 中介 adapter 的範例程式。

| 資料夾 | 內容 |
|---|---|
| `FrameworkExample/` | VpadnSDK 整合範例：Banner、插頁、Native（Swift、Objective-C；以 CocoaPods 安裝 VpadnSDK） |
| `Mediation/AdMobExample/` | AdMob 中介範例（Swift），說明見該資料夾的 README |
| `Mediation/flutterexample/` | Flutter 範例（舊版，未維護） |
| `Adapter/AdMobAdapter/` | 舊版 binary adapter 2.1.5（手動安裝用，已不再提供新版） |

VpadnSDK 文件：http://vpon-sdk.github.io/ios/

AdMob Adapter
===========================

透過 AdMob 中介（mediation）顯示 Vpon 廣告時使用。Adapter 以 Swift Package Manager 提供：

- 套件網址：https://github.com/vpon-sdk/AdMobMediationAdapterVpadn-iOS-SPM （安裝步驟、需求、版本說明見該 repo 的 README 與 Releases）
- AdMob 中介設定指南：https://wiki.vpon.com/ios/mediation/admob/

**選擇版本**

- App 最低支援 iOS 16.0 以上：使用 **3.x**，版本規則選 *Up to Next Major Version*、從 `3.0.0` 開始。從 2.2.x 升級時要手動改規則，2.x 不會自動升到 3.x。
- App 仍需支援 iOS 12–15：使用 **2.2.1**。
- 不要使用 2.2.0（Swift Package Manager）：可能解析到需要 iOS 16.0 的 VpadnSDK 版本而無法建置。
- CocoaPods 只提供到 adapter **2.2.0**、VpadnSDK **5.8.0**；之後的版本只提供 Swift Package Manager。改用 Swift Package Manager 時，請把 Vpon adapter、VpadnSDK、Google Mobile Ads SDK（以及其他聯播網的 AdMob 中介 adapter）一起改，不要和 CocoaPods 混用。
- 使用 Swift Package Manager 時，App Target 的 **Other Linker Flags** 要加入 `-ObjC`。

問題聯絡：fae@vpon.com

**版本紀錄**

|版本號碼|版本限制|改版紀錄|
|----|----------------|----------------|
|3.0.0|Google-Mobile-Ads-SDK 12.x – 13.x, VpadnSDK 5.8.x（5.8.2 以上）, iOS 16.0+（僅提供 SPM）|支援 Google Mobile Ads SDK v13；最低 iOS 提高到 16.0；修正回報給 Google Mobile Ads 的 VpadnSDK 版本|
|2.2.1|Google-Mobile-Ads-SDK 12.x, VpadnSDK 5.8.0（僅提供 SPM）|限制 VpadnSDK 的版本範圍，避免解析到需要 iOS 16.0 以上的 VpadnSDK 版本；程式碼與 2.2.0 相同|
|2.2.0|Google-Mobile-Ads-SDK 12.x（SPM）, VpadnSDK 5.7.6+|支援 Google Mobile Ads SDK v12|
| 2.1.5    | Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.7.6+ | 修復廣告 callback 未被觸發的問題；修復 content data 未傳入的問題。 |
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
