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

extension VponSdkBannerViewController : VpadnBannerDelegate {
    func onVpadnAdLoaded(_ banner: VpadnBanner) {
        if let adView = banner.getVpadnAdView() {
            self.loadBannerView.addSubview(adView)            
        }
        self.requestButton.isEnabled = true
    }
    
    func onVpadnAd(_ banner: VpadnBanner, failedToLoad error: Error) {
        self.requestButton.isEnabled = true
    }
    
    func onVpadnAdClicked(_ banner: VpadnBanner) {
        
    }
    
    func onVpadnAdWillLeaveApplication(_ banner: VpadnBanner) {
        
    }
    
    func onVpadnAdRefreshed(_ banner: VpadnBanner) {
        
    }
}

class VponSdkBannerViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var loadBannerView: UIView!
    
    var vpadnBanner: VpadnBanner!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Banner"
        requestButtonDidTouch(requestButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Initial VpadnAdRequest
    
    func initialRequest() -> VpadnAdRequest {
        let request = VpadnAdRequest()
        request.setTestDevices([ASIdentifierManager.shared().advertisingIdentifier.uuidString])     //取得測試廣告
        request.autoRefresh = false                                                                 //僅限於 Banner
        request.setUserInfoGender(.unspecified)                                                     //性別
        request.setUserInfoBirthday(year: 2000, month: 1, day: 1)                                   //生日
        request.setTagFor(maxAdContentRating: .general)                                             //最高可投放的年齡(分類)限制
        request.setTagFor(underAgeOfConsent: .notForUnderAgeOfConsent)                              //是否專為特定年齡投放
        request.setTagFor(childDirectedTreatment: .notForChildDirectedTreatment)                    //是否專為兒童投放
        request.setContentUrl("https://www.google.com.tw/")                                         //內容
        request.setContentData(["key1": 1, "key2": true, "key3": "name", "key4": 123.31])           //內容鍵值
        return request
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        if vpadnBanner != nil {
            vpadnBanner.getVpadnAdView()?.removeFromSuperview()
        }
        
        vpadnBanner = VpadnBanner(licenseKey: "", adSize: .banner())
        vpadnBanner.delegate = self
        vpadnBanner.loadRequest(initialRequest())
    }

}
