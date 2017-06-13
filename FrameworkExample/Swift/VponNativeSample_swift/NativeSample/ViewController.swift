//
//  ViewController.swift
//  NativeSample
//
//  Created by Mike Chou on 26/10/2016.
//  Copyright © 2016 Vpon. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

class ViewController: UIViewController {
    
    private var nativeAd: VpadnNativeAd?
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var adView: UIView!
    @IBOutlet weak var adIcon: UIImageView!
    @IBOutlet weak var adCoverMedia: UIImageView!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adBody: UILabel!
    @IBOutlet weak var adAction: UIButton!
    @IBOutlet weak var adSocialContext: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.versionLabel.text = String.init(format: "version: %@", VpadnBanner.getVersionVpadn())
    }

    @IBAction private func loadNativeAd(_ sender: AnyObject) {
        if let previousAd = self.nativeAd {
            self.removeAd(nativeAd: previousAd)
        }
        self.nativeAd = VpadnNativeAd.init(bannerID: "key in your native ad")
        self.nativeAd?.delegate = self
        self.nativeAd?.load(withTestIdentifiers: ["請填入手機的 IDFA"])
    }
    
    private func removeAd(nativeAd: VpadnNativeAd!) {
        nativeAd.unregisterView()
        nativeAd.delegate = nil
        self.adIcon.image = nil
        self.adCoverMedia.image = nil
        self.adView.isHidden = true
    }
}

extension ViewController: VpadnNativeAdDelegate {
    
    func onVpadnNativeAdReceived(_ nativeAd: VpadnNativeAd) {
        NSLog("VpadnNativeAd onVpadnNativeAdReceived")
        
        self.statusLabel.isHidden = true
        
        // icon
        weak var weakSelf = self
        nativeAd.icon.loadAsync { (image: UIImage?) in
            weakSelf?.adIcon.image = image
        }
        // media cover
        nativeAd.coverImage.loadAsync { (image: UIImage?) in
            weakSelf?.adCoverMedia.image = image
        }
        // text
        self.adTitle.text = nativeAd.title
        self.adBody.text = nativeAd.body
        self.adAction.isHidden = false
        self.adAction.setTitle(nativeAd.callToAction, for: .normal)
        self.adSocialContext.text = nativeAd.socialContext
        
        nativeAd.registerView(forInteraction: self.adView, with: self)
        self.adView.isHidden = false
    }
    
    func onVpadnNativeAd(_ nativeAd: VpadnNativeAd, didFailToReceiveAdWithError error: Error) {
        NSLog("VpadnNativeAd didFailToReceiveAdWithError: %@", error.localizedDescription)
        self.statusLabel.isHidden = false
        self.statusLabel.text = error.localizedDescription
    }
    
    func onVpadnNativeAdPresent(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Present %@", nativeAd);
    }
    
    func onVpadnNativeAdDismiss(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Dismiss %@", nativeAd)
    }
    
    func onVpadnNativeAdLeaveApplication(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Leave Application %@", nativeAd)
    }}

