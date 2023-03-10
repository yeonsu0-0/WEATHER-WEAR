//
//  LoginViewController.swift
//  Weather-Wear
//
//  Created by yeonsu on 2023/01/22.
//

import UIKit
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth


class LoginViewController:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    // =============== < 카카오톡 로그인 > ===============
    @IBAction func kakaoLoginButtonTouchUpInside(_ sender: UIButton) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    _ = oauthToken
                    // 로그인 관련 메소드 추가
                    // 메인 화면으로 스토리보드 전환
                }
            }
        } else {
            
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    _ = oauthToken
                    // 관련 메소드 추가
                    // 파일 불러오기
                    let viewController = UIStoryboard(name: "TabBar", bundle: nil)
                        .instantiateViewController(withIdentifier: "TabBarViewController")
                    
                    guard let nextVC = viewController.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController else { return }
                    self.navigationController?.pushViewController(nextVC, animated: true)

                }
            }
        }
    }
}
    // ==================================================
