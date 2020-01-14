//
//  MainViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 22..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    var todayNoticeNum: UILabel!
    var weekNoticeNum: UILabel!
    
    var dailyButton: TermUIButton!
    var weeklyButton: TermUIButton!
    var monthlyButton: TermUIButton!
    
    var barGraphView: BarGraphUIView!
    
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Main"
        print("I'm here : 2")
        // Do any additional setup after loading the view.
        
        setUI()
    }

    //UI생성
    func setUI(){
        setUISetting()
        setNavigationBarView()
        setNoticeNumView()
        setDateLabelView()
        setTermButtonView()
        setBarGraphView()
        setSwipeType()
    }
    
    //기본 UI 세팅
    func setUISetting(){
        //배경색
        view.backgroundColor = UIColor.white

        //내비게이션 바 아래쪽 뷰 세팅
        let basicUI = UIView(frame: CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height-64))
        basicUI.backgroundColor = UIColor(red: 247/255, green: 246/255, blue: 242/255, alpha: 1)
        self.view.addSubview(basicUI)
    }
    
    //내비게이션 바 생성
    func setNavigationBarView(){
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        let navItem = UINavigationItem(title: "SafeNeck");
        navBar.setItems([navItem], animated: false);
        navBar.layer.shadowRadius = 2
        self.view.addSubview(navBar);
    }
    
    //상단 알림개수 뷰 생성
    func setNoticeNumView(){
        let todayNoticeUIView: NoticeUIView = NoticeUIView(frame: CGRect(x: 10, y: view.frame.height * 0.1 + 15, width: view.frame.width * 0.5 - 15, height: view.frame.height * 0.2 + 10), getTitle: "오늘 받은 알림 개수", getContent: "일간 알림 개수 목표치는 15회입니다.", getBackColor: UIColor.white, getTextColor: UIColor.green)
        view.addSubview(todayNoticeUIView)
        
        let weekNoticeUIView: NoticeUIView = NoticeUIView(frame: CGRect(x: view.frame.width * 0.5 + 5, y: view.frame.height * 0.1 + 15, width: view.frame.width * 0.5 - 15, height: view.frame.height * 0.2 + 10), getTitle: "주간 받은 알림 개수", getContent: "주간 알림 개수 목표치는 45회입니다.", getBackColor: UIColor.green, getTextColor: UIColor.white)
        view.addSubview(weekNoticeUIView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //중간 날짜 라벨 생성
    func setDateLabelView(){
        let dateLabel = DateUIView(frame: CGRect(x: 10, y: view.frame.height * 0.35 + 10, width: view.frame.width - 20, height: view.frame.height * 0.09))
        view.addSubview(dateLabel)
    }
    
    //기간 선택 버튼 생성
    func setTermButtonView(){
        dailyButton = TermUIButton(frame: CGRect(x: 15, y: view.frame.height * 0.5, width: (view.frame.width * 0.3 - 15), height: view.frame.height * 0.1 - 30) , getText: "DAILY")
        dailyButton.addTarget(MainViewController(), action: #selector(dailyButtonClicked), for: .touchUpInside)
        dailyButton.isSelected = true
        dailyButton.backgroundColor = UIColor.green
        dailyButton.termLabel.textColor = UIColor.white
        view.addSubview(dailyButton)
        
        weeklyButton = TermUIButton(frame: CGRect(x: (view.frame.width * 0.35 + 7.5), y: view.frame.height * 0.5, width: (view.frame.width * 0.3 - 15), height: view.frame.height * 0.1 - 30) , getText: "WEEKLY")
        weeklyButton.addTarget(MainViewController(), action: #selector(weeklyButtonClicked), for: .touchUpInside)
        weeklyButton.isSelected = false
        weeklyButton.backgroundColor = UIColor.white
        weeklyButton.termLabel.textColor = UIColor.green
        view.addSubview(weeklyButton)
        
        monthlyButton = TermUIButton(frame: CGRect(x: (view.frame.width * 0.7), y: view.frame.height * 0.5, width: (view.frame.width * 0.3 - 15), height: view.frame.height * 0.1 - 30) , getText: "MONTHLY")
        monthlyButton.addTarget(MainViewController(), action: #selector(monthlyButtonClicked), for: .touchUpInside)
        monthlyButton.isSelected = false
        monthlyButton.backgroundColor = UIColor.white
        monthlyButton.termLabel.textColor = UIColor.green
        view.addSubview(monthlyButton)
    }
    
    func setBarGraphView(){
        let count:[Int] = [4,5,2,6,1,3]
        let time:[Int] = [14,15,16,17,18,19]
        barGraphView = BarGraphUIView(frame: CGRect(x: 10, y: (view.frame.height * 0.66) - 40 , width: view.frame.width - 20, height: (view.frame.height * 0.24) + 35), count: count, time: time)
        view.addSubview(barGraphView)
    }
    
    //일간 선택 버튼 실행
    @objc func dailyButtonClicked(){
        if(dailyButton.isSelected){
        }else{
            dailyButton.isSelected = true
            weeklyButton.isSelected = false
            monthlyButton.isSelected = false
            
            dailyButton.backgroundColor = UIColor.green
            dailyButton.termLabel.textColor = UIColor.white
            weeklyButton.backgroundColor = UIColor.white
            weeklyButton.termLabel.textColor = UIColor.green
            monthlyButton.backgroundColor = UIColor.white
            monthlyButton.termLabel.textColor = UIColor.green
        }
    }
    
    //주간 선택 버튼 실행
    @objc func weeklyButtonClicked(){
        if(weeklyButton.isSelected){
        }else{
            dailyButton.isSelected = false
            weeklyButton.isSelected = true
            monthlyButton.isSelected = false
            
            dailyButton.backgroundColor = UIColor.white
            dailyButton.termLabel.textColor = UIColor.green
            weeklyButton.backgroundColor = UIColor.green
            weeklyButton.termLabel.textColor = UIColor.white
            monthlyButton.backgroundColor = UIColor.white
            monthlyButton.termLabel.textColor = UIColor.green
        }
    }

    //월간 선택 버튼 실행
    @objc func monthlyButtonClicked(){
        if(monthlyButton.isSelected){
        }else{
            dailyButton.isSelected = false
            weeklyButton.isSelected = false
            monthlyButton.isSelected = true
           
            dailyButton.backgroundColor = UIColor.white
            dailyButton.termLabel.textColor = UIColor.green
            weeklyButton.backgroundColor = UIColor.white
            weeklyButton.termLabel.textColor = UIColor.green
            monthlyButton.backgroundColor = UIColor.green
            monthlyButton.termLabel.textColor = UIColor.white
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //상단 알림 개수 뷰 클래스
    class NoticeUIView: UIView {
        var num: Int!
        var title: String!
        var content: String!
        var noticeNumLabel: UILabel!
        var textColor: UIColor!
        
        init(frame: CGRect, getTitle: String, getContent: String, getBackColor: UIColor, getTextColor: UIColor) {
            super.init(frame: frame)
            self.backgroundColor = getBackColor
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 5
            self.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: 0, height: 2), radius: 5, scale: true)
            self.title = getTitle
            self.textColor = getTextColor
            self.content = getContent
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut() {
            let titleLabel = UILabel(frame: CGRect(x: 10, y: 10, width: frame.width - 20, height: frame.height * 0.2))
            titleLabel.text = self.title
            titleLabel.textColor = textColor
            titleLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 16)
            addSubview(titleLabel)
            print("titleLabel")
            
            let contentLabel = UILabel(frame: CGRect(x: 10, y: frame.height * 0.2 + 10, width: frame.width - 20, height: frame.height * 0.1))
            contentLabel.text = self.content
            contentLabel.textColor = UIColor(red: 126/255, green: 213/255, blue: 194/255, alpha: 1)
            contentLabel.font = UIFont(name: "NanumBarunGothicOTF", size: 10)
            addSubview(contentLabel)
            print("contentLabel")

            noticeNumLabel = UILabel(frame: CGRect(x: 10, y: frame.height * 0.3 + 10, width: frame.width - 20, height: frame.height * 0.7))
            noticeNumLabel.textColor = textColor
            noticeNumLabel.font = UIFont(name: "NanumBarunGothicOTFLight", size: 72)
            noticeNumLabel.text = "12"
            addSubview(noticeNumLabel)
            print("noticeNumLabel")

        }
    }
    
    //날짜 커스텀 뷰
    class DateUIView: UIView{
        
        override init(frame: CGRect){
            super.init(frame: frame)
            self.backgroundColor = UIColor.white
            self.layer.borderWidth = 0
            self.layer.cornerRadius = 5
            self.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: 0, height: 2), radius: 5, scale: true)
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut(){
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy.MM.dd"
            let result = formatter.string(from: date)

            let leftClampLabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 0, width: frame.width * 0.8, height: frame.height))
            leftClampLabel.text = "<"
            leftClampLabel.textColor = UIColor.green
            leftClampLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 20)
            leftClampLabel.textAlignment = NSTextAlignment.left
            addSubview(leftClampLabel)
            
            let rightClampLabel = UILabel(frame: CGRect(x: frame.width * 0.1, y: 0, width: frame.width * 0.8, height: frame.height))
            rightClampLabel.text = ">"
            rightClampLabel.textColor = UIColor.green
            rightClampLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 20)
            rightClampLabel.textAlignment = NSTextAlignment.right
            addSubview(rightClampLabel)

            let dateLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
            dateLabel.textColor = UIColor.green
            dateLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 16)
            dateLabel.textAlignment = NSTextAlignment.center
            dateLabel.text = result
            addSubview(dateLabel)
        }
    }

    //일간,주간, 월간 버튼
    class TermUIButton: UIButton{
    
        var text : String!
        var termLabel : UILabel!
        
        init(frame: CGRect, getText: String) {
            super.init(frame: frame)
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.green.cgColor
            self.layer.cornerRadius = 5
            self.text = getText
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut() {
            termLabel = UILabel(frame: CGRect(x: frame.width * 0.5 - 40, y: frame.height * 0.5 - 10, width: 80,  height: 20))
            termLabel.text = text
            termLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            termLabel.textAlignment = NSTextAlignment.center
            addSubview(termLabel)
        }
    }
    
    class BarGraphUIView: UIView{

        var count: [Int] = [4,5,2,6,1,3]
        var time : [Int] = [14,15,16,17,18,19]
        
        init(frame: CGRect, count: [Int], time: [Int]){
            super.init(frame: frame)
            self.count = count
            self.time = time
            self.backgroundColor = UIColor(red: 48/255, green: 65/255, blue: 71/255, alpha: 1)
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor(red: 48/255, green: 65/255, blue: 71/255, alpha: 1).cgColor
            self.dropShadow(color: .lightGray, opacity: 1, offSet: CGSize(width: 0, height: 2), radius: 5, scale: true)
            self.layer.cornerRadius = 5
            setLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLayOut(){
            let underLineView = UIView(frame: CGRect(x: 10, y: frame.height * 0.8 - 1, width: frame.width - 20, height: 1))
            underLineView.backgroundColor = UIColor.green
            addSubview(underLineView)
            
            setChartView(self.count)
            setCountView(self.count)
            setTimeView(self.time)
            
            let countLabel = UILabel(frame: CGRect(x: 0, y: frame.height * 0.7, width: frame.width, height: frame.height * 0.1))
            countLabel.textColor = UIColor.white
            countLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            countLabel.textAlignment = NSTextAlignment.center
            
            let timeLable = UILabel(frame: CGRect(x: 0, y: frame.height * 0.9, width: frame.width, height: frame.height * 0.1))
            timeLable.textColor = UIColor.green
            timeLable.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            countLabel.textAlignment = NSTextAlignment.center
            
        }
        
        func setChartView(_ count : [Int]){
            var max = count[0]
            for i in count {
                if(max < i){
                    max = i
                }
            }
            
            let height1 = ((frame.height * 0.8) - 10) * (CGFloat(count[0]) / CGFloat(max))
            let height2 = ((frame.height * 0.8) - 10) * (CGFloat(count[1]) / CGFloat(max))
            let height3 = ((frame.height * 0.8) - 10) * (CGFloat(count[2]) / CGFloat(max))
            let height4 = ((frame.height * 0.8) - 10) * (CGFloat(count[3]) / CGFloat(max))
            let height5 = ((frame.height * 0.8) - 10) * (CGFloat(count[4]) / CGFloat(max))
            let height6 = ((frame.height * 0.8) - 10) * (CGFloat(count[5]) / CGFloat(max))

            let bar1 = UIView(frame:CGRect(x: (frame.width * 0.1), y: (frame.height * 0.8) - height1, width: frame.width * 0.1, height: height1))
            bar1.backgroundColor = UIColor.green
            
            let bar2 = UIView(frame:CGRect(x: (frame.width * 0.24), y: (frame.height * 0.8) - height2, width: frame.width * 0.1, height: height2))
            bar2.backgroundColor = UIColor.green
            
            let bar3 = UIView(frame:CGRect(x: (frame.width * 0.38), y: (frame.height * 0.8) - height3, width: frame.width * 0.1, height: height3))
            bar3.backgroundColor = UIColor.green
            
            let bar4 = UIView(frame:CGRect(x: (frame.width * 0.52), y: (frame.height * 0.8) - height4, width: frame.width * 0.1, height: height4))
            bar4.backgroundColor = UIColor.green
            
            let bar5 = UIView(frame:CGRect(x: (frame.width * 0.66), y: (frame.height * 0.8) - height5, width: frame.width * 0.1, height: height5))
            bar5.backgroundColor = UIColor.green
            
            let bar6 = UIView(frame:CGRect(x: (frame.width * 0.8), y: (frame.height * 0.8) - height6, width: frame.width * 0.1, height: height6))
            bar6.backgroundColor = UIColor.green
            
            let path1 = UIBezierPath(roundedRect:bar1.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            let path2 = UIBezierPath(roundedRect:bar2.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            let path3 = UIBezierPath(roundedRect:bar3.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            let path4 = UIBezierPath(roundedRect:bar4.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            let path5 = UIBezierPath(roundedRect:bar5.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            let path6 = UIBezierPath(roundedRect:bar6.bounds, byRoundingCorners:[.topRight, .topLeft], cornerRadii: CGSize(width: 5, height:  5))
            
            let maskLayer1 = CAShapeLayer()
            let maskLayer2 = CAShapeLayer()
            let maskLayer3 = CAShapeLayer()
            let maskLayer4 = CAShapeLayer()
            let maskLayer5 = CAShapeLayer()
            let maskLayer6 = CAShapeLayer()

            maskLayer1.path = path1.cgPath
            maskLayer2.path = path2.cgPath
            maskLayer3.path = path3.cgPath
            maskLayer4.path = path4.cgPath
            maskLayer5.path = path5.cgPath
            maskLayer6.path = path6.cgPath
            
            bar1.layer.mask = maskLayer1
            bar2.layer.mask = maskLayer2
            bar3.layer.mask = maskLayer3
            bar4.layer.mask = maskLayer4
            bar5.layer.mask = maskLayer5
            bar6.layer.mask = maskLayer6
            
            addSubview(bar1)
            addSubview(bar2)
            addSubview(bar3)
            addSubview(bar4)
            addSubview(bar5)
            addSubview(bar6)
        }
        
        func setCountView(_ count : [Int]){
            let bar1 = UILabel(frame:CGRect(x: (frame.width * 0.1), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar1.textColor = UIColor.white
            bar1.text = String(count[0])+"회"
            bar1.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar1.textAlignment = NSTextAlignment.center
            addSubview(bar1)
            
            let bar2 = UILabel(frame:CGRect(x: (frame.width * 0.24), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar2.backgroundColor = UIColor.green
            bar2.textColor = UIColor.white
            bar2.text = String(count[1])+"회"
            bar2.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar2.textAlignment = NSTextAlignment.center
            addSubview(bar2)
            
            let bar3 = UILabel(frame:CGRect(x: (frame.width * 0.38), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar3.backgroundColor = UIColor.green
            bar3.textColor = UIColor.white
            bar3.text = String(count[2])+"회"
            bar3.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar3.textAlignment = NSTextAlignment.center
            addSubview(bar3)
            
            let bar4 = UILabel(frame:CGRect(x: (frame.width * 0.52), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar4.backgroundColor = UIColor.green
            bar4.textColor = UIColor.white
            bar4.text = String(count[3])+"회"
            bar4.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar4.textAlignment = NSTextAlignment.center
            addSubview(bar4)
            
            let bar5 = UILabel(frame:CGRect(x: (frame.width * 0.66), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar5.backgroundColor = UIColor.green
            bar5.textColor = UIColor.white
            bar5.text = String(count[4])+"회"
            bar5.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar5.textAlignment = NSTextAlignment.center
            addSubview(bar5)
            
            let bar6 = UILabel(frame:CGRect(x: (frame.width * 0.8), y: (frame.height * 0.7), width: frame.width * 0.1, height: frame.height * 0.1))
            bar6.backgroundColor = UIColor.green
            bar6.textColor = UIColor.white
            bar6.text = String(count[5])+"회"
            bar6.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar6.textAlignment = NSTextAlignment.center
            addSubview(bar6)
        }
        
        func setTimeView(_ time : [Int]){
            let bar1 = UILabel(frame:CGRect(x: (frame.width * 0.1), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar1.textColor = UIColor.green
            bar1.text = String(time[0])+"시"
            bar1.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar1.textAlignment = NSTextAlignment.center
            addSubview(bar1)
            
            let bar2 = UILabel(frame:CGRect(x: (frame.width * 0.24), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar2.textColor = UIColor.green
            bar2.text = String(time[1])+"시"
            bar2.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar2.textAlignment = NSTextAlignment.center
            addSubview(bar2)
            
            let bar3 = UILabel(frame:CGRect(x: (frame.width * 0.38), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar3.textColor = UIColor.green
            bar3.text = String(time[2])+"시"
            bar3.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar3.textAlignment = NSTextAlignment.center
            addSubview(bar3)
            
            let bar4 = UILabel(frame:CGRect(x: (frame.width * 0.52), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar4.textColor = UIColor.green
            bar4.text = String(time[3])+"시"
            bar4.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar4.textAlignment = NSTextAlignment.center
            addSubview(bar4)
            
            let bar5 = UILabel(frame:CGRect(x: (frame.width * 0.66), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar5.textColor = UIColor.green
            bar5.text = String(time[4])+"시"
            bar5.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar5.textAlignment = NSTextAlignment.center
            addSubview(bar5)
            
            let bar6 = UILabel(frame:CGRect(x: (frame.width * 0.8), y: (frame.height * 0.8), width: frame.width * 0.1, height: frame.height * 0.1))
            bar6.textColor = UIColor.green
            bar6.text = String(time[5])+"시"
            bar6.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            bar6.textAlignment = NSTextAlignment.center
            addSubview(bar6)
        }
    }

    //스와이프 타입 세팅
    func setSwipeType(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.respondToSwipeGesture(_:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(MainViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    //스와이프 응답 받기
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                self.tabBarController?.selectedIndex = 0

            case UISwipeGestureRecognizer.Direction.left:
                self.tabBarController?.selectedIndex = 2

            default:
                break
            }
        }
    }
}
