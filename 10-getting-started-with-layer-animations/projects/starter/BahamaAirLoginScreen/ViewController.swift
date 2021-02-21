/*
 * Copyright (c) 2014-present Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

// A delay function
func delay(seconds: Double, completion: @escaping ()-> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
}

class ViewController: UIViewController {
    
    // MARK: IB outlets
    
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var userNameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    let bannerView = UIImageView(image: UIImage(named: "banner"))
    let bannerLabel = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로그인 버튼 유저 인터페이스 설정
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        // 스피너 유저 인터페이스 설정: 로그인 버튼의 하위 뷰가 된다
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        // 배너 유저 인터페이스 설정: 로그인 버튼과 동일한 중앙 위치
        bannerView.isHidden = true
        bannerView.center = loginButton.center
        view.addSubview(bannerView)
        
        // 배너에 사용될 레이블 유저 인터페이스 설정
        bannerLabel.frame = CGRect(x: 0.0, y: 0.0, width: bannerView.frame.size.width, height: bannerView.frame.size.height)
        bannerLabel.font = UIFont(name: "HelveticaNeue", size: 18.0)
        bannerLabel.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        bannerLabel.textAlignment = .center
        bannerView.addSubview(bannerLabel)
        
        // 최초의 배너 중앙 위치를 statusPosition에 할당한다
        statusPosition = bannerView.center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 텍스트 필드 기본 위치 설정: 뷰의 넓이 만큼 위치 조정
        userNameField.center.x -= view.bounds.width
        passwordField.center.x -= view.bounds.width
        
        // 구름 이미지를 처음에는 보이지 않도록 alpha 설정
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
        
        // 로그인 버튼의 y축 위치를 아래로 설정하고 보이지 않도록 alpha 설정
        loginButton.center.y += 30.0
        loginButton.alpha = 0.0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 유저 네임 텍스트 필드를 약간의 딜레이 후 제자리로 애니메이트
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       animations: {
                        self.userNameField.center.x += self.view.bounds.width
                       },
                       completion: nil
        )
        
        // 패스워드 텍스트 필드를 약간의 딜레이 후 제자리로 애니메이트
        UIView.animate(withDuration: 0.5, delay: 0.4, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.0,
                       animations: {
                        self.passwordField.center.x += self.view.bounds.width
                       },
                       completion: nil
        )
        
        // 모든 구름 이미지를 각각의 딜레이 이후 화면에 보이도록 애니메이트
        UIView.animate(withDuration: 0.5, delay: 0.5,
                       animations: {
                        self.cloud1.alpha = 1.0
                       },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.7,
                       animations: {
                        self.cloud2.alpha = 1.0
                       },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.9,
                       animations: {
                        self.cloud3.alpha = 1.0
                       },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 1.1,
                       animations: {
                        self.cloud4.alpha = 1.0
                       },
                       completion: nil
        )
        
        // 로그인 버튼을 딜레이 후 다시 제자리로 돌려 놓으면서 화면에 보이도록 애니메이트
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.0,
                       animations: {
                        self.loginButton.center.y -= 30.0
                        self.loginButton.alpha = 1.0
                       },
                       completion: nil
        )
        
        // 구름 이미지들이 계속해서 애니메이트 하도록 메소드 호출
        animateCloud(cloud1)
        animateCloud(cloud2)
        animateCloud(cloud3)
        animateCloud(cloud4)
    }
    
    func showMessage(index: Int) {
        
        // 배너 레이블의 텍스트를 messages의 index번째 메시지로 설정
        bannerLabel.text = messages[index]
        
        // 배너 뷰를 숨기고 일정 딜레이 후
        // messages의 모든 메시지를 사용했는지 여부에 따라 다른 메소드를 호출
        UIView.transition(with: bannerView, duration: 0.33,
                          options: [.curveEaseOut, .transitionFlipFromBottom],
                          animations: {
                            // 배너 뷰가 화면에 표현되도록 애니메이트
                            self.bannerView.isHidden = false
                          },
                          completion: {_ in
                            delay(seconds: 2.0) {
                                if index < self.messages.count-1 {
                                    // 소비할 메시지가 존재한다면 해당 블록 수행
                                    self.removeMessage(index: index)
                                } else {
                                    // 모든 메시지를 소비했다면 해당 블록 수행
                                    self.resetForm()
                                }
                            }
                          }
        )
    }
    
    /// 현재 표현되고 있는 배너 뷰를 사라지도록 애니메이트하고, 다시 showMessage를 호출한다
    /// - Parameter index: 메시지 배열의 인덱스를 가리킨다
    func removeMessage(index: Int) {
        
        UIView.animate(withDuration: 0.33, delay: 0.0,
                       animations: {
                        // 배너 뷰를 화면 바깥으로 이동
                        self.bannerView.center.x += self.view.frame.size.width
                       },
                       completion: {_ in
                        // 화면 바깥으로 이동된 배너 뷰를 숨김
                        self.bannerView.isHidden = true
                        // 숨겨진 배너 뷰의 위치를 최초의 위치로 설정
                        self.bannerView.center = self.statusPosition
                        // 다시 showMessage(index:)를 호출한다
                        self.showMessage(index: index+1)
                       }
        )
    }
    
    /// 배너 뷰의 위치를 초기 위치로 설정하고 숨김
    func resetForm() {
        UIView.transition(with: bannerView, duration: 0.2, options: .transitionFlipFromTop,
                          animations: {
                            // 배너 뷰를 초기 상태로 설정
                            self.bannerView.isHidden = true
                            self.bannerView.center = self.statusPosition
                          },
                          completion: nil
        )
        
        UIView.animate(withDuration: 0.2, delay: 0.0,
                       animations: {
                        // 스피너의 중앙 위치를 변경
                        self.spinner.center = CGPoint(x: -20.0, y: 16.0)
                        // 스피너의 알파 값을 0로 설정해, 숨겨지도록 함
                        self.spinner.alpha = 0.0
                        // 로그인 버튼의 배경 색상을 변경
                        self.loginButton.backgroundColor = UIColor(red: 0.63, green: 0.84, blue: 0.35, alpha: 1.0)
                        // 로그인 버튼의 bounds 사이즈를 줄임
                        self.loginButton.bounds.size.width -= 80.0
                        // 로그인 버튼의 y축 위치를 올림
                        self.loginButton.center.y -= 60.0
                       },
                       completion: nil
        )
    }
    
    // MARK: further methods
    
    @IBAction func login() {
        view.endEditing(true)
        
        // 로그인 버튼의 넓이를 늘리고 (스피너가 뷰 내부에 표현되도록), 배너 표현을 시작함
        UIView.animate(withDuration: 1.5, delay: 0.0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 0.0,
                       animations: {
                        self.loginButton.bounds.size.width += 80.0
                       },
                       completion: {_ in
                        self.showMessage(index: 0)
                       }
        )
        
        UIView.animate(withDuration: 0.33, delay: 0.0, usingSpringWithDamping: 0.7,
                       initialSpringVelocity: 0.0,
                       animations: {
                        // 배너 뷰가 표현될 수 있게 로그인 버튼의 위치를 내림
                        self.loginButton.center.y += 60.0
                        // 로그인 버튼의 배경 색상을 변경
                        self.loginButton.backgroundColor = UIColor(red: 0.85, green: 0.83, blue: 0.45, alpha: 1.0)
                        // 스피너의 중앙 위치 변경
                        self.spinner.center = CGPoint(x: 40.0, y: self.loginButton.frame.size.height/2)
                        // 스피너가 화면에 표현되도록 함
                        self.spinner.alpha = 1.0
                       },
                       completion: nil
        )
    }
    
    func animateCloud(_ cloud: UIImageView) {
        let cloudSpeed = 60.0 / view.frame.size.width
        let duration = (view.frame.size.width - cloud.frame.origin.x) * cloudSpeed
        UIView.animate(withDuration: TimeInterval(duration), delay: 0.0, options: .curveLinear,
                       animations: {
                        // 구름 이미지가 화면 바깥까지 이동하도록 애니메이트
                        cloud.frame.origin.x = self.view.frame.size.width
                       },
                       completion: {_ in
                        // 구름 이미지가 화면을 벗어나면, 다시 시작할 수 있도록 화면의 처음으로 이동
                        cloud.frame.origin.x = -cloud.frame.size.width
                        // 구름 애니메이션 반복
                        self.animateCloud(cloud)
                       }
        )
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === userNameField) ? passwordField : userNameField
        nextField?.becomeFirstResponder()
        return true
    }
    
}
