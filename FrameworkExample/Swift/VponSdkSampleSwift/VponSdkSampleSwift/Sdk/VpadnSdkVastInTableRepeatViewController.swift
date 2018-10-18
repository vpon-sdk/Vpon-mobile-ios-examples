//
//  VpadnSdkVastInTableRepeatViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastInTableRepeatViewController : VpadnAdDelegate {
    func vpadnAdDidLoad(_ ad: VpadnAd) {
        print("廣告抓取成功")
    }
    
    func vpadnAd(_ ad: VpadnAd, didFailLoading error: Error) {
        print("廣告抓取失敗:\(error.localizedDescription)")
    }
    
    func vpadnAdDidStart(_ ad: VpadnAd) {
        print("影片開始播放")
    }
    
    func vpadnAdDidStop(_ ad: VpadnAd) {
        print("影片播放結束")
    }
    
    func vpadnAdDidMute(_ ad: VpadnAd) {
        print("影片靜音")
    }
    
    func vpadnAdDidUnmute(_ ad: VpadnAd) {
        print("影片取消靜音")
    }
    
    func vpadnAdWasClicked(_ ad: VpadnAd) {
        print("廣告被點擊")
    }
    
    func vpadnAdDidTakeOverFullScreen(_ ad: VpadnAd) {
        print("影片全屏")
    }
    
    func vpadnAdDidDismissFullscreen(_ ad: VpadnAd) {
        print("影片離開全貧")
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
    
    var vpadnAd: VpadnAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - VastInTableRepeat"
        requestVpadnAd()
    }
    
    func requestVpadnAd() {
        vpadnAd = VpadnAd.init(placementId: "", insertionIndexPath: IndexPath.init(row: 5, section: 0), repeatMode: true, tableView: tableView, delegate: self)
        vpadnAd.load(withTestIdentifiers: [])
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
