//
//  CustomCell.swift
//  NativeSample
//
//  Created by Mike Chou on 26/10/2016.
//  Copyright © 2016 Vpon. All rights reserved.
//

import VpadnSDKAdKit
import UIKit

class CustomCell: UITableViewCell {
    
    @IBOutlet weak var adIcon: UIImageView!
    @IBOutlet weak var adTitle: UILabel!
    @IBOutlet weak var adBody: UILabel!
    @IBOutlet weak var adSocialContext: UILabel!
    @IBOutlet weak var adAction: UIButton!

    private var nativeAd: VpadnNativeAd?
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.adAction.titleLabel?.minimumScaleFactor = 8.0/14.0;
        self.adAction.titleLabel?.adjustsFontSizeToFitWidth = true;
        
        self.adTitle.minimumScaleFactor = 12.0/14.0;
        self.adTitle.adjustsFontSizeToFitWidth = true;
        
        self.adSocialContext.minimumScaleFactor = 10.0/12.0;
        self.adSocialContext.adjustsFontSizeToFitWidth = true;
        
        self.adBody.minimumScaleFactor = 8.0/10.0;
        self.adBody.adjustsFontSizeToFitWidth = true;
    }

    public func setNativeAd(nativeAd: VpadnNativeAd) {
        if self.nativeAd != nativeAd {
            self.nativeAd?.unregisterView()
        }
        
        self.nativeAd = nativeAd
        self.adIcon.image = nil
        
        weak var weakSelf = self
        self.nativeAd?.icon.loadAsync { (image: UIImage?) in
            weakSelf?.adIcon.image = image
        }
        self.adTitle.text = self.nativeAd?.title
        self.adBody.text = self.nativeAd?.body
        self.adSocialContext.text = self.nativeAd?.socialContext
        self.adAction.setTitle(self.nativeAd?.callToAction, for: .normal)
        self.adAction.setTitle(self.nativeAd?.callToAction, for: .highlighted)
    }
    
}
