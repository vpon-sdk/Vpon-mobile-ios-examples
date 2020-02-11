//
//  VponSdkSplashViewController.swift
//  VponSdkSampleSwift
//
//  Created by Yi-Hsiang, Chien on 2020/2/5.
//  Copyright © 2020 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit
import AdSupport

extension VponSdkSplashViewController: VpadnSplashDelegate {
    func onVpadnSplashLoaded(_ vpadnSplash: VpadnSplash) {
        self.requestButton.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func onVpadnSplash(_ vpadnSplash: VpadnSplash, failedToLoad error: Error) {
        self.requestButton.isEnabled = true
    }
    
    func onVpadnSplashAllow(toClose vpadnSplash: VpadnSplash) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func onVpadnSplashWillLeaveApplication(_ vpadnSplash: VpadnSplash) {
        
    }
    
    func onVpadnSplashClicked(_ vpadnSplash: VpadnSplash) {
        
    }
}

class VponSdkSplashViewController: UIViewController {
    
    @IBOutlet weak var loadSplashView: UIView!
    
    var vpadnSplash: VpadnSplash!
    
    @IBOutlet weak var requestButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "SDK - Splash"
        requestButtonDidTouch(requestButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Initial VpadnAdRequest
    
    func initialRequest() -> VpadnAdRequest {
        let request = VpadnAdRequest.init()
        request.setTestDevices([ASIdentifierManager.shared().advertisingIdentifier.uuidString])     //取得測試廣告
        request.setUserInfoGender(.genderMale)                                                      //性別
        request.setUserInfoBirthdayWithYear(2000, month: 08, andDay: 17)                            //生日
        request.setMaxAdContentRating(.general)                                                     //最高可投放的年齡(分類)限制
        request.setTagForUnderAgeOfConsent(.false)                                                  //是否專為特定年齡投放
        request.setTagForChildDirectedTreatment(.false)                                             //是否專為兒童投放
        request.addKeyword("keywordA")                                                              //關鍵字
        request.addKeyword("key1:value1")                                                           //鍵值
        return request
    }
    
    // MARK: Button Method
    
    @IBAction func requestButtonDidTouch(_ sender: UIButton) {
        sender.isEnabled = false
        
        vpadnSplash = VpadnSplash.init(licenseKey: "8a80854b62d1fdc40162d205d0ff0005", target: loadSplashView)
        vpadnSplash.delegate = self
        vpadnSplash.setEndurableSecond(3)
        vpadnSplash.load(initialRequest())
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
