# Vpon AdMob Mediation Sample (Swift)

本專案展示了如何使用 **Vpon AdMob Mediation Adapter** 在 Swift 環境中整合 Vpon 廣告。

## 說明

*   **架構**：
    *   **Target: `VponAdmobSampleSwift`**：使用 **Swift Package Manager (SPM)** 管理依賴。
    *   **Target: `VponAdmobSampleSwiftPods`**：使用 **CocoaPods** 管理依賴。
*   **安全配置管理**：使用 `.xcconfig` 檔案隔離測試 ID 與正式 ID，

## 環境需求

*   **iOS 13.0+**
*   Xcode 15.0+
*   CocoaPods (若需測試 Pods 版本)

## 快速開始

### 1. 本地安全設定
為了保護正式的廣告 ID，專案使用了 `xcconfig` 機制。

1.  確認專案目錄下存在 `Config.xcconfig` (預設使用 Google 測試 ID)。
2.  建立或修改 **`Secrets.xcconfig`** (此檔案已被 `.gitignore` 排除)：
    ```text
    // 填入你的真實 ID (選填，若不填則自動回退至測試廣告)
    ADMOB_APP_ID = ca-app-pub-xxx~xxx
    AD_UNIT_ID_BANNER = ca-app-pub-xxx/xxx
    AD_UNIT_ID_INTERSTITIAL = ca-app-pub-xxx/xxx
    AD_UNIT_ID_NATIVE = ca-app-pub-xxx/xxx
    ```

### 2. 安裝依賴 (僅 Pods 版本需要)
若要執行 `VponAdmobSampleSwiftPods` Scheme，請先執行：
```bash
pod install
```

### 3. 執行與測試
在 Xcode 中選擇對應的 **Scheme**：
*   **`VponAdmobSampleSwift`**：測試 SPM 整合。
*   **`VponAdmobSampleSwiftPods`**：測試 CocoaPods 整合。

App 介面上方的 `Mode: Vpon-xxx` 標籤會顯示當前運行的模式。

## 廣告版位說明
目前支援以下格式：
*   **Banner** (橫幅廣告)
*   **Interstitial** (全螢幕插頁廣告)
*   **Native Ad** (原生廣告)

## 聯絡我們
如有任何問題，請聯繫 [Vpon SDK Support](mailto:sdk-support@vpon.com)。
