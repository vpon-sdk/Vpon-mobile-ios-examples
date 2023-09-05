//
//  VponSdkNativeViewController.swift
//  VponSdkSampleSwift
//
//  Created by Yi-Hsiang, Chien on 2020/2/5.
//  Copyright © 2020 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit
import AdSupport

extension VponSdkNativeViewController: VpadnNativeAdDelegate, VpadnMediaViewDelegate {
    
    func onVpadnNativeAdLoaded(_ nativeAd: VpadnNativeAd) {
        self.requestButton.isEnabled = true
        self.setNativeAd()
    }
    
    func onVpadnNativeAd(_ nativeAd: VpadnNativeAd, failedToLoad error: Error) {
        self.requestButton.isEnabled = true
    }
    
    func onVpadnNativeAdClicked(_ nativeAd: VpadnNativeAd) {
        
    }
    
    func onVpadnNativeAdWillLeaveApplication(_ nativeAd: VpadnNativeAd) {
        
    }
    
    func mediaViewDidLoad(_ mediaView: VpadnMediaView) {
        
    }
    
    func mediaViewDidFail(_ mediaView: VpadnMediaView, error: Error) {
        
    }
    
}

class VponSdkNativeViewController: UIViewController {
    
    var vpadnNative: VpadnNativeAd!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var adIcon: UIImageView!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adBody: UILabel!
    @IBOutlet weak var adSocialContext: UILabel!
    @IBOutlet weak var adAction: UIButton!
    @IBOutlet weak var adMediaView: VpadnMediaView!
    
    @IBOutlet weak var requestButton: UIButton!

    override func viewDidLoad() {
        self.title = "SDK - Native"
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
        
        if (vpadnNative != nil) {
            vpadnNative.unregisterView()
        }
        
        vpadnNative = VpadnNativeAd(licenseKey: "")
        vpadnNative.delegate = self
        vpadnNative.loadRequest(initialRequest())
    }
    
    func setNativeAd() {
        adIcon.image = nil
            
        vpadnNative.icon?.loadImageAsync(withBlock: { image in
            self.adIcon.image = image
        })
        
        adMediaView.nativeAd = vpadnNative
        adMediaView.delegate = self
            
        adTitle.text = vpadnNative.title
        adBody.text = vpadnNative.body
        adSocialContext.text = vpadnNative.socialContext
        adAction.setTitle(vpadnNative.callToAction, for: .normal)
        adAction.setTitle(vpadnNative.callToAction, for: .highlighted)
        
        vpadnNative.registerViewForInteraction(contentView, withViewController: self)
    }
}
