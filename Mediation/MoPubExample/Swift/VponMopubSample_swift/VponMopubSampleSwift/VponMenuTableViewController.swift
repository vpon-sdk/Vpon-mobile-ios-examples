//
//  VponMenuTableViewController.swift
//  VponDFPSampleSwift
//
//  Created by EricChien on 2017/6/12.
//  Copyright © 2017年 Soul. All rights reserved.
//

import UIKit

class VponMenuTableViewController: UITableViewController {
    
    let data = ["MoPub - Banner" : "goVponMopubBannerViewController",
                "MoPub - Interstitial" : "goVponMopubInterstitialViewController",
                "MoPub - Native" : "goVponMopubNativeViewController"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        let titles = Array(data.keys)
        cell.textLabel?.text = titles[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifiers = Array(data.values)
        self.performSegue(withIdentifier: identifiers[indexPath.row], sender: nil)
    }
}
