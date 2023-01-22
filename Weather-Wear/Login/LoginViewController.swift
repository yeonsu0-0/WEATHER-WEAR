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
    }
    
    @IBAction func kakaoLoginButtonTouchUpInside(_ sender: UIButton) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    _ = oauthToken
                    /// 로그인 관련 메소드 추가
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
                }
            }
        }}
}
