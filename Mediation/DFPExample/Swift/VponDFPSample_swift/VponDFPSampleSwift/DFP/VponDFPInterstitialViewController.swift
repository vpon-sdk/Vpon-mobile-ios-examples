//
//  VponDFPInterstitialViewController.swift
//  VponDFPSampleSwift
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit
import GoogleMobileAds

class VponDFPInterstitialViewController: UIViewController {

    @IBOutlet weak var actionButton: UIButton!
    
    var dfpInterstitialView : DFPInterstitial!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "DFP - Interstitial"
        actionButtonDidTouch(actionButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        if dfpInterstitialView != nil && dfpInterstitialView.isReady {
            dfpInterstitialView.present(fromRootViewController: self);
        } else {
            let request = GADRequest()
//            request.testDevices = [kGADSimulatorID]
            // TODO: set ad unit id
            dfpInterstitialView = DFPInterstitial.init(adUnitID: "")
            dfpInterstitialView.delegate = self
            dfpInterstitialView.load(request)
        }
    }
}

extension VponDFPInterstitialViewController: GADInterstitialDelegate {
    
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
