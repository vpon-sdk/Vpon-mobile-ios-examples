//
//  VponMopubBannerViewController.swift
//  VponMopubSampleSwift
//
//  Created by EricChien on 2017/6/13.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit

import MoPub

extension VponMopubBannerViewController: MPAdViewDelegate {
    
    func viewControllerForPresentingModalView() -> UIViewController! {
        return self
    }
    
    func adViewDidLoadAd(_ view: MPAdView!) {
        print("Received banner ad successfully")
        self.loadBannerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let constrantX = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: [:], views: ["view": view])
        let constrantY = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: [:], views: ["view": view])
        self.loadBannerView.addConstraints(constrantX + constrantY)
        view.layoutIfNeeded()
        self.requestButton.isEnabled = true
    }
    
    func adViewDidFail(toLoadAd view: MPAdView!) {
        print("Failed to receive banner")
        self.requestButton.isEnabled = true
    }
    
    func willPresentModalView(forAd view: MPAdView!) {
        print("MoPub Banner will present screen")
    }
    
    func didDismissModalView(forAd view: MPAdView!) {
        print("MoPub Banner did dismiss")
    }
    
    func willLeaveApplication(fromAd view: MPAdView!) {
        print("MoPub Banner will leave publisher application")
    }
}

class VponMopubBannerViewController: UIViewController {
    
    @IBOutlet weak var requestButton: UIButton!
    
    @IBOutlet weak var loadBannerView: UIView!
    
    var mpBannerView: MPAdView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "MoPub - Banner"
        requestButtonDidTouch(requestButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        
        sender.isEnabled = false
        
        if mpBannerView != nil {
            mpBannerView.removeFromSuperview()
        }
        
        mpBannerView = MPAdView(adUnitId: "e036eb60cb694fe7b987f1af41a76eb9")
        mpBannerView.maxAdSize = loadBannerView.frame.size
        mpBannerView.localExtras = ["contentURL":"https://www.vpon.com", "contentData": ["key1": "Mopub", "key2": 1.2, "key3": true]]
        // TODO: set ad unit id
        mpBannerView.delegate = self
        mpBannerView.loadAd()
    }
    
}
