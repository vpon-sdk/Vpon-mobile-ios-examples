//
//  VponMopubNativeViewController.swift
//  VponMopubSampleSwift
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit

import MoPub

class VponMopubNativeViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var loadNativeView: UIView!
    
    var mpNativeAd: MPNativeAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MoPub - Native"
        requestButtonDidTouch(requestButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        let settings = MPStaticNativeAdRendererSettings.init()
        settings.renderingViewClass = MPVponNativeAdView.classForCoder()
        
        let config = MPStaticNativeAdRenderer.rendererConfiguration(with: settings)!
        config.supportedCustomEvents = ["MPVponNativeCustomEvent"]
        
        // TODO: set ad unit id
        let adRequest = MPNativeAdRequest.init(adUnitIdentifier: "", rendererConfigurations: [config])!
        
        let targeting = MPNativeAdRequestTargeting.init()
        targeting.desiredAssets = NSSet.init(objects: kAdTitleKey, kAdTextKey, kAdCTATextKey, kAdIconImageKey, kAdMainImageKey, kAdStarRatingKey) as! Set<AnyHashable>
        
        adRequest.targeting = targeting
        adRequest.start { (request, response, error) in
            if error != nil {
                print("Failed to receive banner")
            } else {
                self.mpNativeAd = response
                self.mpNativeAd.delegate = self
                do {
                    let nativeAdView = try response?.retrieveAdView()
                    nativeAdView?.frame = self.loadNativeView.bounds
                    self.loadNativeView.addSubview(nativeAdView!)
                } catch {
                    print(error)
                }
            }
        }
    }
}

extension VponMopubNativeViewController: MPNativeAdDelegate {
    
    func willPresentModal(for nativeAd: MPNativeAd!) {
        print("will Present Modal For NativeAd");
    }
    
    func didDismissModal(for nativeAd: MPNativeAd!) {
        print("did Dismiss Modal For NativeAd")
    }
    
    func willLeaveApplication(from nativeAd: MPNativeAd!) {
        print("will Leave Application From NativeAd")
    }
    
    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
}
