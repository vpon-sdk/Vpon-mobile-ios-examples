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
    
    func mediaViewDidFailed(_ mediaView: VpadnMediaView, error: Error) {
        
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
        
        if (vpadnNative != nil) {
            vpadnNative.unregisterView()
        }
        
        vpadnNative = VpadnNativeAd.init(licenseKey: "8a80854b6a90b5bc016ad81ac68c6530")
        vpadnNative.delegate = self
        vpadnNative.load(initialRequest())
    }
    
    func setNativeAd() {
        adIcon.image = nil
            
        vpadnNative.icon.loadAsync { (image) in
            self.adIcon.image = image
        }
        
        adMediaView.nativeAd = vpadnNative
        adMediaView.delegate = self
            
        adTitle.text = vpadnNative.title
        adBody.text = vpadnNative.body
        adSocialContext.text = vpadnNative.socialContext
        adAction.setTitle(vpadnNative.callToAction, for: .normal)
        adAction.setTitle(vpadnNative.callToAction, for: .highlighted)
        
        vpadnNative.registerView(forInteraction: contentView, with: self)
    }
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
