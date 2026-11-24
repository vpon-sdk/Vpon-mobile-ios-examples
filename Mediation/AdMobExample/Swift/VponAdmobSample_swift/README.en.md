# Vpon AdMob Mediation Sample (Swift)

English | [繁體中文](README.md)

This project shows how to integrate Vpon ads in Swift with the **Vpon AdMob Mediation Adapter**.

## Overview

*   **Targets**:
    *   **Target: `VponAdmobSampleSwift`**: dependencies managed with **Swift Package Manager (SPM)** (Adapter 3.0.0).
    *   **Target: `VponAdmobSampleSwiftPods`**: dependencies managed with **CocoaPods**.
        *   CocoaPods provides the adapter up to **2.2.0** (the last version); 2.2.1 and later are SPM only. This target is kept as a reference for CocoaPods 2.2.0; use SPM (`VponAdmobSampleSwift`) for new integrations.
*   **Configuration**: `.xcconfig` files keep test IDs and production IDs apart.

## Requirements

*   **iOS 16.0+** (SPM target, Adapter 3.0.0); **iOS 13.0+** (Pods target, Adapter 2.2.0)
*   Xcode: this project has been built with Xcode 27.2
*   CocoaPods (only for the Pods target)

## Getting started

### 1. Local configuration
The project uses `xcconfig` files to keep production ad IDs out of the repository.

1.  `Config.xcconfig` in the project folder uses Google test IDs by default.
2.  Create or edit **`Secrets.xcconfig`** (excluded by `.gitignore`):
    ```text
    // Your production IDs (optional; test ads are used if omitted)
    ADMOB_APP_ID = ca-app-pub-xxx~xxx
    AD_UNIT_ID_BANNER = ca-app-pub-xxx/xxx
    AD_UNIT_ID_INTERSTITIAL = ca-app-pub-xxx/xxx
    AD_UNIT_ID_NATIVE = ca-app-pub-xxx/xxx
    ```

### 2. Install dependencies (Pods target only)
Before running the `VponAdmobSamplePods` scheme, run:
```bash
pod install
```

### 3. Run
Choose a **scheme** in Xcode:
*   **`VponAdmobSampleSwift`**: SPM integration.
*   **`VponAdmobSamplePods`**: CocoaPods integration.

The `Mode: Vpon-xxx` label at the top of the app shows which mode is running.

## Notes

### 1. Linker flag (`-ObjC`)
When integrating the Vpon SDK with **SPM**, add **`-ObjC`** to the target's `Other Linker Flags`.
*   **Why**: the Vpon SDK contains Objective-C categories; without this flag the app crashes at runtime because methods cannot be found.
*   **In this project**: already set for the `VponAdmobSampleSwift` target.

### 2. Avoid duplicate symbols
Do not install the same SDK (for example VpadnSDK or GoogleMobileAds) with both SPM and CocoaPods in one project.
*   **Recommendation**: when moving to SPM, move all related dependencies together to avoid `duplicate-symbol` build errors.

## Ad formats
*   **Banner**
*   **Interstitial**
*   **Native Ad**

## Contact
For questions, contact [Vpon SDK Support](mailto:fae@vpon.com).
