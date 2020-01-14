//
//  LoginViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 18..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    let loginURL = "http://soylatte.kr:8080/auth/login"
    var idTextField: UITextField!
    var pwTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    //UI생성
    func setUI(){
        setUISetting()
        setNavigationBarView()
        setLoginInfoView()
        setLoginButtonView()
        setAnotherLoginView()
        setAnotherLoginButtonView()
    }
    
    //기본 UI 세팅
    func setUISetting(){
        
        //배경 색
        view.backgroundColor = UIColor.green
        
        //내비게이션 바 아래쪽 뷰 세팅
        let basicUI = UIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64))
        basicUI.backgroundColor = UIColor.white
        self.view.addSubview(basicUI)
    }
    
    //내비게이션 바 생성
    func setNavigationBarView(){
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        let navItem = UINavigationItem(title: "LOGIN");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(backButtonClicked));
        navItem.leftBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
        navBar.layer.shadowRadius = 2
        navBar.backgroundColor = UIColor.white
        self.view.addSubview(navBar);
    }
    
    //로그인 정보창 생성
    func setLoginInfoView(){
        
        //UIView
        let idField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.12, width: view.frame.width - 20, height: 50))
        let pwField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.22, width: view.frame.width - 20, height: 50))
        
        //TextField
        idTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.12, width: view.frame.width - 50, height: 50))
        idTextField.placeholder = "ID"
        idTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        
        pwTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.22, width: view.frame.width - 50, height: 50))
        pwTextField.placeholder = "PW"
        pwTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        pwTextField.isSecureTextEntry = true;
        
        //UIView, TextField 세팅 함수 실행
        loginTextFieldBasicSetting(idField, idTextField)
        loginTextFieldBasicSetting(pwField, pwTextField)
    }
    
    //다른 방식으로 로그인 생성
    func setAnotherLoginView(){
        let longView = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.8 - 10, width: view.frame.width - 20, height: 1))
        longView.backgroundColor = UIColor.gray
        view.addSubview(longView)

        let anotherLoginLabel = UILabel(frame: CGRect(x: (view.frame.width * 0.5) - (((view.frame.width - 40) / 3) * 0.5), y: view.frame.height * 0.8 - 14, width: (view.frame.width - 40) / 3, height: 15))
        anotherLoginLabel.text = "Login with another way"
        anotherLoginLabel.font = UIFont(name: "NanumBarunGothicOTF", size: 10)
        anotherLoginLabel.textAlignment = NSTextAlignment.center
        anotherLoginLabel.textColor = UIColor.gray
        anotherLoginLabel.backgroundColor = UIColor.white
        view.addSubview(anotherLoginLabel)
    }
    
    //구글, 페이스북, 네이버 로그인 버튼 생성
    func setAnotherLoginButtonView(){
        let googleImage = UIImage(named: "ic_login_google")
        let googleLoginButton = anotherLoginUIButton(frame: CGRect(x: 10, y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: googleImage!, getColor: UIColor(red: 210/255, green: 53/255, blue: 44/255, alpha: 1))
        view.addSubview(googleLoginButton)
        
        let naverImage = UIImage(named: "ic_login_naver")
        let naverLoginButton = anotherLoginUIButton(frame: CGRect(x: (view.frame.width * 0.5) - (((view.frame.width - 40) / 3) * 0.5), y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: naverImage!, getColor: UIColor(red: 35/255, green: 194/255, blue: 5/255, alpha: 1))
        view.addSubview(naverLoginButton)
        
        let fbImage = UIImage(named: "ic_login_fb")
        let facebookLoginButton = anotherLoginUIButton(frame: CGRect(x: view.frame.width - ((view.frame.width - 40) / 3) - 10, y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: fbImage!, getColor: UIColor(red: 45/255, green: 68/255, blue: 134/255, alpha: 1))
        view.addSubview(facebookLoginButton)
    }
    
    //로그인 버튼 생성
    func setLoginButtonView() {
        let loginButton = UIButton(frame: CGRect(x: 0, y: view.frame.height * 0.9, width: view.frame.width, height: view.frame.height * 0.1))
        loginButton.setTitle("login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFUltraLight", size: 16)
        loginButton.backgroundColor = UIColor.green
        loginButton.contentHorizontalAlignment = .center
        loginButton.addTarget(LoginViewController(), action: #selector(loginButtonClicked), for: .touchUpInside)
        view.addSubview(loginButton)
    }
    
    //백 버튼 실행
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //로그인 텍스트필드 기본 세팅
    func loginTextFieldBasicSetting(_ field: UIView, _ textField : UITextField) {
        field.layer.cornerRadius = 5
        field.layer.borderColor = UIColor.green.cgColor
        field.layer.borderWidth = 1.5
        textField.textColor = UIColor.black
        textField.delegate = self
        textField.keyboardType = UIKeyboardType.asciiCapable
        view.addSubview(field)
        view.addSubview(textField)
    }
    
    //리턴 누르면 키보드 없애기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //로그인 버튼 실행
    @objc func loginButtonClicked(){
        print("login")
        
        if(idTextField.text == ""){
            myAlert("Login FAIL", message: "enter your ID")
        }else if(pwTextField.text == ""){
            myAlert("Login FAIL", message: "enter your PASSWORD")
        }else{
            login(idTextField.text!, pwTextField.text!)
        }
    }

    //Alert 실행
    func myAlert(_ title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //로그인
    func login(_ id: String, _ pw: String){
        self.myAlert("Login SUCCESS", message: "WELCOME - SAFE NECK")
        let myViewController = TabBarViewController()
        let navController = UINavigationController(rootViewController: myViewController)
        self.present(navController, animated:true, completion: nil)
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //네이버, 구글, 페이스북 로그인을 위한 커스텀 UIButton
    class anotherLoginUIButton: UIButton {
        var image: UIImage!
        
        init(frame: CGRect, getImage: UIImage, getColor: UIColor) {
            super.init(frame: frame)
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = getColor.cgColor
            self.layer.cornerRadius = 5
            self.image = getImage
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut() {
            let imageView = UIImageView(frame: CGRect(x: frame.width * 0.5 - 10, y: frame.height * 0.5 - 10, width: 20,  height: 20))
            imageView.image = image
            imageView.contentMode = .scaleAspectFit
            addSubview(imageView)
        }
    }

}
