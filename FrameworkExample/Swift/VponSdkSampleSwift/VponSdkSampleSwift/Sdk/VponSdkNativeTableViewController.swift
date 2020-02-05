//
//  VponSdkNativeTableViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit
import AdSupport

let kRequestNumber = 5;
let kRowStrideForAdCell = 10;
let kDefaultCellIdentifier = "normalIdentifier";
let kAdCellIdentifier = "adIdentifier";

extension VponSdkNativeTableViewController: VpadnNativeAdsManagerDelegate {
    func onVpadnNativeAdsReceived() {
        tableView.reloadData()
    }
    
    func onVpadnNativeAdsFailedToLoadWithError(_ error: Error) {
        print("Ads did fail with error \(error.localizedDescription)")
    }
}

extension VponSdkNativeTableViewController: VpadnNativeAdDelegate {
    func onVpadnNativeGet(_ nativeAd: VpadnNativeAd) {
        
    }
    
    func onVpadnNativeAdPresent(_ nativeAd: VpadnNativeAd) {
        print("Native Present \(nativeAd)")
    }
    
    func onVpadnNativeAdLeaveApplication(_ nativeAd: VpadnNativeAd) {
        print("Native Leave Application \(nativeAd)")
    }
    
    func onVpadnNativeAdDismiss(_ nativeAd: VpadnNativeAd) {
        print("Native Dismiss \(nativeAd)")
    }
}

class VponSdkNativeTableViewController: UITableViewController {

    var adsManager : VpadnNativeAdsManager!
    var adsProvider : VpadnNativeAdTableViewAdProvider!
    var tableViewContents = [] as Array
    
    func addContents() {
        tableViewContents = []
        for index in 1...1000 {
            tableViewContents.append("TableView Cell \(index)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        addContents()
        request()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Initial VpadnAdRequest
    
    func initialRequest() -> VpadnAdRequest {
        let request = VpadnAdRequest.init()
        request.setTestDevices([ASIdentifierManager.shared().advertisingIdentifier.uuidString])     //取得測試廣告
        request.setAutoRefresh(true)                                                                //僅限於 Banner
        request.setUserInfoGender(.genderMale)                                                      //性別
        request.setUserInfoBirthdayWithYear(2000, month: 08, andDay: 17)                            //生日
        request.setMaxAdContentRating(.general)                                                     //最高可投放的年齡(分類)限制
        request.setTagForUnderAgeOfConsent(.false)                                                  //是否專為特定年齡投放
        request.setTagForChildDirectedTreatment(.false)                                             //是否專為兒童投放
        request.addKeyword("keywordA")                                                              //關鍵字
        request.addKeyword("key1:value1")                                                           //鍵值
        return request
    }
    
    func request() {
        if adsManager == nil {
            // TODO: set ad native id
            adsManager = VpadnNativeAdsManager.init(licenseKey: "8a80854b6a90b5bc016ad81ac68c6530", forNumAdsRequested: UInt(kRequestNumber))
            adsManager.delegate = self
            adsProvider = VpadnNativeAdTableViewAdProvider.init(manager: adsManager)
            adsProvider.delegate = self
        }
        adsManager.load(initialRequest())
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewContents.count + tableViewContents.count / kRowStrideForAdCell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if adsManager.isReady() && indexPath.row > 0 && indexPath.row % kRowStrideForAdCell == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: kAdCellIdentifier, for: indexPath) as! VponSdkNativeCustomTabCell
            let nativeAd = adsProvider.tableView(tableView, nativeAdForRowAt: indexPath)
            cell.setNativeAd(nativeAd: nativeAd)
            nativeAd.registerView(forInteraction: cell.contentView, with: self)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: kDefaultCellIdentifier, for: indexPath)
        let index = indexPath.row - indexPath.row / kRowStrideForAdCell
        cell.textLabel?.text = tableViewContents[index] as? String
        cell.backgroundColor = UIColor.white
        return cell
    }
}
