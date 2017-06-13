//
//  TableViewController.swift
//  NativeSample
//
//  Created by Mike Chou on 26/10/2016.
//  Copyright © 2016 Vpon. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

class TableViewController: UITableViewController {
    
    let kRowStrideForAdCell: Int = 3
    let kDefaultCellIdentifier = "normalIdentifier"
    let kAdCellIdentifier = "adIdentifier"
    
    public var adsManager: VpadnNativeAdsManager?
    public var ads: VpadnNativeAdTableViewAdProvider?
    
    // Lazy loading
    private lazy var tableViewContents: Array<String> =  {
        var contents: Array<String> = []
        for index in 1...1000 {
            contents.append(String.init(format: "TableView Cell #%d", index));
        }
        return contents
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create VpadnNativeAdsManager
        if self.adsManager == nil {
            self.adsManager = VpadnNativeAdsManager.init(bannerID: "key in your native ad", forNumAdsRequested: 5)
            self.adsManager?.delegate = self
        }
        self.adsManager?.loadAds(withTestIdentifiers: ["請填入手機的 IDFA"])
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 
        return self.ads?.adjustCount(self.tableViewContents.count, forStride: kRowStrideForAdCell) ?? self.tableViewContents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        /* Update Native ads manager
        if indexPath.row != 0 && indexPath.row % 20 == 0 {
            self.adsManager?.loadAds(withTestIdentifiers: ["請填入手機的 IDFA"])
        }
        */
        
        let cell: UITableViewCell
        if self.ads?.isAdCell(at: indexPath, forStride: kRowStrideForAdCell) ?? false {
            
            cell = tableView.dequeueReusableCell(withIdentifier: kAdCellIdentifier)!
            let ad: VpadnNativeAd = (self.ads?.tableView(tableView, nativeAdForRowAt: indexPath))!
            (cell as! CustomCell).setNativeAd(nativeAd: ad)
            ad.registerView(forInteraction: cell.contentView, with: self)
        } else {
            
            cell = tableView.dequeueReusableCell(withIdentifier: kDefaultCellIdentifier, for: indexPath)
            let index: IndexPath! = self.ads?.adjustNonAdCellIndexPath(indexPath, forStride: kRowStrideForAdCell) ?? indexPath
            cell.textLabel?.text = self.tableViewContents[index.row]
            cell.backgroundColor = UIColor.white
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewController: VpadnNativeAdsManagerDelegate, VpadnNativeAdDelegate {
    
    // MARK: - VpadnNativeAdsManagerDelegate
    func onVpadnNativeAdsReceived() {
        NSLog("Ads did loaded");
        
        if let manager = self.adsManager {
            NSLog("Unique count %d", manager.uniqueNativeAdCount);
            manager.delegate = nil
            self.ads = VpadnNativeAdTableViewAdProvider.init(manager: manager)
            self.ads?.delegate = self
        }
        self.tableView.reloadData()
    }
    
    func onVpadnNativeAdsFailedToLoadWithError(_ error: Error) {
        NSLog("Ads did fail with error %@", error.localizedDescription)
    }
    
    // MARK: - VpadnNativeAdDelegate
    func onVpadnNativeAdPresent(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Present %@", nativeAd);
    }
    
    func onVpadnNativeAdDismiss(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Dismiss %@", nativeAd)
    }
    
    func onVpadnNativeAdLeaveApplication(_ nativeAd: VpadnNativeAd) {
        NSLog("Native Leave Application %@", nativeAd)
    }
}
