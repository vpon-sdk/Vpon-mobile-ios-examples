//
//  VponMopubInterstitialViewController.swift
//  VponMopubSampleSwift
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit

import MoPub

class VponMopubInterstitialViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    
    var mpInterstitial : MPInterstitialAdController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Mopub - Interstitial"
        actionButtonDidTouch(actionButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func actionButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        if mpInterstitial != nil && mpInterstitial.ready {
            mpInterstitial.show(from: self)
        } else {
            // TODO: set ad unit id
            mpInterstitial = MPInterstitialAdController(forAdUnitId: "848bf4d03e7b4fdda02be232f8e6b4d1")
            mpInterstitial.localExtras = [
                "contentURL":"https://www.vpon.com",
                "contentData": ["key1": "Mopub", "key2": 1.2, "key3": true]
            ]
            mpInterstitial.delegate = self
            mpInterstitial.loadAd()
        }
    }
}

extension VponMopubInterstitialViewController: MPInterstitialAdControllerDelegate {
    
    func interstitialDidLoadAd(_ interstitial: MPInterstitialAdController) {
        print("Received interstitial ad successfully")
        actionButton.isEnabled = true
        actionButton.setTitle("show", for: .normal)
    }
    
    func interstitialDidFail(toLoadAd interstitial: MPInterstitialAdController) {
        print("Failed to receive interstitail")
        actionButton.isEnabled = true
        actionButton.setTitle("request", for: .normal)
    }
    
    func interstitialDidAppear(_ interstitial: MPInterstitialAdController) {
        print("Interstitial did present screen")
    }
    
    func interstitialDidDisappear(_ interstitial: MPInterstitialAdController) {
        print("Interstitial did dismiss screen")
    }
}
