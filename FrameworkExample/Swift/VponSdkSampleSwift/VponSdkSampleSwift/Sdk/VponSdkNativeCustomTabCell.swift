//
//  VponSdkNativeCustomTabCell.swift
//  VponSdkSampleSwift
//
//  Created by EricChien on 2017/10/3.
//  Copyright © 2017年 EricChien. All rights reserved.
//

import UIKit

import VpadnSDKAdKit

extension VponSdkNativeCustomTabCell : VpadnMediaViewDelegate {
    func mediaViewDidLoad(_ mediaView: VpadnMediaView) {
        print("mediaViewDidLoad");
    }
}


class VponSdkNativeCustomTabCell: UITableViewCell {

    @IBOutlet weak var adIcon: UIImageView!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adBody: UILabel!
    @IBOutlet weak var adSocialContext: UILabel!
    @IBOutlet weak var adAction: UIButton!
    @IBOutlet weak var adMediaView: VpadnMediaView!
    
    var nativeAd = VpadnNativeAd.init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        adAction.titleLabel?.minimumScaleFactor = 8.0/14.0;
        adAction.titleLabel?.adjustsFontSizeToFitWidth = true;
        
        adTitle.minimumScaleFactor = 12.0/14.0;
        adTitle.adjustsFontSizeToFitWidth = true;
        
        adSocialContext.minimumScaleFactor = 10.0/12.0;
        adSocialContext.adjustsFontSizeToFitWidth = true;
        
        adBody.minimumScaleFactor = 8.0/10.0;
        adBody.adjustsFontSizeToFitWidth = true;
    }
    
    public func setNativeAd(nativeAd : VpadnNativeAd) {
        
        if (self.nativeAd != nativeAd) {
            self.nativeAd.unregisterView()
        }
        self.nativeAd = nativeAd
        self.adIcon.image = nil
        
        self.nativeAd.icon.loadAsync { (image) in
            self.adIcon.image = image
        }
        
//        Original Method
//        self.nativeAd.coverImage.loadAsync { (image) in
//            self.adCoverMedia.image = image
//        }
        
//        New Method
        adMediaView.nativeAd = nativeAd
        adMediaView.delegate = self
        
        adTitle.text = self.nativeAd.title
        adBody.text = self.nativeAd.body
        adSocialContext.text = self.nativeAd.socialContext
        adAction.setTitle(self.nativeAd.callToAction, for: .normal)
        adAction.setTitle(self.nativeAd.callToAction, for: .highlighted)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
