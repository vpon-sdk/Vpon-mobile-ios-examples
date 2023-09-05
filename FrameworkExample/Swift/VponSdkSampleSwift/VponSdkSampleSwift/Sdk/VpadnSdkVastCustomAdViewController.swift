//
//  VpadnSdkVastCustomAdViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastCustomAdViewController : VpadnInReadAdDelegate {
    func vpadnAdDidLoad(_ ad: VpadnInReadAd) {
        print("廣告抓取成功")
        guard let videoView = ad.videoView() else {
            return
        }
        
        videoLoadedView.addSubview(videoView)
        videoView.translatesAutoresizingMaskIntoConstraints = false
        
        videoLoadedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[videoView]-0-|", options: [], metrics: nil, views: ["videoView":videoView]))
        videoLoadedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[videoView]-0-|", options: [], metrics: nil, views: ["videoView":videoView]))
    }
    
    func vpadnInReadAd(_ ad: VpadnInReadAd, didFailLoading error: Error) {
        print("廣告抓取失敗:\(error.localizedDescription)")
    }
}

class VpadnSdkVastCustomAdViewController: UIViewController {

    @IBOutlet weak var videoLoadedView: UIView!
    
    var vpadnAd: VpadnInReadAd!
    
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
        vpadnAd = VpadnInReadAd(placementId: "", delegate: self)
        vpadnAd.loadAdWithTestIdentifiers([])
    }
}
