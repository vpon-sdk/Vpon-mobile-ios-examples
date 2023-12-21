//
//  VponSdkBannerViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit
import AdSupport

class VponSdkBannerViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var loadBannerView: UIView!

    var bannerView: VponBannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Banner"
        requestButtonDidTouch(requestButton)
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
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        if let bannerView {
            bannerView.removeFromSuperview()
        }
        
        bannerView = VponBannerView(adSize: .banner())
        bannerView?.licenseKey = ""
        bannerView?.delegate = self
        bannerView?.rootViewController = self
        bannerView?.autoRefresh = false // 僅限於 Banner
        bannerView?.load(createRequest())
    }
}

// MARK: - VponBannerViewDelegate

extension VponSdkBannerViewController: VponBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: VponBannerView) {
        // Invoked if receive Banner Ad successfully
        
        print("bannerViewDidReceiveAd")
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        loadBannerView.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.centerXAnchor.constraint(equalTo: loadBannerView.centerXAnchor),
            bannerView.centerYAnchor.constraint(equalTo: loadBannerView.centerYAnchor)
        ])
        self.requestButton.isEnabled = true
    }
    
    func bannerView(_ bannerView: VponBannerView, didFailToReceiveAdWithError error: Error) {
        // Invoked if received ad fail, check this callback to indicates what type of failure occurred

        print("bannerView didFailToReceiveAdWithError: \(error.localizedDescription)")
        self.requestButton.isEnabled = true
    }
    
    func bannerViewDidRecordImpression(_ bannerView: VponBannerView) {
        // Invoked if an impression has been recorded for an ad.
        
        print("bannerViewDidRecordImpression")
    }
    
    func bannerViewDidRecordClick(_ bannerView: VponBannerView) {
        // Invoked if an click has been recorded for an ad.
        
        print("bannerViewDidRecordClick")
    }
}
