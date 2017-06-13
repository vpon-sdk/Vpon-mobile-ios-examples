//
//  ViewController.swift
//  VponFrameworkSample
//
//  Created by Mike Chou on 10/27/15.
//  Copyright © 2015 Vpon. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

class ViewController: UIViewController {
    
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var showInterstitialBtn: UIButton!
    
    private var bannerAd: VpadnBanner?
    private var interstitialAd: VpadnInterstitial?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Show the sdk version on the screen.
        self.versionLabel.text = VpadnBanner.getVersionVpadn()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController {
    // MARK:Custom Actions
    
    @IBAction private func showBannerAd(sender: AnyObject) {
        
        // create an CGPoint origin for the banner to show in the middle of the bannerView
        let screenWidth = UIScreen.mainScreen().bounds.width;
        let origin = CGPointMake((screenWidth - VpadnAdSizeBanner.size.width)/2.0, 0)
        
        // Set up bannerAd
        self.bannerAd = VpadnBanner.init(adSize: VpadnAdSizeBanner, origin: origin);
        self.bannerAd!.strBannerId = ""; // 填入您的BannerId
        self.bannerAd!.platform = "TW" // 台灣地區請填TW 大陸則填CN
        self.bannerAd!.delegate = self
        self.bannerAd!.setAdAutoRefresh(true)
        self.bannerAd!.rootViewController = self
        self.bannerView.addSubview(self.bannerAd!.getVpadnAdView())
        self.bannerAd!.startGetAd(getTestIdentifiers())
    }
    
    @IBAction func getInterstitialAd(sender: AnyObject) {
        
        // Set up interstitialAd
        self.interstitialAd = VpadnInterstitial.init()
        self.interstitialAd!.strBannerId = ""; // 填入您的Interstitial BannerId
        self.interstitialAd!.platform = "TW"  // 台灣地區請填TW 大陸則填CN
        self.interstitialAd!.delegate = self
        self.interstitialAd!.getInterstitial(getTestIdentifiers())
    }
    
    @IBAction func showInterstitialAd(sender: AnyObject) {
        
        // Show interstitialAd
        self.interstitialAd!.show()
        self.showInterstitialBtn.hidden = true
    }
    
    // 請新增此function到您的程式內 如果為測試用 則在下方填入UUID
    func getTestIdentifiers() -> [AnyObject] {
        let testIdentifiers: [AnyObject] = [] // add your test UUID as string
        return testIdentifiers
    }
}

extension ViewController: VpadnBannerDelegate {
    // MARK:VpadnBannerDelegate
    func onVpadnGetAd(bannerView: UIView!) {
        NSLog("開始抓取廣告");
    }
    
    func onVpadnAdReceived(bannerView: UIView!) {
        NSLog("廣告抓取成功");
    }
    
    func onVpadnAdFailed(bannerView: UIView!, didFailToReceiveAdWithError error: NSError!) {
        NSLog("廣告抓取失敗 %@", error);
    }
    
    func onVpadnDismiss(bannerView: UIView!) {
        NSLog("關閉vpadn廣告頁面 %@",bannerView);
    }
    
    func onVpadnLeaveApplication(bannerView: UIView!) {
        NSLog("離開publisher application");
    }
    
    func onVpadnPresent(bannerView: UIView!) {
        
        if bannerView == bannerAd!.getVpadnAdView() {
            NSLog("Banner 開啟vpadn廣告頁面 %d %@",bannerAd!.isInAppAD(), bannerView)
        } else {
            NSLog("Interstitial 開啟vpadn廣告頁面 %d %@",interstitialAd!.isInAppAD(), bannerView)
        }
    }
}

extension ViewController: VpadnInterstitialDelegate {
    // MARK:VpadnInterstitialDelegate
    func onVpadnInterstitialAdReceived(bannerView: UIView!) {
        NSLog("插屏廣告抓取成功");
        showInterstitialBtn.hidden = false;
    }
    
    func onVpadnInterstitialAdFailed(bannerView: UIView!) {
        NSLog("插屏廣告抓取失敗");
    }
    
    func onVpadnInterstitialAdDismiss(bannerView: UIView!) {
        NSLog("關閉插屏廣告頁面 %@",bannerView);
    }
}

