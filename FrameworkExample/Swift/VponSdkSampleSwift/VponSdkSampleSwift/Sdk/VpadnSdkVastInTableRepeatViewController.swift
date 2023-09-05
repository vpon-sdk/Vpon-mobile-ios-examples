//
//  VpadnSdkVastInTableRepeatViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastInTableRepeatViewController : VpadnInReadAdDelegate {
    func vpadnAdDidLoad(_ ad: VpadnInReadAd) {
        print("廣告抓取成功")
    }
    
    func vpadnInReadAd(_ ad: VpadnInReadAd, didFailLoading error: Error) {
        print("廣告抓取失敗:\(error.localizedDescription)")
    }
}

extension VpadnSdkVastInTableRepeatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = indexPath.row == 0 ? "ContentTabCell" : "PlaceholderTabCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
}

class VpadnSdkVastInTableRepeatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vpadnAd: VpadnInReadAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - VastInTableRepeat"
        requestVpadnAd()
    }
    
    func requestVpadnAd() {
        vpadnAd = VpadnInReadAd(placementId: "", insertionIndexPath: IndexPath.init(row: 5, section: 0), repeatMode: true, tableView: tableView, delegate: self)
        vpadnAd.loadAdWithTestIdentifiers([])
    }
}
