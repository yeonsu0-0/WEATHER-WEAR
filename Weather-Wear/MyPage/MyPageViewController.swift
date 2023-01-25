//
//  MyPageViewController.swift
//  Weather-Wear
//
//  Created by yeonsu on 2023/01/22.
//

import UIKit
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth

class MyPageViewController:UIViewController {
    
    @IBAction func logoutButton(_ sender: Any) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
