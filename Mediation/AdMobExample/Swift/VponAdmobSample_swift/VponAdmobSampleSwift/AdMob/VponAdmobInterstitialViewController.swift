//
//  VponAdmobInterstitialViewController.swift
//  VponAdmobSampleSwift
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VponAdmobInterstitialViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var interstitialAd : GADInterstitialAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Admob - Interstitial"
        actionButtonDidTouch(actionButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        let request = GADRequest()
//            let extra = GADExtras()
//            extra.additionalParameters = [
//                "contentURL":"https://www.vpon.com",
//                "contentData": ["key1": "Admob", "key2": 1.2, "key3": true]
//            ]
//            request.register(extra)
//            request.testDevices = [kGADSimulatorID]
        
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-7987617251221645/3519729727", request: request) { ad, error in
            if let error = error {
                self.actionButton.isEnabled = true
                print("Failed to receive interstitail with error: \(error.localizedDescription)")
            } else {
                self.interstitialAd = ad
                self.interstitialAd.fullScreenContentDelegate = self
                self.interstitialAd.present(fromRootViewController: self)
            }
        }
    }
}

extension VponAdmobInterstitialViewController: GADFullScreenContentDelegate {
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Interstitial did failed to present screen")
        actionButton.isEnabled = true
    }
    
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Interstitial did present screen")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Interstitial did dismiss screen")
        actionButton.isEnabled = true
    }
}
