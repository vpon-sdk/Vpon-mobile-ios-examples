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
    
    var gadInterstitialView : GADInterstitial!
    
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
        
        if gadInterstitialView != nil && gadInterstitialView.isReady {
            gadInterstitialView.present(fromRootViewController: self);
        } else {
            let request = GADRequest()
//            let extra = GADCustomEventExtras()
//            extra.setExtras(["contentURL":"https://www.vpon.com", "contentData": ["key1": "Admob", "key2": 1.2, "key3": true]], forLabel: "Vpon")
//            request.register(extra)
//            request.testDevices = [kGADSimulatorID]
            
// TODO: set ad unit id
            gadInterstitialView = GADInterstitial(adUnitID: "ca-app-pub-7987617251221645/3519729727")
            gadInterstitialView.delegate = self
            gadInterstitialView.load(request)
        }
    }
}

extension VponAdmobInterstitialViewController: GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Received interstitial ad successfully")
        actionButton.isEnabled = true
        actionButton.setTitle("show", for: .normal)
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive interstitail with error: \(error.localizedFailureReason!)")
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        print("Interstitial will present screen")
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Interstitial did fail to present screen")
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
        print("Interstitial will dismiss screen")
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("Interstitial did dismiss screen")
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        print("Interstitial will leave application")
    }
}
