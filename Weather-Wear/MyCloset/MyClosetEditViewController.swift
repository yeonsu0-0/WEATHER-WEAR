//
//  MyClosetEditViewController.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/29.
//

import UIKit
import CoreLocation
import AssetsLibrary

class MyClosetEditVeiwController: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.0)
        self.navigationController?.navigationBar.isHidden = true
        
        // 탭바 숨기기
        
        self.tabBarController?.tabBar.isHidden = true

        
        self.tempTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        self.dateTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        
        designArrow()
        designTextLabels()
        designSubmitButton()
        designPlusImageButton()
        
        getCurrentTemp()
        designDate()
        designImageView()
        
        
        imagePickerController.delegate = self
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            self.settingTextField()
        }
        
    }
    
    func settingTextField() {
        temp1view2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        templayer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
        tempTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        currentTempText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        date1Layer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
        date2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        dateTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        currentDateText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    let arrowLabel = UIImageView()
    
    @IBOutlet weak var arrowButtonEdit: UIButton!

    
    func designArrow() {
        
        let parent = self.view!

        arrowLabel.frame = CGRect(x: 0, y: 0, width: 20.5, height: 16)
        arrowLabel.backgroundColor = .white
        arrowLabel.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        arrowLabel.image = UIImage(named: "arrow")
        parent.addSubview(arrowLabel)
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 20.5).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 80).isActive = true
        
        arrowButtonEdit.frame = CGRect(x: 0, y: 0, width: 20.5, height: 16)
        parent.addSubview(arrowButtonEdit)
        arrowButtonEdit.translatesAutoresizingMaskIntoConstraints = false
        arrowButtonEdit.widthAnchor.constraint(equalToConstant: 20.5).isActive = true
        arrowButtonEdit.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowButtonEdit.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true
        arrowButtonEdit.topAnchor.constraint(equalTo: parent.topAnchor, constant: 80).isActive = true
        
    }
    
    func designTextLabels() {
        
        let parent = self.view!
        
        let textLabel1 = UILabel()
        textLabel1.frame = CGRect(x: 0, y: 0, width: 137, height: 23)
        textLabel1.backgroundColor = .white
        textLabel1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel1.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        textLabel1.text = "사진을 올려주세요"
        parent.addSubview(textLabel1)
        textLabel1.translatesAutoresizingMaskIntoConstraints = false
        textLabel1.widthAnchor.constraint(equalToConstant: 137).isActive = true
        textLabel1.heightAnchor.constraint(equalToConstant: 23).isActive = true
        textLabel1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        textLabel1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 115).isActive = true
        
        let textLabel2 = UILabel()
        textLabel2.frame = CGRect(x: 0, y: 0, width: 71, height: 23)
        textLabel2.backgroundColor = .white
        textLabel2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel2.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        textLabel2.text = "현재 기온"
        parent.addSubview(textLabel2)
        textLabel2.translatesAutoresizingMaskIntoConstraints = false
        textLabel2.widthAnchor.constraint(equalToConstant: 71).isActive = true
        textLabel2.heightAnchor.constraint(equalToConstant: 23).isActive = true
        textLabel2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        textLabel2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 341).isActive = true
        
        let textLabel3 = UILabel()
        textLabel3.frame = CGRect(x: 0, y: 0, width: 129, height: 18)
        textLabel3.backgroundColor = .white
        textLabel3.textColor = UIColor(red: 0.654, green: 0.654, blue: 0.654, alpha: 1)
        textLabel3.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        textLabel3.text = "(자동으로 설정됩니다)"
        parent.addSubview(textLabel3)
        textLabel3.translatesAutoresizingMaskIntoConstraints = false
        textLabel3.widthAnchor.constraint(equalToConstant: 129).isActive = true
        textLabel3.heightAnchor.constraint(equalToConstant: 18).isActive = true
        textLabel3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 93).isActive = true
        textLabel3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 345).isActive = true
        
        let textLabel4 = UILabel()
        textLabel4.frame = CGRect(x: 0, y: 0, width: 71, height: 23)
        textLabel4.backgroundColor = .white
        textLabel4.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel4.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        textLabel4.text = "기록일"
        parent.addSubview(textLabel4)
        textLabel4.translatesAutoresizingMaskIntoConstraints = false
        textLabel4.widthAnchor.constraint(equalToConstant: 71).isActive = true
        textLabel4.heightAnchor.constraint(equalToConstant: 23).isActive = true
        textLabel4.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        textLabel4.topAnchor.constraint(equalTo: parent.topAnchor, constant: 440).isActive = true
        
        let textLabel5 = UILabel()
        textLabel5.frame = CGRect(x: 0, y: 0, width: 129, height: 18)
        textLabel5.backgroundColor = .white
        textLabel5.textColor = UIColor(red: 0.654, green: 0.654, blue: 0.654, alpha: 1)
        textLabel5.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        textLabel5.text = "(자동으로 설정됩니다)"
        parent.addSubview(textLabel5)
        textLabel5.translatesAutoresizingMaskIntoConstraints = false
        textLabel5.widthAnchor.constraint(equalToConstant: 129).isActive = true
        textLabel5.heightAnchor.constraint(equalToConstant: 18).isActive = true
        textLabel5.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 71).isActive = true
        textLabel5.topAnchor.constraint(equalTo: parent.topAnchor, constant: 444).isActive = true
    }
    
    var png: Data?
    @IBOutlet weak var submitButton: UIButton!
    @IBAction func clickSubmitButton(_ sender: Any){
        print("작성 완료 버튼 눌렀을 때 실행되는 함수")
        
        var tempSubmit = 0
        var dateSubmit = ""
        var imageSubmit: UIImage? = nil
        
        if ( tempTextField.text == "" ) {
            tempSubmit = currentTemp1
        } else {
            tempSubmit = Int(tempTextField.text!)!
        }
        
        if ( dateTextField.text == "" ) {
            dateSubmit = currentDateText.text!
        } else {
            dateSubmit = dateTextField.text!
        }
        
        if ( imgView.image != nil ){
            imageSubmit = UIImage(data: png!)!
        }
        
        let newCell = MyClosetImageCell(num: MyClosetList.count+1,temp: tempSubmit,image: imageSubmit!,date: dateSubmit, favorite: false, select: false)
        
        MyClosetList.append(newCell)
        
        print(MyClosetList[MyClosetList.count-1])
        
        /*let vcName = self.storyboard?.instantiateViewController(withIdentifier: "MyClosetVC")
        vcName?.modalPresentationStyle = .fullScreen
        vcName?.modalTransitionStyle = .flipHorizontal
        self.present(vcName!, animated: true, completion: nil)*/
    }
    
    func designSubmitButton() {
        
        let parent = self.view!
        
        let backGround = UILabel()
        backGround.frame = CGRect(x: 0, y: 0, width: 375, height: 68)
        backGround.backgroundColor = .white
        let shadows = UIView()
        shadows.frame = backGround.frame
        shadows.clipsToBounds = false
        backGround.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 0)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 15
        layer0.shadowOffset = CGSize(width: 0, height: 0)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = backGround.frame
        shapes.clipsToBounds = true
        backGround.addSubview(shapes)
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        parent.addSubview(backGround)
        backGround.translatesAutoresizingMaskIntoConstraints = false
        backGround.widthAnchor.constraint(equalToConstant: 375).isActive = true
        backGround.heightAnchor.constraint(equalToConstant: 68).isActive = true
        backGround.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        backGround.topAnchor.constraint(equalTo: parent.topAnchor, constant: 744).isActive = true
        
        let textLabel = UILabel()
        textLabel.frame = CGRect(x: 0, y: 0, width: 71, height: 23)
        textLabel.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        textLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        textLabel.text = "작성 완료"
        parent.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.widthAnchor.constraint(equalToConstant: 71).isActive = true
        textLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 152).isActive = true
        textLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 767).isActive = true
        
        submitButton.frame = CGRect(x: 0, y: 0, width: 375, height: 68)
        parent.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.widthAnchor.constraint(equalToConstant: 375).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 68).isActive = true
        submitButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        submitButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 744).isActive = true
    }
    
    @IBOutlet weak var plusButton: UIButton!
    @IBAction func clickPlusButton(_ sender: Any){
        print("이미지 추가 버튼을 눌렀을 때 실행되는 함수")
        
        // 5-2) 권한 관련 작업 후 콜백 함수 실행(사진 라이브러리)
        authPhotoLibrary(self) {
            
            // .photoLibrary - Deprecated: Use PHPickerViewController instead. (iOS 14 버전 이상 지원)
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    
    let imgView = UIImageView()
        
    // 1) 이미지 피커 컨트롤러 추가
    let imagePickerController = UIImagePickerController()
        
    @IBAction func btnActCamera(_ sender: UIButton) {
        
        // 5-1) 권한 관련 작업 후 콜백 함수 실행(카메라)
        authDeviceCamera(self) {
            
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imgView.image = image
        }
        dismiss(animated: true, completion: nil)
        png = self.imgView.image?.pngData()
        
        print(png as Any)
        
        designX()
        
        
    }
    
    func designPlusImageButton() {
        
        let parent = self.view!
        
        let backGround = UILabel()
        backGround.frame = CGRect(x: 0, y: 0, width: 108, height: 141)
        backGround.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        backGround.layer.cornerRadius = 12
        parent.addSubview(backGround)
        backGround.translatesAutoresizingMaskIntoConstraints = false
        backGround.widthAnchor.constraint(equalToConstant: 108).isActive = true
        backGround.heightAnchor.constraint(equalToConstant: 141).isActive = true
        backGround.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        backGround.topAnchor.constraint(equalTo: parent.topAnchor, constant: 158).isActive = true
        
        
        let buttonPlus = UIImageView()
        buttonPlus.frame = CGRect(x: 0, y: 0, width: 46.77, height: 47)
        buttonPlus.image = UIImage(named: "plus")

        parent.addSubview(buttonPlus)
        buttonPlus.translatesAutoresizingMaskIntoConstraints = false
        buttonPlus.widthAnchor.constraint(equalToConstant: 46.77).isActive = true
        buttonPlus.heightAnchor.constraint(equalToConstant: 47).isActive = true
        buttonPlus.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 45.11).isActive = true
        buttonPlus.topAnchor.constraint(equalTo: parent.topAnchor, constant: 205).isActive = true
        
        plusButton.frame = CGRect(x: 0, y: 0, width: 108, height: 141)
        plusButton.layer.cornerRadius = 12
        parent.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalToConstant: 108).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 141).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        plusButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 158).isActive = true


    }
    
    func designImageView() {
        
        let parent = self.view!
        
        imgView.frame = CGRect(x: 0, y: 0, width: 109, height: 143)
        imgView.layer.cornerRadius = 12
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
    
        parent.addSubview(imgView)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.widthAnchor.constraint(equalToConstant: 109).isActive = true
        imgView.heightAnchor.constraint(equalToConstant: 143).isActive = true
        imgView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 133).isActive = true
        imgView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 158).isActive = true
        
    }
    
    func latitude() -> String {
        var locationManager:CLLocationManager!
        
        //위도와 경도
        var latitude: Double?
        
        //locationManager 인스턴스 생성 및 델리게이트 생성
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        //포그라운드 상태에서 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //위치업데이트
        locationManager.startUpdatingLocation()
        
        //위도 경도 가져오기
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        
        // info.list에 Privacy-Location 어쩌구 추가한 후에 동작
        // latitude 값을 String으로 변환
        let str_lat: String = String(format: "%f", latitude!)
        
        return str_lat
    }
    
    func longitude() -> String {
        var locationManager:CLLocationManager!
        
        var longitude: Double?
        
        //locationManager 인스턴스 생성 및 델리게이트 생성
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        //포그라운드 상태에서 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //위치업데이트
        locationManager.startUpdatingLocation()
        
        //위도 경도 가져오기
        let coor = locationManager.location?.coordinate
        longitude = coor?.longitude
        
        // info.list에 Privacy-Location 어쩌구 추가한 후에 동작
        // longtitude 값을 String으로 변환
        let str_lon: String = String(format: "%f", longitude!)
        
        
        return str_lon
    }
    
    func getCurrentTemp() {
        
        // API URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude())&lon=\(longitude())&appid=b308fb73c7d88403377ebbb42c75f617") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(MyClosetWeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    
                    self?.currentTemperature(weatherInfo: weatherInformation)
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
    
    
    var currentTemp1 = 0
    
    var tempView1 = UILabel()
    var templayer1 = CALayer()
    var tempView2 = UILabel()
    var temp1view2Layer1 = CALayer()
    var currentTempText = UILabel()
    let tempTextField = UITextField()
    func currentTemperature(weatherInfo: MyClosetWeatherInfo){
        
        let parent = self.view!
        
        tempView1.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        tempView1.backgroundColor = .white
        let shadows = UIView()
        shadows.frame = tempView1.frame
        shadows.clipsToBounds = false
        tempView1.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 17)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 9
        layer0.shadowOffset = CGSize(width: 0, height: 3)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = tempView1.frame
        shapes.clipsToBounds = true
        tempView1.addSubview(shapes)
        templayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        templayer1.bounds = shapes.bounds
        templayer1.position = shapes.center
        shapes.layer.addSublayer(templayer1)
        shapes.layer.cornerRadius = 17
        parent.addSubview(tempView1)
        tempView1.translatesAutoresizingMaskIntoConstraints = false
        tempView1.widthAnchor.constraint(equalToConstant: 80).isActive = true
        tempView1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempView1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        tempView1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 384).isActive = true
        
        currentTempText.textAlignment = .center
        currentTempText.frame = CGRect(x: 0, y: 0, width: 40, height: 18)
        currentTempText.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        currentTempText.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        currentTempText.text = "\(Int(weatherInfo.temp.temp - 273.15))°"
        currentTemp1 = (Int(weatherInfo.temp.temp - 273.15))
        parent.addSubview(currentTempText)
        currentTempText.translatesAutoresizingMaskIntoConstraints = false
        currentTempText.widthAnchor.constraint(equalToConstant: 40).isActive = true
        currentTempText.heightAnchor.constraint(equalToConstant: 18).isActive = true
        currentTempText.leadingAnchor.constraint(equalTo: tempView1.leadingAnchor, constant: 20).isActive = true
        currentTempText.topAnchor.constraint(equalTo: tempView1.topAnchor, constant: 6).isActive = true
        
        tempView2.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        tempView2.backgroundColor = .white
        let view2Shadows = UIView()
        view2Shadows.frame = tempView2.frame
        view2Shadows.clipsToBounds = false
        tempView2.addSubview(view2Shadows)
        let view2ShadowPath0 = UIBezierPath(roundedRect: view2Shadows.bounds, cornerRadius: 17)
        let view2Layer0 = CALayer()
        view2Layer0.shadowPath = view2ShadowPath0.cgPath
        view2Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        view2Layer0.shadowOpacity = 1
        view2Layer0.shadowRadius = 9
        view2Layer0.shadowOffset = CGSize(width: 0, height: 3)
        view2Layer0.bounds = view2Shadows.bounds
        view2Layer0.position = view2Shadows.center
        view2Shadows.layer.addSublayer(view2Layer0)
        let view2Shapes = UIView()
        view2Shapes.frame = tempView2.frame
        view2Shapes.clipsToBounds = true
        tempView2.addSubview(view2Shapes)
        temp1view2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        temp1view2Layer1.bounds = view2Shapes.bounds
        temp1view2Layer1.position = view2Shapes.center
        view2Shapes.layer.addSublayer(temp1view2Layer1)
        view2Shapes.layer.cornerRadius = 17
        parent.addSubview(tempView2)
        tempView2.translatesAutoresizingMaskIntoConstraints = false
        tempView2.widthAnchor.constraint(equalToConstant: 80).isActive = true
        tempView2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempView2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 107).isActive = true
        tempView2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 384).isActive = true
        
        tempTextField.frame = CGRect(x: 0, y: 0, width: 60, height: 26)
        tempTextField.placeholder = "직접 입력"
        tempTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempTextField.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempTextField.textAlignment = .center
        parent.addSubview(tempTextField)
        tempTextField.translatesAutoresizingMaskIntoConstraints = false
        tempTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        tempTextField.heightAnchor.constraint(equalToConstant: 26).isActive = true
        tempTextField.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 117).isActive = true
        tempTextField.topAnchor.constraint(equalTo: parent.topAnchor, constant: 386).isActive = true
        
    }
    
    
    
    @objc func textFieldDidChange(_ sender: Any?) {
        
        
        if ( tempTextField.text == "" ) {
            templayer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
            temp1view2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            tempTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
            currentTempText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            templayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            temp1view2Layer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
            
            tempTextField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            currentTempText.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        }
        
        if ( dateTextField.text == "" ) {
            date1Layer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
            date2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            dateTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
            currentDateText.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        } else {
            date2Layer1.backgroundColor = UIColor(red: 0.294, green: 0.329, blue: 0.967, alpha: 1).cgColor
            date1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            dateTextField.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            currentDateText.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        }
        
    }
    
    var dateView1 = UILabel()
    var date1Layer1 = CALayer()
    var dateView2 = UILabel()
    var date2Layer1 = CALayer()
    let dateTextField = UITextField()
    var currentDateText = UILabel()
    func designDate(){
        
        // 현재 날짜 데이터
        let nowDate = Date()
        // DateFormatter 설정
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "YY년 M월 dd일"
        // 현재 날짜 데이터를 문자열로 변환
        let nowDateStr = myDateFormatter.string(from: nowDate)
        
        let parent = self.view!
        
        dateView1.frame = CGRect(x: 0, y: 0, width: 120, height: 30)
        dateView1.backgroundColor = .white
        let shadows = UIView()
        shadows.frame = dateView1.frame
        shadows.clipsToBounds = false
        dateView1.addSubview(shadows)
        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 17)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 9
        layer0.shadowOffset = CGSize(width: 0, height: 3)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        shadows.layer.addSublayer(layer0)
        let shapes = UIView()
        shapes.frame = dateView1.frame
        shapes.clipsToBounds = true
        dateView1.addSubview(shapes)
        date1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        date1Layer1.bounds = shapes.bounds
        date1Layer1.position = shapes.center
        shapes.layer.addSublayer(date1Layer1)
        shapes.layer.cornerRadius = 17
        parent.addSubview(dateView1)
        dateView1.translatesAutoresizingMaskIntoConstraints = false
        dateView1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dateView1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateView1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        dateView1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 485).isActive = true
        
        currentDateText.textAlignment = .center
        currentDateText.frame = CGRect(x: 0, y: 0, width: 100, height: 18)
        currentDateText.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        currentDateText.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        currentDateText.text = nowDateStr
        parent.addSubview(currentDateText)
        currentDateText.translatesAutoresizingMaskIntoConstraints = false
        currentDateText.widthAnchor.constraint(equalToConstant: 100).isActive = true
        currentDateText.heightAnchor.constraint(equalToConstant: 18).isActive = true
        currentDateText.leadingAnchor.constraint(equalTo: dateView1.leadingAnchor, constant: 10).isActive = true
        currentDateText.topAnchor.constraint(equalTo: dateView1.topAnchor, constant: 6).isActive = true
        
        dateView2.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        dateView2.backgroundColor = .white
        let view2Shadows = UIView()
        view2Shadows.frame = dateView2.frame
        view2Shadows.clipsToBounds = false
        dateView2.addSubview(view2Shadows)
        let view2ShadowPath0 = UIBezierPath(roundedRect: view2Shadows.bounds, cornerRadius: 17)
        let view2Layer0 = CALayer()
        view2Layer0.shadowPath = view2ShadowPath0.cgPath
        view2Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        view2Layer0.shadowOpacity = 1
        view2Layer0.shadowRadius = 9
        view2Layer0.shadowOffset = CGSize(width: 0, height: 3)
        view2Layer0.bounds = view2Shadows.bounds
        view2Layer0.position = view2Shadows.center
        view2Shadows.layer.addSublayer(view2Layer0)
        let view2Shapes = UIView()
        view2Shapes.frame = dateView2.frame
        view2Shapes.clipsToBounds = true
        dateView2.addSubview(view2Shapes)
        date2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        date2Layer1.bounds = view2Shapes.bounds
        date2Layer1.position = view2Shapes.center
        view2Shapes.layer.addSublayer(date2Layer1)
        view2Shapes.layer.cornerRadius = 17
        parent.addSubview(dateView2)
        dateView2.translatesAutoresizingMaskIntoConstraints = false
        dateView2.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dateView2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dateView2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 147).isActive = true
        dateView2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 485).isActive = true
        
        dateTextField.frame = CGRect(x: 0, y: 0, width: 60, height: 26)
        dateTextField.placeholder = "직접 입력"
        dateTextField.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        dateTextField.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        dateTextField.textAlignment = .center
        parent.addSubview(dateTextField)
        dateTextField.translatesAutoresizingMaskIntoConstraints = false
        dateTextField.widthAnchor.constraint(equalToConstant: 60).isActive = true
        dateTextField.heightAnchor.constraint(equalToConstant: 26).isActive = true
        dateTextField.leadingAnchor.constraint(equalTo: dateView2.leadingAnchor, constant: 10).isActive = true
        dateTextField.topAnchor.constraint(equalTo: dateView2.topAnchor, constant: 2).isActive = true
        
    }
    
    @IBOutlet weak var xButton: UIButton!
    @IBAction func clickXButton(_ sender: Any){
        imgView.layer.isHidden = true
        xButton.isHidden = true
    }
    
    
    func designX() {
        
        imgView.layer.isHidden = false
        xButton.isHidden = false
        
        let parent = self.view!
        
        let xView = UIImageView()
        xView.frame = CGRect(x: 0, y: 0, width: 8.67, height: 8.67)
        xView.image = UIImage(named: "x")
        parent.addSubview(xView)
        xView.translatesAutoresizingMaskIntoConstraints = false
        xView.widthAnchor.constraint(equalToConstant: 8.67).isActive = true
        xView.heightAnchor.constraint(equalToConstant: 8.67).isActive = true
        xView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 223.07).isActive = true
        xView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169.43).isActive = true
        
        xButton.frame = CGRect(x: 0, y: 0, width: 8.67, height: 8.67)
        parent.addSubview(xButton)
        xButton.translatesAutoresizingMaskIntoConstraints = false
        xButton.widthAnchor.constraint(equalToConstant: 8.67).isActive = true
        xButton.heightAnchor.constraint(equalToConstant: 8.67).isActive = true
        xButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 223.07).isActive = true
        xButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169.43).isActive = true
        
        
    }
}

