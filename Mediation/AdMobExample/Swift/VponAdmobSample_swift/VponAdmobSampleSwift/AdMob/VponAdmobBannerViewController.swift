//
//  VponAdmobBannerViewController.swift
//  VponAdmobSampleSwift
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VponAdmobBannerViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var loadBannerView: UIView!
    
    var gadBannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Admob - Banner"
        requestButtonDidTouch(requestButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        if gadBannerView != nil {
            gadBannerView.removeFromSuperview()
        }
        
        let request = GADRequest()
//        let extra = GADExtras()
//        extra.additionalParameters = [
//            "contentURL":"https://www.vpon.com",
//            "contentData": ["key1": "Admob", "key2": 1.2, "key3": true],
//            "friendlyObstructions": [["view": UIView(), "purpose": 2, "desc": "not_visible"]]
//        ]
//        request.register(extra)
//        request.testDevices = [kGADSimulatorID]
        
        gadBannerView = GADBannerView(adSize: GADAdSizeFromCGSize(loadBannerView.frame.size))
// TODO: set ad unit id
        gadBannerView.adUnitID = "ca-app-pub-7987617251221645/3532457573"
        gadBannerView.delegate = self
        gadBannerView.rootViewController = self
        gadBannerView.load(request)
    }
    
}

extension VponAdmobBannerViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Received banner ad successfully")
        self.loadBannerView.addSubview(bannerView)
        self.requestButton.isEnabled = true
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive banner with error: \(error.localizedFailureReason!))")
        self.requestButton.isEnabled = true
    }
    
}
