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
        self.loadBannerView.addSubview(banner.getVpadnAdView())
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
        let request = VpadnAdRequest.init()
        request.setTestDevices([ASIdentifierManager.shared().advertisingIdentifier.uuidString])     //取得測試廣告
        request.setAutoRefresh(true)                                                                //僅限於 Banner
        request.setUserInfoGender(.genderMale)                                                      //性別
        request.setUserInfoBirthdayWithYear(2000, month: 08, andDay: 17)                            //生日
        request.setMaxAdContentRating(.general)                                                     //最高可投放的年齡(分類)限制
        request.setTagForUnderAgeOfConsent(.false)                                                  //是否專為特定年齡投放
        request.setTagForChildDirectedTreatment(.false)                                             //是否專為兒童投放
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
        
        vpadnBanner = VpadnBanner.init(licenseKey: "8a80854b6a90b5bc016ad81a5059652d", adSize: VpadnAdSizeSmartBannerPortrait)
        vpadnBanner.delegate = self
        vpadnBanner.load(initialRequest())
    }

}
