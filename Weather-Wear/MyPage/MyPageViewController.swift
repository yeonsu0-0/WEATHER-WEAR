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
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userId: UILabel!
    
    func setUserInfo() {
        UserApi.shared.me {(user, error) in
            if let error = error {
                print(error)
            } else {
                print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                print("email: \(user?.kakaoAccount?.email ?? "no email")")
                
                guard let userId = user?.id else {return}
                self.userName.text = "\(user?.kakaoAccount?.profile?.nickname ?? "no nickname")"
                self.userId.text = "\(user?.kakaoAccount?.email ?? "no nickname")"
            }
        }
    }
    
    // ================ < 로그아웃 > ================
    @IBAction func logoutButton(_ sender: Any) {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
                let viewController = UIStoryboard(name: "Login", bundle: nil)
                    .instantiateViewController(withIdentifier: "LoginVC")
                
                guard let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginViewController else { return }
                self.navigationController?.pushViewController(nextVC, animated: true)
                self.tabBarController?.tabBar.isHidden = true
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserInfo()
    }
}
