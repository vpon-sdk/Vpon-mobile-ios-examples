//
//  VponSdkBannerViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit

extension VponSdkBannerViewController : VpadnBannerDelegate {
    func onVpadnAdReceived(_ bannerView: UIView!) {
        self.loadBannerView.addSubview(bannerView)
        self.requestButton.isEnabled = true
    }
    
    func onVpadnAdFailed(_ bannerView: UIView!, didFailToReceiveAdWithError error: Error!) {
        print("Failed to receive banner with error: \(error.localizedDescription))")
        self.requestButton.isEnabled = true
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
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        if vpadnBanner != nil {
            vpadnBanner.getVpadnAdView()?.removeFromSuperview()
        }
        
        vpadnBanner = VpadnBanner.init(adSize: VpadnAdSizeFromCGSize(CGSize.init(width: loadBannerView.frame.size.width, height: loadBannerView.frame.size.height)), origin: CGPoint.zero)
        vpadnBanner.delegate = self
        vpadnBanner.rootViewController = self
        // TODO: set ad banner id
        vpadnBanner.strBannerId = ""
        vpadnBanner.platform = "TW"
        vpadnBanner.setAdAutoRefresh(true)
        vpadnBanner.startGetAd([])
    }

}
