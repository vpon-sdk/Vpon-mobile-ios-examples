# Vpon iOS Samples

English | [繁體中文](README.md)

Sample apps for the Vpon iOS SDK (VpadnSDK) and the AdMob mediation adapter.

| Folder | Contents |
|---|---|
| `FrameworkExample/` | VpadnSDK integration samples: banner, interstitial, native (Swift, Objective-C; VpadnSDK installed with CocoaPods) |
| `FundamentalExample/` | Basic VpadnSDK samples (Swift: banner, interstitial; Objective-C: also native and splash) |
| `DMP/` | DMP sample (Objective-C) |
| `Mediation/AdMobExample/` | AdMob mediation sample (Swift); see the README in that folder |
| `Mediation/flutterexample/` | Flutter sample (old, not maintained) |
| `Adapter/AdMobAdapter/` | Old binary adapter 2.1.5 for manual installation (no longer updated) |

VpadnSDK documentation: http://vpon-sdk.github.io/ios/

AdMob Adapter
===========================

Use the adapter to show Vpon ads through AdMob mediation. The adapter is distributed with Swift Package Manager:

- Package URL: https://github.com/vpon-sdk/AdMobMediationAdapterVpadn-iOS-SPM (installation, requirements and release notes are in that repository's README and Releases)
- AdMob mediation setup guide: https://wiki.vpon.com/ios/mediation/admob/

**Choosing a version**

- Apps with a minimum deployment target of iOS 16.0+: use **3.x** with the *Up to Next Major Version* rule starting at `3.0.0`. When moving from 2.2.x, change the rule yourself; 2.x is not moved to 3.x automatically.
- Apps that still support iOS 12–15: use **2.2.1**.
- Do not use 2.2.0 with Swift Package Manager: it can resolve to a VpadnSDK version that requires iOS 16.0 and fail to build.
- CocoaPods provides adapter **2.2.0** and VpadnSDK **5.8.0** as the last versions; later versions are available through Swift Package Manager only. When you switch to Swift Package Manager, move the Vpon adapter, VpadnSDK and the Google Mobile Ads SDK (and any other AdMob mediation adapters) together; do not mix them with CocoaPods.
- With Swift Package Manager, add `-ObjC` to **Other Linker Flags** of your app target.

Contact: fae@vpon.com

**Release history**

|Version|Requirements|Changes|
|----|----------------|----------------|
|3.0.0|Google-Mobile-Ads-SDK 12.x – 13.x, VpadnSDK 5.8.x (5.8.2 or later), iOS 16.0+ (SPM only)|Supports Google Mobile Ads SDK v13; minimum iOS raised to 16.0; fixes the VpadnSDK version reported to Google Mobile Ads|
|2.2.1|Google-Mobile-Ads-SDK 12.x, VpadnSDK 5.8.0 (SPM only)|Limits the VpadnSDK version range so it does not resolve to VpadnSDK versions that require iOS 16.0+; same code as 2.2.0|
|2.2.0|Google-Mobile-Ads-SDK 12.x (SPM), VpadnSDK 5.7.6+|Supports Google Mobile Ads SDK v12|
|2.1.5|Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.7.6+|Fixes ad callbacks not being called; fixes content data not being passed|
|2.1.1|Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.6.0+|Fixes interstitial callbacks not being called|
|2.1.0|Google-Mobile-Ads-SDK 10.14.0+, VpadnSDK 5.6.0+|Supports AdMob 10.0; rewritten in Swift|
|2.0.11|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.5.0+|Updates to the Swift version of VpadnSDK|
|2.0.9|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.2.0+|Fixes a rare crash inside the framework|
|2.0.8|Google-Mobile-Ads-SDK 9.2.0+, VpadnSDK 5.2.0+|Supports AdMob 9.0; distributed as an xcframework. Native: adds a CoverImage solution using GADNativeImage|
|2.0.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.2.0+|Supports LargeBanner 320x100|
|2.0.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|Fixes a thread blocking issue when downloading native icons|
|2.0.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|Fixes a banner request bug|
|2.0.2|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.7+|Supports passing FriendlyObstruction to VponSDK|
|2.0.1|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.1.1+|Supports passing extra data to VponSDK|
|2.0.0|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 5.0.2+|Uses the Vpon SDK 5.0.0 interface|
|1.1.5|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|Adjusts stopBeingDelegate to avoid a crash in removeFromSuperView caused by the BannerView class change in 4.9.4|
|1.1.4|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|The previous version was packaged with an Xcode 11 beta, which caused a reader issue when archiving; repackaged with an older Xcode|
|1.1.3|Google-Mobile-Ads-SDK 7.47.0+, VpadnSDK 4.9.1+|Fixes Call To Action not being tappable after the AdMob SDK custom event change; improves performance of some functions|
