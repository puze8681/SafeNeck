//
//  RegisterViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 17..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {

    let registerURL = "http://soylatte.kr:8080/auth/register"
    var nameTextField: UITextField!
    var idTextField: UITextField!
    var pwTextField: UITextField!
    var pwConfirmTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUI()
    }
    
    //UI생성
    func setUI(){
        setUISetting()
        setNavigationBarView()
        setRegisterInfoView()
        setRegisterButtonView()
        setAnotherRegistView()
        setAnotherRegistButtonView()
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
        let navItem = UINavigationItem(title: "REGISTER");
        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(backButtonClicked));
        navItem.leftBarButtonItem = doneItem;
        navBar.setItems([navItem], animated: false);
        navBar.layer.shadowRadius = 2
        navBar.backgroundColor = UIColor.white
        self.view.addSubview(navBar);
    }
    
    //회원가입 정보창 생성
    func setRegisterInfoView(){
        
        //UIView
        let nameField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.12, width: view.frame.width - 20, height: 50))
        let idField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.22, width: view.frame.width - 20, height: 50))
        let pwField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.32, width: view.frame.width - 20, height: 50))
        let pwConfirmField = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.42, width: view.frame.width - 20, height: 50))

        //TextField
        nameTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.12, width: view.frame.width - 50, height: 50))
        nameTextField.placeholder = "NAME"
        nameTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        
        idTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.22, width: view.frame.width - 50, height: 50))
        idTextField.placeholder = "ID"
        idTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        
        pwTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.32, width: view.frame.width - 50, height: 50))
        pwTextField.placeholder = "PW"
        pwTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        pwTextField.isSecureTextEntry = true;
        
        pwConfirmTextField = UITextField(frame: CGRect(x: 25, y: view.frame.height * 0.42, width: view.frame.width - 50, height: 50))
        pwConfirmTextField.placeholder = "PW CONFIRM"
        pwConfirmTextField.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        pwConfirmTextField.isSecureTextEntry = true;
        
        //UIView, TextField 세팅 함수 실행
        registerTextFieldBasicSetting(nameField, nameTextField)
        registerTextFieldBasicSetting(idField, idTextField)
        registerTextFieldBasicSetting(pwField, pwTextField)
        registerTextFieldBasicSetting(pwConfirmField, pwConfirmTextField)
    }
    
    //다른 방식으로 회원가입 생성
    func setAnotherRegistView(){
        let longView = UIView(frame: CGRect(x: 10, y: view.frame.height * 0.8 - 10, width: view.frame.width - 20, height: 1))
        longView.backgroundColor = UIColor.gray
        
        view.addSubview(longView)
        
        let anotherRegistLabel = UILabel(frame: CGRect(x: (view.frame.width * 0.5) - (((view.frame.width - 40) / 3) * 0.5), y: view.frame.height * 0.8 - 14, width: (view.frame.width - 40) / 3, height: 15))
        anotherRegistLabel.text = "Regist with another way"
        anotherRegistLabel.font = UIFont(name: "NanumBarunGothicOTF", size: 10)
        anotherRegistLabel.textAlignment = NSTextAlignment.center
        anotherRegistLabel.textColor = UIColor.gray
        anotherRegistLabel.backgroundColor = UIColor.white
        view.addSubview(anotherRegistLabel)
    }
    
    //구글, 페이스북, 네이버 회원가입 버튼 생성
    func setAnotherRegistButtonView(){
        let googleImage = UIImage(named: "ic_login_google")
        let googleRegistButton = anotherRegisterUIButton(frame: CGRect(x: 10, y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: googleImage!, getColor: UIColor(red: 210/255, green: 53/255, blue: 44/255, alpha: 1))

        view.addSubview(googleRegistButton)
        
        let naverImage = UIImage(named: "ic_login_naver")
        let naverRegistButton = anotherRegisterUIButton(frame: CGRect(x: (view.frame.width * 0.5) - (((view.frame.width - 40) / 3) * 0.5), y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: naverImage!, getColor: UIColor(red: 35/255, green: 194/255, blue: 5/255, alpha: 1))
        view.addSubview(naverRegistButton)
        
        let fbImage = UIImage(named: "ic_login_fb")
        let facebookRegistButton = anotherRegisterUIButton(frame: CGRect(x: view.frame.width - ((view.frame.width - 40) / 3) - 10, y: view.frame.height * 0.8 + 10, width: (view.frame.width - 40) / 3, height: view.frame.height * 0.1 - 20), getImage: fbImage!, getColor: UIColor(red: 45/255, green: 68/255, blue: 134/255, alpha: 1))
        view.addSubview(facebookRegistButton)
    }
    
    //회원가입 버튼 생성
    func setRegisterButtonView() {
        
        let registerButton = UIButton(frame: CGRect(x: 0, y: view.frame.height * 0.9, width: view.frame.width, height: view.frame.height * 0.1))
        registerButton.setTitle("regist", for: .normal)
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.backgroundColor = UIColor.green
        registerButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        registerButton.contentHorizontalAlignment = .center
        registerButton.addTarget(RegisterViewController(), action: #selector(registButtonClicked), for: .touchUpInside)
        view.addSubview(registerButton)
    }
    
    //백 버튼 실행
    @objc func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    //회원가입 텍스트필드 기본 세팅
    func registerTextFieldBasicSetting(_ field: UIView, _ textField : UITextField) {
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
    
    //회원가입 버튼 실행
    @objc func registButtonClicked(){
        if(nameTextField.text == ""){
            myAlert("Regist FAIL", message: "enter your NAME")
        }else if(idTextField.text == ""){
            myAlert("Regist FAIL", message: "enter your ID")
        }else if(pwTextField.text == ""){
            myAlert("Regist FAIL", message: "enter your PASSWORD")
        }else if(pwConfirmTextField.text == ""){
            myAlert("Regist FAIL", message: "enter your PASSWORD CONFIRM")
        }else if(pwConfirmTextField.text != pwTextField.text){
            myAlert("Regist FAIL", message: "confirm your PASSWORD")
        }else{
            regist(nameTextField.text!, idTextField.text!, pwTextField.text!, pwConfirmTextField.text!)
        }
    }

    //Alert 실행
    func myAlert(_ title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //회원가입
    func regist(_ name: String, _ id: String, _ pw: String, _ pwConfirm: String){
        self.navigationController?.pushViewController(FirstLoginViewController(), animated: true)
        self.myAlert("Regist SUCCESS", message: "WELCOME - SAFE NECK")
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
    
    //네이버, 구글, 페이스북 회원가입을 위한 커스텀 UIButton
    class anotherRegisterUIButton: UIButton {
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
