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

extension VponSdkInterstitialViewController : VpadnInterstitialDelegate {
    func onVpadnInterstitialLoaded(_ interstitial: VpadnInterstitial) {
        actionButton.isEnabled = true
        actionButton.setTitle("show", for: .normal)
    }
    
    func onVpadnInterstitial(_ interstitial: VpadnInterstitial, failedToLoad error: Error) {
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
    }
    
    func onVpadnInterstitialWillOpen(_ interstitial: VpadnInterstitial) {
        
    }
    
    func onVpadnInterstitialClosed(_ interstitial: VpadnInterstitial) {
        
    }
    
    func onVpadnInterstitialClicked(_ interstitial: VpadnInterstitial) {
        
    }
    
    func onVpadnInterstitialWillLeaveApplication(_ interstitial: VpadnInterstitial) {
        
    }
}

class VponSdkInterstitialViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var vpadnInterstitial : VpadnInterstitial!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Interstitial"
        actionButtonDidTouch(actionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Initial VpadnAdRequest
    
    func initialRequest() -> VpadnAdRequest {
        let request = VpadnAdRequest.init()
        request.setTestDevices([ASIdentifierManager.shared().advertisingIdentifier.uuidString])     //取得測試廣告
        request.setUserInfoGender(.male)                                                            //性別
        request.setUserInfoBirthday(year: 2000, month: 08, day: 17)                                 //生日
        request.setTagFor(maxAdContentRating: .general)                                             //最高可投放的年齡(分類)限制
        request.setTagFor(underAgeOfConsent: .notForUnderAgeOfConsent)                              //是否專為特定年齡投放
        request.setTagFor(childDirectedTreatment: .notForChildDirectedTreatment)                    //是否專為兒童投放
        request.setContentUrl("https://www.google.com.tw/")                                         //內容
        request.setContentData(["key1": 1, "key2": true, "key3": "name", "key4": 123.31])           //內容鍵值
        return request
    }
    
    // MARK: Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        if vpadnInterstitial != nil && vpadnInterstitial.isReady() {
            vpadnInterstitial.showFromRootViewController(self)
        } else {
            vpadnInterstitial = VpadnInterstitial(licenseKey:"")
            vpadnInterstitial.delegate = self
            vpadnInterstitial.loadRequest(initialRequest())
        }
    }
}
