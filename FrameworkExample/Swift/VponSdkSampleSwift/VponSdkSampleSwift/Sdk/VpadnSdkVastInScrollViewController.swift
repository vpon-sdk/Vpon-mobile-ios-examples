//
//  VpadnSdkVastInScrollViewController.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2018/9/20.
//  Copyright © 2018年 EricChien. All rights reserved.
//

import UIKit
import VpadnSDKAdKit

extension VpadnSdkVastInScrollViewController : VpadnInReadAdDelegate {
    func vpadnAdDidLoad(_ ad: VpadnInReadAd) {
        print("廣告抓取成功")
    }
    
    func vpadnInReadAd(_ ad: VpadnInReadAd, didFailLoading error: Error) {
        print("廣告抓取失敗:\(error.localizedDescription)")
    }
}

class VpadnSdkVastInScrollViewController: UIViewController {
    
    @IBOutlet weak var inScrollLoadedView: UIView!
    
    @IBOutlet weak var inScrollHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inScrollView: UIScrollView!
    
    var vpadnAd: VpadnInReadAd!

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
        vpadnAd = VpadnInReadAd(placementId: "", placeholder: inScrollLoadedView, heightConstraint: inScrollHeightConstraint, scrollView: inScrollView, delegate: self)
        vpadnAd.loadAdWithTestIdentifiers([])
    }
}
