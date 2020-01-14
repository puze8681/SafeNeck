//
//  ViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 8..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                setUI()
    }
    
    func findFont(){
        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
    
    //UI 생성
    func setUI(){
        setUISetting()
        setLogoImageView()
        setSlogunView()
        setButtonView()
    }
    
    //기본 UI 세팅
    func setUISetting(){
        
        //내비게이션 바 지우기
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //백그라운드 컬러
        view.backgroundColor = .green
    }
    
    //로고 이미지 생성
    func setLogoImageView(){
        let imageView = UIImageView(frame: CGRect(x: 0, y: view.frame.width * 0.3, width: view.frame.width, height: view.frame.height * 0.45))
        imageView.image = #imageLiteral(resourceName: "bg_splash_logo.png")
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
    }
    
    //하단 슬로건 뷰 생성
    func setSlogunView() {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.8, width: view.frame.width, height: view.frame.height * 0.25))
        titleLabel.text = "STA + C 2017"
        titleLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
        titleLabel.textColor = .white
        titleLabel.textAlignment = NSTextAlignment.center
        view.addSubview(titleLabel)
        
        let contentLabel = UILabel(frame: CGRect(x: 0, y: view.frame.height * 0.8, width: view.frame.width, height: view.frame.height * 0.31))
        contentLabel.text = "선린인터넷고등학교 팀 Safe neck"
        contentLabel.font = UIFont(name: "NanumBarunGothicOTFLight", size: 12)
        contentLabel.textColor = .white
        contentLabel.textAlignment = NSTextAlignment.center
        view.addSubview(contentLabel)
    }
    
    //회원가입, 로그인 버튼 뷰 생성
    func setButtonView(){
        
        let loginButton = UIButton(frame: CGRect(x: view.frame.width * 0.5 - 80, y: view.frame.height * 0.7 - 5, width: 160, height: view.frame.height * 0.05))
        loginButton.setTitle("LOGIN", for: .normal)
        loginButton.setTitleColor(UIColor(red: 48/255, green: 65/255, blue: 71/255, alpha: 1), for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        loginButton.layer.borderColor = UIColor(red: 23/255, green: 138/255, blue: 113/255, alpha: 1).cgColor
        loginButton.layer.borderWidth = 1
        loginButton.layer.cornerRadius = 5
        loginButton.addTarget(LoginViewController(), action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
        
        let registerButton = UIButton(frame: CGRect(x: view.frame.width * 0.5 - 80, y: view.frame.height * 0.8 - 5, width: 160, height: view.frame.height * 0.05))
        registerButton.setTitle("REGISTER", for: .normal)
        registerButton.setTitleColor(UIColor(red: 48/255, green: 65/255, blue: 71/255, alpha: 1), for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        registerButton.layer.borderColor = UIColor(red: 23/255, green: 138/255, blue: 113/255, alpha: 1).cgColor
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 5
        registerButton.addTarget(RegisterViewController(), action: #selector(registerButtonClicked), for: .touchUpInside)
        view.addSubview(registerButton)
        
        
    }
    
    //회원가입 버튼 실행 <- 완전 중요
    @objc func registerButtonClicked(){
        //옆에서 나오게 하는거임
        //self.navigationController.pushViewController(RegisterViewController(), animated:true)
        //그냥 띄우는거임
        //self.present(navigationController,animated:true, completion:nil)
        //팝업으로 뜨는거임
//        print("Registernumuganda")
//        let navigationController = UINavigationController(rootViewController: RegisterViewController())
//        navigationController.pushViewController(RegisterViewController(), animated: true)

        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    @objc func loginButtonClicked(){
        self.navigationController?.pushViewController(LoginViewController(), animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

