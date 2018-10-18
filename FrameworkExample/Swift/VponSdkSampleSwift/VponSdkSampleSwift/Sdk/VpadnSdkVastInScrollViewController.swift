//
//  VpadnSdkVastInScrollViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastInScrollViewController : VpadnAdDelegate {
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

class VpadnSdkVastInScrollViewController: UIViewController {
    
    @IBOutlet weak var inScrollLoadedView: UIView!
    
    @IBOutlet weak var inScrollHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inScrollView: UIScrollView!
    
    var vpadnAd: VpadnAd!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - VastInScroll"

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestVpadnAd()
    }
    
    func requestVpadnAd() {
        vpadnAd = VpadnAd.init(placementId: "", placeholder: inScrollLoadedView, heightConstraint: inScrollHeightConstraint, scrollView: inScrollView, delegate: self)
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
