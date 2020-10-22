//
//  VponAdmobBannerInTableViewController.swift
//  VponAdmobSampleSwift
//
//  Created by Yi-Hsiang, Chien on 2020/9/25.
//  Copyright © 2020 Soul. All rights reserved.
//

import UIKit
import GoogleMobileAds

extension VponAdmobBannerInTableViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == adPos {
            let cell = tableView.dequeueReusableCell(withIdentifier: "adReuseIdentifier", for: indexPath) as! AdTableViewCell
            if let banner = gadBannerView {
                cell.contentView.addSubview(banner)
                banner.center = cell.contentView.center
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
            cell.textLabel?.text = "Data \(indexPath.row + 1)"
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == adPos ? 250 : 44
    }
}

extension VponAdmobBannerInTableViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("Received banner ad successfully")
        mainTable.reloadRows(at: [IndexPath.init(row: adPos, section: 0)], with: .none)
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print("Failed to receive banner with error: \(error.description)")
    }
}

class VponAdmobBannerInTableViewController: UIViewController {
    
    @IBOutlet var mainTable: UITableView!
    
    var gadBannerView: GADBannerView?

    let adPos = 5
    let items = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBanner()
    }
    
    func addBanner() {
        let request = GADRequest()
//        let extra = GADExtras()
//        extra.additionalParameters = [
//            "contentURL":"https://www.vpon.com",
//            "contentData": ["key1": "Admob", "key2": 1.2, "key3": true],
//            "friendlyObstructions": [["view": UIView(), "purpose": 2, "desc": "not_visible"]]
//        ]
//        request.register(extra)
//        request.testDevices = [kGADSimulatorID]
        
        gadBannerView = GADBannerView(adSize: kGADAdSizeMediumRectangle)
// TODO: set ad unit id
        gadBannerView!.adUnitID = "ca-app-pub-7987617251221645/3532457573"
        gadBannerView!.delegate = self
        gadBannerView!.rootViewController = self
        gadBannerView!.load(request)
    }
}
