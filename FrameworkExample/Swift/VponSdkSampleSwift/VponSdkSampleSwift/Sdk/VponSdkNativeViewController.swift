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
    
    /// 通知有廣告可供拉取 call back
    func onVpadnNativeAdReceived(_ nativeAd: VpadnNativeAd) {
        self.requestButton.isEnabled = true
        self.setNativeAd()
    }
    
    /// 通知拉取廣告失敗 call back
    func onVpadnNativeAd(_ nativeAd: VpadnNativeAd, didFailToReceiveAdWithError error: Error) {
        self.requestButton.isEnabled = true
    }
    
    /// 通知廣告被點擊 call back
    func onVpadnNativeAdDidClicked(_ nativeAd: VpadnNativeAd) {
        
    }
    
    /// 通知離開publisher應用程式 call back
    func onVpadnNativeAdLeaveApplication(_ nativeAd: VpadnNativeAd) {
        
    }
    
    /// 多媒體素材讀取成功
    func mediaViewDidLoad(_ mediaView: VpadnMediaView) {
        
    }
    
    /// 多媒體素材讀取失敗
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
        request.addKeyword("keywordA")                                                              //關鍵字
        request.addKeyword("key1:value1")                                                           //鍵值
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
