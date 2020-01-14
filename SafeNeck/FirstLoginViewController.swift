//
//  FirstLoginViewController.swift
//  SafeNeck
//
//  Created by 박태준 on 2017. 9. 21..
//  Copyright © 2017년 stac2017. All rights reserved.
//

import UIKit
import CoreBluetooth

class FirstLoginViewController: UIViewController, CBCentralManagerDelegate, CBPeripheralDelegate {

    var manager:CBCentralManager!
    var peripheral:CBPeripheral!
    
    let BEAN_NAME = "Robu"
    let BEAN_SCRATCH_UUID =
        CBUUID(string: "a495ff21-c5b1-4b44-b512-1370f02d74de")
    let BEAN_SERVICE_UUID =
        CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
    
    let initURL = "http://soylatte.kr:8080/auth/init"
    var femaleButton : genderUIButton!
    var maleButton : genderUIButton!
    
    var age: String!
    var gender: String!
    var position: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        manager = CBCentralManager(delegate: self, queue: nil)
        setUI()
    }
    
    //Scan for Device
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == CBManagerState.poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth not available.")
        }
    }
    
    //Connect to a Device
    private func centralManager(
        central: CBCentralManager,
        didDiscoverPeripheral peripheral: CBPeripheral,
        advertisementData: [String : AnyObject],
        RSSI: NSNumber) {
        let device = (advertisementData as NSDictionary)
            .object(forKey: CBAdvertisementDataLocalNameKey)
            as? NSString
        
        if device?.contains(BEAN_NAME) == true {
            self.manager.stopScan()
            
            self.peripheral = peripheral
            self.peripheral.delegate = self
            
            manager.connect(peripheral, options: nil)
        }
    }
    
    //Get Services
    func centralManager(
        central: CBCentralManager,
        didConnectPeripheral peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }
    
    //Get Characteristics
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverServices error: Error?) {
        for service in peripheral.services! {
            let thisService = service as CBService
            
            if service.uuid == BEAN_SERVICE_UUID {
                peripheral.discoverCharacteristics(
                    nil,
                    for: thisService
                )
            }
        }
    }
    
    //Setup Notifications
    func peripheral(
        _ peripheral: CBPeripheral,
        didDiscoverCharacteristicsFor service: CBService,
        error: Error?) {
        for characteristic in service.characteristics! {
            let thisCharacteristic = characteristic as CBCharacteristic
            
            if thisCharacteristic.uuid == BEAN_SCRATCH_UUID {
                self.peripheral.setNotifyValue(
                    true,
                    for: thisCharacteristic
                )
            }
        }
    }
    
    enum Bit: UInt8, CustomStringConvertible {
        case zero, one
        var description: String {
            switch self {
            case .one:
                return "1"
                
            case .zero :
                return "0"
            default:
                print("hi")
                
            }
        }
    }
    
    func bits(fromByte byte : UInt8) -> [Bit] {
        var byte = byte
        var bits = [Bit](repeating: .zero, count: 8)
        for i in 0..<8 {
            let currentBit = byte & 0x01
            if currentBit != 0 {
                bits[i] = .one
            }
            
            byte >>= 1
        }
        return bits
    }
    
    //Changes Are Coming
    func peripheral(
        _ peripheral: CBPeripheral,
        didUpdateValueFor characteristic: CBCharacteristic,
        error: Error?) {
        let count:UInt32 = 0;
        
        if characteristic.uuid == BEAN_SCRATCH_UUID {
//            characteristic.value!.getBytes(&count, length: Int(sizeof(UInt32)))
            bits(fromByte: UInt8(count))
            print("Changes Are C"+(NSString(format: "%llu", count) as String) as String)
        }
    }
    
    //Disconnect and Try Again
    func centralManager(
        _ central: CBCentralManager,
        didDisconnectPeripheral peripheral: CBPeripheral,
        error: Error?) {
        central.scanForPeripherals(withServices: nil, options: nil)
    }
    
    //UI생성
    func setUI(){
        setUISetting()
        setNavigationBarView()
        setGenderButtonView()
        setTopLabelView()
        setStartButtonView()
        setInfoSelectLabel()
        
        
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
        let navItem = UINavigationItem(title: "INIT ACCOUNT");
        navBar.setItems([navItem], animated: false);
        navBar.layer.shadowRadius = 2
        navBar.backgroundColor = UIColor.white
        self.view.addSubview(navBar);
    }
    
    //상단 텍스트 라벨 생성
    func setTopLabelView(){
        let textLabel1 = UILabel(frame: CGRect(x: 10, y: view.frame.height * 0.12, width: view.frame.width - 20, height: view.frame.height * 0.05))
        textLabel1.text = "Let me know about you"
        textLabel1.font = UIFont(name: "NanumBarunGothicOTFBold", size: 16)
        textLabel1.textColor = UIColor.darkGray
        view.addSubview(textLabel1)
        
        let textLabel2 = UILabel(frame: CGRect(x: 10, y: view.frame.height * 0.15, width: view.frame.width - 20, height: view.frame.height * 0.05))
        textLabel2.text = "Setting Interface For Better Service"
        textLabel2.font = UIFont(name: "NanumBarunGothicOTFLight", size: 12)
        textLabel2.textColor = UIColor.lightGray
        view.addSubview(textLabel2)
    }
    
    //성별 선택 버튼 생성
    func setGenderButtonView(){
        femaleButton = genderUIButton(frame: CGRect(x: 10, y: view.frame.height * 0.2 + 10, width: (view.frame.width * 0.5 - 15), height: view.frame.height * 0.1 - 20) , getText: "FEMALE")
        femaleButton.addTarget(FirstLoginViewController(), action: #selector(femaleButtonClicked), for: .touchUpInside)
        femaleButton.isSelected = true
        femaleButton.backgroundColor = UIColor.green
        femaleButton.genderLabel.textColor = UIColor.white
        view.addSubview(femaleButton)
        
        maleButton = genderUIButton(frame: CGRect(x: (view.frame.width * 0.5 + 5), y: view.frame.height * 0.2 + 10, width: (view.frame.width * 0.5 - 15), height: view.frame.height * 0.1 - 20) , getText: "MALE")
        maleButton.addTarget(FirstLoginViewController(), action: #selector(maleButtonClicked), for: .touchUpInside)
        maleButton.isSelected = false
        maleButton.backgroundColor = UIColor.white
        maleButton.genderLabel.textColor = UIColor.green
        view.addSubview(maleButton)
    }
    
    //나이, 직군 선택 뷰 생성
    func setInfoSelectLabel(){
        let ageLabel = ageSelectUIView(frame: CGRect(x: 10, y: view.frame.height * 0.3 + 10, width: (view.frame.width * 0.5 - 15), height: view.frame.height * 0.6 - 30), getText: "AGE")
        view.addSubview(ageLabel)
        
        let positionLabel = positionSelectUIView(frame: CGRect(x: (view.frame.width * 0.5 + 5), y: view.frame.height * 0.3 + 10, width: (view.frame.width * 0.5 - 15), height: view.frame.height * 0.6 - 30), getText: "POSITION")
        view.addSubview(positionLabel)
    }
    
    //로그인 버튼 생성
    func setStartButtonView() {
        let startButton = UIButton(frame: CGRect(x: 0, y: view.frame.height * 0.9, width: view.frame.width, height: view.frame.height * 0.1))
        startButton.setTitle("start", for: .normal)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.backgroundColor = UIColor.green
        startButton.titleLabel?.font = UIFont(name: "NanumBarunGothicOTFLight", size: 16)
        startButton.contentHorizontalAlignment = .center
        startButton.addTarget(FirstLoginViewController(), action: #selector(startButtonClicked), for: .touchUpInside)
        view.addSubview(startButton)
    }

    //여성 선택 버튼 실행
    @objc func femaleButtonClicked(){
        if(femaleButton.isSelected){
        }else{
            femaleButton.isSelected = true
            maleButton.isSelected = false
            femaleButton.backgroundColor = UIColor.green
            femaleButton.genderLabel.textColor = UIColor.white
            maleButton.backgroundColor = UIColor.white
            maleButton.genderLabel.textColor = UIColor.green
        }
    }
    
    //남성 선택 버튼 실행
    @objc func maleButtonClicked(){
        if(maleButton.isSelected){
        }else{
            maleButton.isSelected = true
            femaleButton.isSelected = false
            maleButton.backgroundColor = UIColor.green
            maleButton.genderLabel.textColor = UIColor.white
            femaleButton.backgroundColor = UIColor.white
            femaleButton.genderLabel.textColor = UIColor.green
        }
    }
    
    //시작 버튼 실행
    @objc func startButtonClicked(){
        print("start")
    
        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
//        let myViewController = TabBarViewController()
//        let navController = UINavigationController(rootViewController: myViewController)
//        self.present(navController, animated:true, completion: nil)

//        if(idTextField.text == ""){
//            myAlert("Login FAIL", message: "enter your ID")
//        }else if(pwTextField.text == ""){
//            myAlert("Login FAIL", message: "enter your PASSWORD")
//        }else{
//            start(idTextField.text!, pwTextField.text!)
//        }
    }
    
    //Alert 실행
    func myAlert(_ title : String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    //시작하기
    func start(_ id: String, _ pw: String){
        
        let myViewController = TabBarViewController()
        let navController = UINavigationController(rootViewController: myViewController)
        self.present(navController, animated:true, completion: nil)

        print("myViewController : ",myViewController)
        print("navController : ",navController)
//        let parameters = [
//            "id" : id,
//            "password" : pw,
//            ] as [String : Any]
        
//        Alamofire.request(loginURL, method: .post, parameters: parameters).responseJSON
//            {
//                response in
//                print(response)
//                let stringStatusCode = String(describing: response.response?.statusCode)
//                //printing response
//                if(response.response?.statusCode == 200){
//                    self.myAlert("Start SUCCESS", message: "WELCOME - SAFE NECK")
//                    self.navigationController?.popViewController(animated: true)
//                }else{
//                    print("STATUS CODE : " + stringStatusCode)
//                    self.myAlert("Start FAIL", message:"SERVER ERROR")
//                }
//        }
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
    
    //성별 선택을 위한 커스텀 UIButton
    class genderUIButton: UIButton {
        
        var text : String!
        var genderLabel : UILabel!
        
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
            genderLabel = UILabel(frame: CGRect(x: frame.width * 0.5 - 40, y: frame.height * 0.5 - 10, width: 80,  height: 20))
            genderLabel.text = text
            genderLabel.font = UIFont(name: "NanumBarunGothicOTFBold", size: 12)
            genderLabel.textAlignment = NSTextAlignment.center
            addSubview(genderLabel)
        }
    }
    
    //나이 선택을 위한 커스텀 UIView
    class ageSelectUIView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
        
        var text: String!
        var label : UILabel!
        var subLabel: UILabel!
        let ageStringValue: [String] = ["10대", "20대", "30대", "40대", "50대", "60대", "70 이상"]
        var pickerView: UIPickerView!
        
        func numberOfComponents(in pickerView: UIPickerView)->Int{
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String?{
            return ageStringValue[row]
        }
        
        func pickerView(_ pickerView: UIPickerView , numberOfRowsInComponent component: Int)->Int{
            return ageStringValue.count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            switch row {
            case 0...6:
                subLabel.text = ageStringValue[row]
                break
            default:
                subLabel.text = "Choose your AGE"
                break
            }
        }

        init(frame: CGRect, getText: String){
            super.init(frame: frame)
            self.text = getText
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.green.cgColor
            self.layer.cornerRadius = 5
            self.pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: frame.width - 20, height: frame.height - 60))
            pickerView.delegate = self
            pickerView.dataSource = self
            addSubview(self.pickerView)
            setLabelLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLabelLayOut(){
            label = UILabel(frame: CGRect(x: 10, y: 5, width: frame.width - 20, height: 30))
            label.text = text
            label.font = UIFont(name: "NanumBarunGothicOTF", size: 16)
            label.textColor = UIColor.green
            label.textAlignment = NSTextAlignment.center
            addSubview(label)
            
            subLabel = UILabel(frame: CGRect(x: 10, y: 45, width: frame.width - 20, height: 30))
            subLabel.textColor = UIColor.darkGray
            subLabel.font = UIFont(name: "NanumBarunGothicOTFLight", size: 10)
            subLabel.textAlignment = NSTextAlignment.center
            addSubview(subLabel)
        }
    }

    //포지션 선택을 위한 커스텀 UIView
    class positionSelectUIView: UIView, UIPickerViewDelegate, UIPickerViewDataSource{
        
        var text: String!
        var label : UILabel!
        var subLabel: UILabel!
        let positionStringValue: [String] = ["(초,중,고) 학생", "대학생", "직장인", "일반인","사무/금융직","연구원","엔지니어","건축","디자이너"]
        var pickerView: UIPickerView!
        
        func numberOfComponents(in pickerView: UIPickerView)->Int{
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int)->String?{
            return positionStringValue[row]
        }
        
        func pickerView(_ pickerView: UIPickerView , numberOfRowsInComponent component: Int)->Int{
            return positionStringValue.count
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
            switch row {
            case 0...4:
                subLabel.text = positionStringValue[row]
                break
            default:
                subLabel.text = "Choose your POSITION"
            }
        }

        init(frame: CGRect, getText: String){
            super.init(frame: frame)
            self.text = getText
            self.backgroundColor = .white
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.green.cgColor
            self.layer.cornerRadius = 5
            self.pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: frame.width - 20, height: frame.height - 60))
            pickerView.delegate = self
            pickerView.dataSource = self
            addSubview(self.pickerView)
            setLabelLayOut()
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setLabelLayOut(){
            label = UILabel(frame: CGRect(x: 10, y: 5, width: frame.width - 20, height: 30))
            label.text = text
            label.font = UIFont(name: "NanumBarunGothicOTF", size: 16)
            label.textColor = UIColor.green
            label.textAlignment = NSTextAlignment.center
            addSubview(label)
            
            subLabel = UILabel(frame: CGRect(x: 10, y: 45, width: frame.width - 20, height: 30))
            subLabel.textColor = UIColor.darkGray
            subLabel.font = UIFont(name: "NanumBarunGothicOTFLight", size: 10)
            subLabel.textAlignment = NSTextAlignment.center
            addSubview(subLabel)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if((self.navigationController?.viewControllers.count)! > 1)
        {
            self.navigationController?.viewControllers.removeFirst()
        }
    }
}
