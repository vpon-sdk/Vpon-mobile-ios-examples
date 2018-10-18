//
//  VpadnSdkVastCustomAdViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastCustomAdViewController: VpadnAdDelegate {
    func vpadnAdDidLoad(_ ad: VpadnAd) {
        guard let videoView = ad.videoView() else {
            return
        }
        
        videoLoadedView.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        videoLoadedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[videoView]-0-|", options: [], metrics: nil, views: ["videoView":videoView]))
        videoLoadedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[videoView]-0-|", options: [], metrics: nil, views: ["videoView":videoView]))
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

class VpadnSdkVastCustomAdViewController: UIViewController {

    @IBOutlet weak var videoLoadedView: UIView!
    
    var vpadnAd: VpadnAd!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - VastCustomAd"

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestVpadnAd()
    }
    
    func requestVpadnAd() {
        vpadnAd = VpadnAd.init(placementId: "", delegate: self)
        vpadnAd.load(withTestIdentifiers: [])
    }
}
