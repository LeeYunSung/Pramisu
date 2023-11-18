//
//  WelcomeViewController.swift
//  Pramisu
//
//  Created by Kyowon on 2023/09/21.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth


class WellcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginWithKakao(_ sender: UIButton) {

        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                   // _ = oauthToken
                    
                    UserApi.shared.me { kakaoUser, error in
                        if let error = error {
                            print("------KAKAO : user loading failed------")
                            print(error)
                        } else {
                            Auth.auth().createUser(withEmail: (kakaoUser?.kakaoAccount?.email)!, password: "\(String(describing: kakaoUser?.id))") { fuser, error in
                                if let error = error {
                                    print("FB : signup failed")
                                    print(error)
                                    Auth.auth().signIn(withEmail: (kakaoUser?.kakaoAccount?.email)!, password: "\(String(describing: kakaoUser?.id))", completion: nil)
                                } else {
                                    print("FB : signup success")
                                    self.performSegue(withIdentifier: "goToResult", sender: kakaoUser?.kakaoAccount?.email)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSignUp" {
            var destinationVC = segue.destination as! SignUpViewController
            let kakaokUserId = sender as! String
            destinationVC.userId = kakaokUserId
        }
    }
    
    @IBAction func backPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

