//
//  VponSdkInterstitialViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit
import AdSupport

class VponSdkInterstitialViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var interstitial : VponInterstitialAd?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Interstitial"
        actionButtonDidTouch(actionButton)
    }
    
    // MARK: - Create VponAdRequest
    
    func createRequest() -> VponAdRequest {
        let request = VponAdRequest()
        request.setUserInfoGender(.male)                                                   // 性別
        request.setUserInfoBirthday(year: 2000, month: 08, day: 17)                        // 生日
        request.setContentUrl("https://www.google.com.tw/")                                // 內容
        request.setContentData(["key1": 1, "key2": true, "key3": "name", "key4": 123.31])  // 內容鍵值
        
        VponAdRequestConfiguration.shared.testDeviceIdentifiers = ([ASIdentifierManager.shared().advertisingIdentifier.uuidString]) // 取得測試廣告
        VponAdRequestConfiguration.shared.tagForChildDirectedTreatment = .notForChildDirectedTreatment // 是否專為兒童投放
        VponAdRequestConfiguration.shared.tagForUnderAgeOfConsent = .notForUnderAgeOfConsent // 是否專為特定年齡投放
        VponAdRequestConfiguration.shared.maxAdContentRating = .general // 最高可投放的年齡(分類)限制
        
        return request
    }
    
    // MARK: - Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        if let interstitial {
            interstitial.present(fromRootViewController: self)
        } else {
            VponInterstitialAd.load(licenseKey: "", request: createRequest()) { [weak self] (ad, error) in
                if let error {
                    print("Failed to load ad with error: \(error.localizedDescription)")
                    self?.actionButton.isEnabled = true
                    self?.actionButton.setTitle("request", for: .normal)
                    return
                }
                
                if let ad {
                    self?.interstitial = ad
                    self?.interstitial?.delegate = self
                    
                    self?.actionButton.isEnabled = true
                    self?.actionButton.setTitle("show", for: .normal)
                }
            }
        }
    }
}

// MARK: - VponFullScreenContentDelegate

extension VponSdkInterstitialViewController : VponFullScreenContentDelegate {
    func ad(_ ad: VponFullScreenContentAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("ad didFailToPresentFullScreenContentWithError \(error.localizedDescription)")
    }
    
    func adDidRecordClick(_ ad: VponFullScreenContentAd) {
        print("adDidRecordClick")
    }
    
    func adDidRecordImpression(_ ad: VponFullScreenContentAd) {
        print("adDidRecordImpression")
    }
    
    func adWillDismissScreen(_ ad: VponFullScreenContentAd) {
        print("adWillDismissScreen")
    }
    
    func adWillPresentScreen(_ ad: VponFullScreenContentAd) {
        print("adWillPresentScreen")
    }
    
    func adDidDismissScreen(_ ad: VponFullScreenContentAd) {
        print("adDidDismissScreen")
    }
}
