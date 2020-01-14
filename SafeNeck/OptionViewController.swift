//
//  OptionViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 23..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

class OptionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Option"

        print("I'm here : 3")
        // Do any additional setup after loading the view.
        setUI()
    }

    //UI생성
    func setUI(){
        setUISetting()
        setNavigationBarView()
        setSwipeType()
        setOptionView()
    }
    
    //기본 UI 세팅
    func setUISetting(){
        //배경색
        view.backgroundColor = UIColor.white
        
        //내비게이션 바 아래쪽 뷰 세팅
        let basicUI = UIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64))
//        basicUI.backgroundColor = UIColor(red: 247/255, green: 246/255, blue: 242/255, alpha: 1)
        basicUI.backgroundColor = .white
        self.view.addSubview(basicUI)
    }
    
    //내비게이션 바 생성
    func setNavigationBarView(){
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        let navItem = UINavigationItem(title: "SafeNeck");
        navBar.setItems([navItem], animated: false);
        navBar.layer.shadowRadius = 2
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 247/255, green: 246/255, blue: 242/255, alpha: 1)]
        self.view.addSubview(navBar);
    }
    
    func setOptionView(){
        let reportOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height * 0.12), 1)
        self.view.addSubview(reportOptionView)
        
        let vibrationOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.12 + 64, width: view.frame.width, height: view.frame.height * 0.12), 2)
        self.view.addSubview(vibrationOptionView)
        
        let limitOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.24 + 64, width: view.frame.width, height: view.frame.height * 0.12), 3)
        self.view.addSubview(limitOptionView)
        
        let dailyOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.36 + 64, width: view.frame.width, height: view.frame.height * 0.12), 4)
        self.view.addSubview(dailyOptionView)
        
        let weeklyOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.48 + 64, width: view.frame.width, height: view.frame.height * 0.12), 5)
        self.view.addSubview(weeklyOptionView)
        
        let statusOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.60 + 64, width: view.frame.width, height: view.frame.height * 0.12), 6)
        self.view.addSubview(statusOptionView)
        
        let sleepOptionView: OptionUIView = OptionUIView(frame: CGRect(x: 0, y: view.frame.height * 0.72 + 64, width: view.frame.width, height: view.frame.height * 0.12), 7)
        self.view.addSubview(sleepOptionView)
    }
    //변경 버튼 클릭 실행
    @objc func changeButtonClicked(){
//        self.navigationController?.pushViewController(OptionChangeViewController(), animated: true)
    }
    
    //스위치 버튼 변경 실행
    @objc func changeSwitched(){
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    class OptionUIView: UIView{
        
        var title: [String] = ["리포트 시간 설정", "자세 경고 알림 설정", "진동 설정", "한계 시간 설정", "하루 목표 알림 개수 설정", "주간 목표 알림 개수 설정", "실시간 상태 확인", "수면 모드"]
        var subTitle: [String] = ["리포트 업데이트 시간을 설정합니다", "진동 On/Off 옵션을 설정합니다.", "1초~10초로 설정 가능합니다.", "하루 경고 최대 개수는 100개입니다", "주간 경고 최대 개수는 700개입니다", "이 칸을 누르면 실시간으로 상태 확인을 합니다", "수면 모드 On/Off 옵션을 설정합니다"]
        
        var type: Int!
        
        init(frame: CGRect,_ type: Int){
            super.init(frame: frame)
            self.type = type
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut(){
            
            let titleLabel = UILabel(frame: CGRect(x: 10, y: frame.height * 0.25, width: frame.width * 0.8, height: frame.height * 0.25))
            titleLabel.text = self.title[self.type - 1]
            titleLabel.textColor = UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 1)
            titleLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 16)
            titleLabel.textAlignment = NSTextAlignment.left
            addSubview(titleLabel)
            
            let subTitleLabel = UILabel(frame: CGRect(x: 10, y: frame.height * 0.5, width: frame.width * 0.8, height: frame.height * 0.25))
            subTitleLabel.text = self.subTitle[self.type - 1]
            subTitleLabel.textColor = UIColor(red: 78/255, green: 78/255, blue: 78/255, alpha: 1)
            subTitleLabel.font = UIFont(name: "NanumBarunGothicOTF", size: 12)
            subTitleLabel.textAlignment = NSTextAlignment.left
            addSubview(subTitleLabel)

            if((type != 2) && (type != 7)){
                let changeButton = UIButton(frame: CGRect(x: frame.width * 0.82 - 10, y: frame.height * 0.3, width: frame.width * 0.18, height: frame.height * 0.4))
                changeButton.setTitle("CHANGE", for: .normal)
                changeButton.setTitleColor(UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1), for: .normal)
                changeButton.layer.borderColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1).cgColor
                changeButton.layer.borderWidth = 1
                changeButton.layer.cornerRadius = 5
                changeButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 12)
                changeButton.addTarget(OptionViewController(), action: #selector(changeButtonClicked), for: .touchUpInside)
                addSubview(changeButton)
            }else{
                let changSwitch = UISwitch(frame: CGRect(x: frame.width * 0.82 - 3, y: frame.height * 0.3, width: 0.18, height: frame.height * 0.4))
                changSwitch.setOn(false, animated: true)
                changSwitch.tintColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
                changSwitch.onTintColor = UIColor(red: 67/255, green: 67/255, blue: 67/255, alpha: 1)
                changSwitch.addTarget(OptionViewController(), action: #selector(changeSwitched), for: .valueChanged)
                addSubview(changSwitch)
            }
            
            if(type != 7){
            let underLineView = UIView(frame: CGRect(x: 10, y: frame.height - 1, width: frame.width - 20, height: 1))
            underLineView.backgroundColor = UIColor(red: 221/255, green: 221/255, blue: 221/255, alpha: 1)
            addSubview(underLineView)
            }
        }
    }
    
    func setSwipeType(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(OptionViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(OptionViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.tabBarController?.selectedIndex = 1
            case UISwipeGestureRecognizer.Direction.left:
                self.tabBarController?.selectedIndex = 0
            default:
                break
            }
        }
    }
}
