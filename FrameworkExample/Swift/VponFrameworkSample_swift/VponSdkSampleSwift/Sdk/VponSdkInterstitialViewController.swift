//
//  VponSdkInterstitialViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit

extension VponSdkInterstitialViewController : VpadnInterstitialDelegate {
    func onVpadnInterstitialAdReceived(_ bannerView: UIView!) {
        print("Received interstitial ad successfully")
        actionButton.isEnabled = true
        actionButton.setTitle("show", for: .normal)
    }
    
    func onVpadnInterstitialAdFailed(_ bannerView: UIView!) {
        print("Failed to receive interstitail")
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
    }
    
    func onVpadnInterstitialAdDismiss(_ bannerView: UIView!) {
        print("Interstitial did dismiss screen")
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
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
    
    // MARK: Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        if vpadnInterstitial != nil && vpadnInterstitial.isReady() {
            vpadnInterstitial.show()
        } else {
            vpadnInterstitial = VpadnInterstitial.init()
            // TODO: set ad banner id
            vpadnInterstitial.strBannerId = ""
            vpadnInterstitial.platform = "TW"
            vpadnInterstitial.delegate = self
            vpadnInterstitial.setLocationOnOff(true)
            vpadnInterstitial.getInterstitial([])
        }
    }
}
