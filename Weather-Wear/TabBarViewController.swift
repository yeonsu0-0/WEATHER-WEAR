//
//  TabBarViewController.swift
//  Weather-Wear
//
//  Created by yeonsu on 2023/01/25.
//

import UIKit

class TabBarViewController: UITabBarController {
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
}
