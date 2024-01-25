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

class VponSdkNativeViewController: UIViewController {
    
    var adLoader: VponNativeAdLoader? // Must keep a strong reference to VponNativeAdLoader during the ad loading process!
    
    @IBOutlet weak var adContainer: UIView!
    @IBOutlet weak var requestButton: UIButton!
    
    var nativeAdView: VponNativeAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Native"
        
        guard let nibObjects = Bundle.main.loadNibNamed("NativeAdView", owner: nil, options: nil),
              let adView = nibObjects.first as? VponNativeAdView else {
            fatalError("Could not load nib file for nativeAdView")
        }
        
        nativeAdView = adView
        adContainer.addSubview(adView)
        nativeAdView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            nativeAdView.widthAnchor.constraint(equalTo: adContainer.widthAnchor),
            nativeAdView.heightAnchor.constraint(equalTo: adContainer.heightAnchor)
        ])
        
        requestButtonDidTouch(requestButton)
    }
    
    // MARK: - Create VponAdRequest
    
    func createRequest() -> VponAdRequest {
        let request = VponAdRequest()
        request.setUserInfoGender(.male)                                                   // 性別
        request.setUserInfoBirthday(year: 2000, month: 08, day: 17)                        // 生日
        request.setContentUrl("https://www.google.com.tw/")                                // 內容
        request.setContentData(["key1": 1, "key2": true, "key3": "name", "key4": 123.31])  // 內容鍵值
        request.addFriendlyObstruction(UIView(), purpose: .mediaControls, description: "")
        
        VponAdRequestConfiguration.shared.testDeviceIdentifiers = ([ASIdentifierManager.shared().advertisingIdentifier.uuidString]) // 取得測試廣告
        VponAdRequestConfiguration.shared.tagForChildDirectedTreatment = .notForChildDirectedTreatment // 是否專為兒童投放
        VponAdRequestConfiguration.shared.tagForUnderAgeOfConsent = .notForUnderAgeOfConsent // 是否專為特定年齡投放
        VponAdRequestConfiguration.shared.maxAdContentRating = .general // 最高可投放的年齡(分類)限制
        
        return request
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        adLoader = VponNativeAdLoader(licenseKey: "", rootViewController: self)
        adLoader?.delegate = self
        adLoader?.load(createRequest())
    }
}

extension VponSdkNativeViewController: VponNativeAdLoaderDelegate {
    func adLoader(_ adLoader: VponNativeAdLoader, didReceive nativeAd: VponNativeAd) {
        self.requestButton.isEnabled = true
        
        nativeAd.delegate = self
        
        (nativeAdView.headlineView as? UILabel)?.text = nativeAd.headline
        (nativeAdView.bodyView as? UILabel)?.text = nativeAd.body
        (nativeAdView.callToActionView as? UIButton)?.setTitle(nativeAd.callToAction, for: .normal)
        (nativeAdView.iconView as? UIImageView)?.image = nativeAd.icon?.image
        nativeAdView.callToActionView?.isUserInteractionEnabled = false
        nativeAdView.mediaView?.mediaContent = nativeAd.mediaContent
        
        if nativeAd.mediaContent?.hasVideoContent ?? false {
            nativeAd.mediaContent?.videoController?.delegate = self
        }
        
        // Necessary to show media content and make it clickable!
        nativeAdView.nativeAd = nativeAd
    }
    
    func adLoader(_ adLoader: VponNativeAdLoader, didFailToReceiveAdWithError error: Error) {
        self.requestButton.isEnabled = true
        print("adLoader didFailToReceiveAdWithError \(error.localizedDescription)")
    }
}

extension VponSdkNativeViewController: VponNativeAdDelegate {
    func nativeAdDidRecordImpression(_ nativeAd: VponNativeAd) {
        print("nativeAdDidRecordImpression")
    }
    
    func nativeAdDidRecordClick(_ nativeAd: VponNativeAd) {
        print("nativeAdDidRecordClick")
    }
}

extension VponSdkNativeViewController: VponVideoControllerDelegate {
    func videoControllerDidPlayVideo(_ videoController: VponVideoController) {
        print("videoControllerDidPlayVideo")
    }
    
    func videoControllerDidPauseVideo(_ videoController: VponVideoController) {
        print("videoControllerDidPauseVideo")
    }
    
    func videoControllerDidEndVideoPlayback(_ videoController: VponVideoController) {
        print("videoControllerDidEndVideoPlayback")
    }
    
    func videoControllerDidMuteVideo(_ videoController: VponVideoController) {
        print("videoControllerDidMuteVideo")
    }
    
    func videoControllerDidUnmuteVideo(_ videoController: VponVideoController) {
        print("videoControllerDidUnmuteVideo")
    }
}
