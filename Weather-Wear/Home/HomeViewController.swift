//
//  HomeViewController.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/23.
//

import UIKit
import SafariServices
import CoreLocation
import Gifu

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로고 이미지 표시
        logoImage.image = UIImage(named: "logo.png")
        
        // 날짜 표시
        configureDate()
        
        // 날씨 표시
        self.getCurrentTemp()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.getCurrentWeather()
        }
        
        // 디자인 구현
        designWall()
        designDateCity()
        designLogo()
        
        // 버튼1, 버튼2, 버튼3 라벨 숨기기
        button1Label.layer.isHidden = true
        button1Image.layer.isHidden = true
        button1Text.layer.isHidden = true
        button1Button.layer.isHidden = true
        button2Label.layer.isHidden = true
        button2Image.layer.isHidden = true
        button2Text.layer.isHidden = true
        button2Button.layer.isHidden = true
        button3Label.layer.isHidden = true
        button3Image.layer.isHidden = true
        button3Text.layer.isHidden = true
        button3Button.layer.isHidden = true
    }
    
    // 날짜
    var dateLabel = UILabel()
    
    // 도시
    var cityLabel = UILabel()
    
    // 로고 이미지
    var logoImage = UIImageView()
    
    // 최저 / 최고 / 현재 온도
    var minTempLabel = UILabel()
    var maxTempLabel = UILabel()
    var curTempLabel = UILabel()
    
    // 날씨 이미지 & 날씨 설명
    var weatherImage = UILabel()
    var weatherLabel = UILabel()
    var weatherName = "없음"
    
    // 캐릭터 이미지
    var characterImage = GIFImageView()
    
    // 버튼1 & 버튼1 라벨
    @IBOutlet weak var button1: UIButton!
    var button1Circle = UILabel()
    var button1Star = UIImageView()
    var button1Label = UILabel()
    var button1Image = UILabel()
    var button1Text = UILabel()
    @IBOutlet weak var button1Button: UIButton!
    // 버튼2 & 버튼2 라벨
    @IBOutlet weak var button2: UIButton!
    var button2Circle = UILabel()
    var button2Star = UIImageView()
    var button2Label = UILabel()
    var button2Image = UILabel()
    var button2Text = UILabel()
    @IBOutlet weak var button2Button: UIButton!
    // 버튼3 & 버튼3 라벨
    @IBOutlet weak var button3: UIButton!
    var button3Circle = UILabel()
    var button3Star = UIImageView()
    var button3Label = UILabel()
    var button3Image = UILabel()
    var button3Text = UILabel()
    @IBOutlet weak var button3Button: UIButton!
    
    // 화면에 날짜 표시
    func configureDate(){
        
        // 현재 날짜 데이터
        let nowDate = Date()
        // DateFormatter 설정
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MM월 dd일"
        // 현재 날짜 데이터를 문자열로 변환
        let nowDateStr = myDateFormatter.string(from: nowDate)
        // 라벨에 데이터 입력
        self.dateLabel.text = nowDateStr
        
    }
    
    // 화면에 날씨 표시
    func configureView(weatherInfo: HomeWeatherInfo){
        
        // 도시 표시 ( 라벨에 데이터 입력 )
        if ( weatherInfo.name == "Yongsan" ) { self.cityLabel.text = "용산구" }
        else if ( weatherInfo.name == "Jamwon-dong" ) { self.cityLabel.text = "잠원동" }
        else if ( weatherInfo.name == "Kŭmhosamga-dong" ) { self.cityLabel.text = "금호동" }
        else { self.cityLabel.text = weatherInfo.name }
        print(weatherInfo.name)
        
        // 온도 표시 - min, max, current ( 라벨에 데이터 입력 )
        self.minTempLabel.text = "\(Int(weatherInfo.temp.minTemp - 273.15 - 3))°"
        self.maxTempLabel.text = "\(Int(weatherInfo.temp.maxTemp - 273.15 + 5))°"
        self.curTempLabel.text = "\(Int(weatherInfo.temp.temp - 273.15))°"
        // 날씨 표시 - 한국어로 ( 라벨에 데이터 입력 )
        if let weather = weatherInfo.weather.first {
            self.weatherLabel.text = weather.description
            print(weather.description)
        }
        
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
        
        //let str_lat = "37.541"
        
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
        
        //let str_lon = "126.986"
        
        return str_lon
    }
    
    // 날씨 및 온도 API 정보 받기
    func getCurrentTemp() {
        
        // API URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude())&lon=\(longitude())&lang=kr&appid=b308fb73c7d88403377ebbb42c75f617") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(HomeWeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    
                    // configureView 사용해 정보 입력
                    self?.configureView(weatherInfo: weatherInformation)
                    
                    self?.designTemperature(weatherInfo: weatherInformation)
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
    
    // 날씨별 이미지 전환
    func getCurrentWeather() {
        
        // API URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude())&lon=\(longitude())&appid=b308fb73c7d88403377ebbb42c75f617") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { [weak self] data, response, error in
            let successRange = (200..<300)
            guard let data = data, error == nil else { return }
            let decoder = JSONDecoder()
            if let response = response as? HTTPURLResponse, successRange.contains(response.statusCode) {
                guard let weatherInformation = try? decoder.decode(HomeWeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    
                    self?.designCharacter(weatherInfo: weatherInformation)
                    
                    self?.designWeather(weatherInfo: weatherInformation)
                    
                    self?.designButton1(weatherInfo: weatherInformation)
                    self?.designButton2(weatherInfo: weatherInformation)
                    self?.designButton3(weatherInfo: weatherInformation)
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
    
    // 버튼1 클릭 시 Action
    @IBAction func button1(_ sender: Any){
        
        button1Label.layer.isHidden = false
        button1Image.layer.isHidden = false
        button1Text.layer.isHidden = false
        button1Button.layer.isHidden = false
        
        button1.layer.isHidden = true
        button1Circle.layer.isHidden = true
        button1Star.layer.isHidden = true
        
        if ( button2Label.layer.isHidden == false && button2Image.layer.isHidden == false && button2Text.layer.isHidden == false && button2Button.layer.isHidden == false ) {

            button2Label.layer.isHidden = true
            button2Image.layer.isHidden = true
            button2Text.layer.isHidden = true
            button2Button.layer.isHidden = true
            
            button2.layer.isHidden = false
            button2Circle.layer.isHidden = false
            button2Star.layer.isHidden = false
        }
        
        if ( button3Label.layer.isHidden == false && button3Image.layer.isHidden == false && button3Text.layer.isHidden == false && button3Button.layer.isHidden == false ) {
            button3Label.layer.isHidden = true
            button3Image.layer.isHidden = true
            button3Text.layer.isHidden = true
            button3Button.layer.isHidden = true
            
            button3.layer.isHidden = false
            button3Circle.layer.isHidden = false
            button3Star.layer.isHidden = false
        }
        
    }
    
    // 버튼1 라벨 속 버튼 클릭 시 Action
    @IBAction func button1Click(_ sender: Any) {
        
        let selectItem: String = button1Text.text!
        let urlString: String = "https://www.musinsa.com/search/musinsa/integration?type=&q="+selectItem
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let Url = URL(string: encodedString)!
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url as URL)
        self.present(SafariView, animated: true, completion: nil)
        
    }
    
    // 버튼2 클릭 시 Action
    @IBAction func button2(_ sender: Any) {
        
        button2Label.layer.isHidden = false
        button2Image.layer.isHidden = false
        button2Text.layer.isHidden = false
        button2Button.layer.isHidden = false
        
        button2.layer.isHidden = true
        button2Circle.layer.isHidden = true
        button2Star.layer.isHidden = true
        
        if ( button1Label.layer.isHidden == false && button1Image.layer.isHidden == false && button1Text.layer.isHidden == false && button1Button.layer.isHidden == false ) {
            button1Label.layer.isHidden = true
            button1Image.layer.isHidden = true
            button1Text.layer.isHidden = true
            button1Button.layer.isHidden = true
            
            button1.layer.isHidden = false
            button1Circle.layer.isHidden = false
            button1Star.layer.isHidden = false
        }
        
        if ( button3Label.layer.isHidden == false && button3Image.layer.isHidden == false && button3Text.layer.isHidden == false && button3Button.layer.isHidden == false ) {
            button3Label.layer.isHidden = true
            button3Image.layer.isHidden = true
            button3Text.layer.isHidden = true
            button3Button.layer.isHidden = true
            
            button3.layer.isHidden = false
            button3Circle.layer.isHidden = false
            button3Star.layer.isHidden = false
        }
        
    }
    
    // 버튼2 라벨 속 버튼 클릭 시 Action
    @IBAction func button2Click(_ sender: Any) {
        
        let selectItem: String = button2Text.text!
        let urlString: String = "https://www.musinsa.com/search/musinsa/integration?type=&q="+selectItem
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let Url = URL(string: encodedString)!
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url as URL)
        self.present(SafariView, animated: true, completion: nil)
        
    }
    
    // 버튼3 클릭 시 Action
    @IBAction func button3(_ sender: Any) {
        
        button3Label.layer.isHidden = false
        button3Image.layer.isHidden = false
        button3Text.layer.isHidden = false
        button3Button.layer.isHidden = false
        
        button3.layer.isHidden = true
        button3Circle.layer.isHidden = true
        button3Star.layer.isHidden = true
        
        if ( button1Label.layer.isHidden == false && button1Image.layer.isHidden == false && button1Text.layer.isHidden == false && button1Button.layer.isHidden == false ) {
            button1Label.layer.isHidden = true
            button1Image.layer.isHidden = true
            button1Text.layer.isHidden = true
            button1Button.layer.isHidden = true
            
            button1.layer.isHidden = false
            button1Circle.layer.isHidden = false
            button1Star.layer.isHidden = false
        }
        
        if ( button2Label.layer.isHidden == false && button2Image.layer.isHidden == false && button2Text.layer.isHidden == false && button2Button.layer.isHidden == false ) {
            button2Label.layer.isHidden = true
            button2Image.layer.isHidden = true
            button2Text.layer.isHidden = true
            button2Button.layer.isHidden = true
            
            button2.layer.isHidden = false
            button2Circle.layer.isHidden = false
            button2Star.layer.isHidden = false
        }
        
    }
    
    // 버튼2 라벨 속 버튼 클릭 시 Action
    @IBAction func button3Click(_ sender: Any) {
        
        let selectItem: String = button3Text.text!
        let urlString: String = "https://www.musinsa.com/search/musinsa/integration?type=&q="+selectItem
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let Url = URL(string: encodedString)!
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url as URL)
        self.present(SafariView, animated: true, completion: nil)
        
    }
    
    // 배경 선택 시 버튼 사라짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if ( button1Label.layer.isHidden == false && button1Image.layer.isHidden == false && button1Text.layer.isHidden == false && button1Button.layer.isHidden == false ) {
            button1Label.layer.isHidden = true
            button1Image.layer.isHidden = true
            button1Text.layer.isHidden = true
            button1Button.layer.isHidden = true
            
            button1.layer.isHidden = false
            button1Circle.layer.isHidden = false
            button1Star.layer.isHidden = false
        }
        
        if ( button2Label.layer.isHidden == false && button2Image.layer.isHidden == false && button2Text.layer.isHidden == false && button2Button.layer.isHidden == false ) {
            button2Label.layer.isHidden = true
            button2Image.layer.isHidden = true
            button2Text.layer.isHidden = true
            button2Button.layer.isHidden = true
            
            button2.layer.isHidden = false
            button2Circle.layer.isHidden = false
            button2Star.layer.isHidden = false
        }
        
        if ( button3Label.layer.isHidden == false && button3Image.layer.isHidden == false && button3Text.layer.isHidden == false && button3Button.layer.isHidden == false ) {
            button3Label.layer.isHidden = true
            button3Image.layer.isHidden = true
            button3Text.layer.isHidden = true
            button3Button.layer.isHidden = true
            
            button3.layer.isHidden = false
            button3Circle.layer.isHidden = false
            button3Star.layer.isHidden = false
        }
        
    }
    
    
    // 디자인 -----------------------------------
    
    // 배경
    func designWall() {
        
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0.984, green: 0.992, blue: 1, alpha: 1).cgColor
        
    }
    
    // 날짜 & 도시
    func designDateCity() {
        
        let parent = self.view!
        
        // 날짜
        dateLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 18)
        dateLabel.backgroundColor = .white
        dateLabel.textColor = UIColor(red: 0.542, green: 0.542, blue: 0.542, alpha: 1)
        dateLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        parent.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 46).isActive = true
        
        
        // 도시
        cityLabel.frame = CGRect(x: 0, y: 0, width: 50, height: 23)
        cityLabel.backgroundColor = .white
        cityLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        cityLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        parent.addSubview(cityLabel)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        cityLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        cityLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        cityLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 68).isActive = true
        
    }
    
    // 로고 이미지
    func designLogo() {
        
        let parent = self.view!
        
        logoImage.frame = CGRect(x: 0, y: 0, width: 52.44, height: 34.15)
        logoImage.backgroundColor = .white
        logoImage.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        parent.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 52.44).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 34.15).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 302.56).isActive = true
        logoImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 52).isActive = true
        
    }
    
    // 최저 & 최고 & 현재 온도
    func designTemperature(weatherInfo: HomeWeatherInfo) {
        
        let parent = self.view!
        
        // 최저 온도 배경
        let minTempBackground = UILabel()
        minTempBackground.frame = CGRect(x: 0, y: 0, width: 46, height: 28)
        minTempBackground.backgroundColor = .white
        let minTempShadows = UIView()
        minTempShadows.frame = minTempBackground.frame
        minTempShadows.clipsToBounds = false
        minTempBackground.addSubview(minTempShadows)
        let minTempShadowPath = UIBezierPath(roundedRect: minTempShadows.bounds, cornerRadius: 17)
        let minTempLayer0 = CALayer()
        minTempLayer0.shadowPath = minTempShadowPath.cgPath
        minTempLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        minTempLayer0.shadowOpacity = 1
        minTempLayer0.shadowRadius = 9
        minTempLayer0.shadowOffset = CGSize(width: 0, height: 3)
        minTempLayer0.bounds = minTempShadows.bounds
        minTempLayer0.position = minTempShadows.center
        minTempShadows.layer.addSublayer(minTempLayer0)
        let minTempShapes = UIView()
        minTempShapes.frame = minTempBackground.frame
        minTempShapes.clipsToBounds = true
        minTempBackground.addSubview(minTempShapes)
        let minTempLayer1 = CALayer()
        minTempLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        minTempLayer1.bounds = minTempShapes.bounds
        minTempLayer1.position = minTempShapes.center
        minTempShapes.layer.addSublayer(minTempLayer1)
        minTempShapes.layer.cornerRadius = 17
        parent.addSubview(minTempBackground)
        minTempBackground.translatesAutoresizingMaskIntoConstraints = false
        minTempBackground.widthAnchor.constraint(equalToConstant: 43).isActive = true
        minTempBackground.heightAnchor.constraint(equalToConstant: 28).isActive = true
        minTempBackground.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 140).isActive = true
        minTempBackground.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
        
        // 최저 온도
        minTempLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        minTempLabel.backgroundColor = .white
        minTempLabel.textColor = UIColor(red: 0.925, green: 0.243, blue: 0.243, alpha: 1)
        minTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        minTempLabel.font = UIFont.systemFont(ofSize: 14) // 폰트 넣으면 없애야함
        minTempLabel.textAlignment = .center
        parent.addSubview(minTempLabel)
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        minTempLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        minTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 149).isActive = true
        minTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 121).isActive = true
        
        // 최고 온도 배경
        let maxTempBackground = UILabel()
        maxTempBackground.frame = CGRect(x: 0, y: 0, width: 46, height: 28)
        maxTempBackground.backgroundColor = .white
        let maxTempShadows = UIView()
        maxTempShadows.frame = maxTempBackground.frame
        maxTempShadows.clipsToBounds = false
        maxTempBackground.addSubview(maxTempShadows)
        let maxTempShadowPath = UIBezierPath(roundedRect: maxTempShadows.bounds, cornerRadius: 17)
        let maxTempLayer0 = CALayer()
        maxTempLayer0.shadowPath = maxTempShadowPath.cgPath
        maxTempLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        maxTempLayer0.shadowOpacity = 1
        maxTempLayer0.shadowRadius = 9
        maxTempLayer0.shadowOffset = CGSize(width: 0, height: 3)
        maxTempLayer0.bounds = maxTempShadows.bounds
        maxTempLayer0.position = maxTempShadows.center
        maxTempShadows.layer.addSublayer(maxTempLayer0)
        let maxTempShapes = UIView()
        maxTempShapes.frame = maxTempBackground.frame
        maxTempShapes.clipsToBounds = true
        maxTempBackground.addSubview(maxTempShapes)
        let maxTempLayer1 = CALayer()
        maxTempLayer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        maxTempLayer1.bounds = maxTempShapes.bounds
        maxTempLayer1.position = maxTempShapes.center
        maxTempShapes.layer.addSublayer(maxTempLayer1)
        maxTempShapes.layer.cornerRadius = 17
        parent.addSubview(maxTempBackground)
        maxTempBackground.translatesAutoresizingMaskIntoConstraints = false
        maxTempBackground.widthAnchor.constraint(equalToConstant: 43).isActive = true
        maxTempBackground.heightAnchor.constraint(equalToConstant: 28).isActive = true
        maxTempBackground.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 194).isActive = true
        maxTempBackground.topAnchor.constraint(equalTo: parent.topAnchor, constant: 116).isActive = true
        
        // 최고 온도
        maxTempLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        maxTempLabel.backgroundColor = .white
        maxTempLabel.textColor = UIColor(red: 0.294, green: 0.322, blue: 0.965, alpha: 1)
        maxTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        maxTempLabel.font = UIFont.systemFont(ofSize: 14) // 폰트 넣으면 없애야함
        maxTempLabel.textAlignment = .center
        parent.addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxTempLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        maxTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        maxTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 121).isActive = true
        
        // 현재 온도
        curTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 70)
        curTempLabel.font = UIFont.systemFont(ofSize: 70) // 폰트 넣으면 없애야함
        curTempLabel.sizeToFit()
        let gradient = UIImage.gradientImage(bounds: curTempLabel.bounds, colors: [UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0), UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)])
        curTempLabel.textColor = UIColor(patternImage: gradient)
        curTempLabel.textAlignment = .center
        parent.addSubview(curTempLabel)
        curTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // curTempLabel의 넓이
        let curTempWidth = curTempLabel.bounds.width
        
        // 전체 넓이에서 넓이를 빼고 나누기 2
        let startPoint = ( 380 - curTempWidth ) / 2
        
        curTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: startPoint).isActive = true
        curTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 160).isActive = true
        
    }
    
    // 날씨 이미지 & 날씨 설명
    func designWeather(weatherInfo: HomeWeatherInfo) {
        
        var weatherImageName = "없음"
        
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description
        }
        
        switch(weatherName) {
        case "clear sky" :
            weatherImageName = "clear_sky.jpg"
            break
        case "few clouds" :
            weatherImageName = "few_clouds.jpg"
            break
        case "scattered clouds" :
            weatherImageName = "scattered_clouds.jpg"
            break
        case "broken clouds","overcast clouds" :
            weatherImageName = "broken_clouds.jpg"
            break
        case "light intensity drizzle","drizzle","heavy intensity drizzle","light intensity drizzle rain","drizzle rain","heavy intensity drizzle rain","shower rain and drizzle","heavy shower rain and drizzle","shower drizzle","light intensity shower rain","shower rain","heavy intensity shower rain","ragged shower rain" :
            weatherImageName = "shower_rain.jpg"
            break
        case "rain","light rain","moderate rain","heavy intensity rain","very heavy rain","extreme rain" :
            weatherImageName = "rain.jpg"
            break
        case "thunderstorm with light rain","thunderstorm with rain","thunderstorm with heavy rain","light thunderstorm","thunderstorm","heavy thunderstorm","ragged thunderstorm","thunderstorm with light drizzle","thunderstorm with drizzle","thunderstorm with heavy drizzle" :
            weatherImageName = "thunderstorm.jpg"
            break
        case "snow","freezing rain","light snow","Heavy snow","Sleet","Light shower sleet","Shower sleet","Light rain and snow","Rain and snow","Light shower snow","Shower snow","Heavy shower snow" :
            weatherImageName = "snow.jpg"
            break
        case "mist","Smoke","Haze","sand/ dust whirls","fog","sand","dust","volcanic ash","squalls","tornado" :
            weatherImageName = "mist.jpg"
            break
        default:
            break
        }
        
        let parent = self.view!
        
        // 날씨 이미지
        weatherImage.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        weatherImage.backgroundColor = .white
        let layerWeatherImage = CALayer()
        layerWeatherImage.contents = UIImage(named: weatherImageName)?.cgImage
        layerWeatherImage.bounds = weatherImage.bounds
        layerWeatherImage.position = weatherImage.center
        weatherImage.layer.addSublayer(layerWeatherImage)
        parent.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // 날씨 설명
        weatherLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 18)
        weatherLabel.font = UIFont.systemFont(ofSize: 18)
        weatherLabel.sizeToFit()
        
        print(weatherLabel.bounds)
        weatherLabel.backgroundColor = .white
        weatherLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        parent.addSubview(weatherLabel)
        weatherLabel.textAlignment = .center
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // weatherImage의 넓이
        let imageWidth = weatherImage.bounds.width
        
        // weatherLabel의 넓이
        let labelWidth = weatherLabel.bounds.width
        
        // 전체 넓이에서 둘의 넓이를 합친 것을 빼고 나누기 2
        let startPoint = (380 - imageWidth - labelWidth) / 2
        
        weatherImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: startPoint - 4).isActive = true
        weatherImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 252.5).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: startPoint + 35).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 256).isActive = true
        
    }
    
    func designButton1(weatherInfo: HomeWeatherInfo) {
        
        // 현재 온도
        var currentTemp = 0
    
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description // 현재 날씨
            currentTemp = Int(weatherInfo.temp.temp - 273.15) // 현재 온도
        }
        
        // 온도 조건을 만족하는 물품 ( 배열 )
        var button1List:[HomeWearInfo1] = []
        
        // 조건을 충족할 경우 배열에 추가
        for x in 0...wearList1.count-1 {
            if ( currentTemp < wearList1[x].max_temp && wearList1[x].min_temp < currentTemp ) {
                button1List.append(wearList1[x])
            }
        }
        
        let randomNum = Int.random(in: 0...button1List.count-1)
        
        // 아이템 설정
        let item = button1List[randomNum]
        
        let parent = self.view!
        
        // button1
        button1.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button1.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        parent.addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 97).isActive = true
        button1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 556).isActive = true
        
        // button1 - button1Circle
        button1Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let button1CircleShadows = UIView()
        button1CircleShadows.frame = button1Circle.frame
        button1CircleShadows.clipsToBounds = false
        button1Circle.addSubview(button1CircleShadows)
        let button1CircleShadowPath0 = UIBezierPath(roundedRect: button1CircleShadows.bounds, cornerRadius: 0)
        let button1CircleLayer0 = CALayer()
        button1CircleLayer0.shadowPath = button1CircleShadowPath0.cgPath
        button1CircleLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button1CircleLayer0.shadowOpacity = 1
        button1CircleLayer0.shadowRadius = 6
        button1CircleLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button1CircleLayer0.bounds = button1CircleShadows.bounds
        button1CircleLayer0.position = button1CircleShadows.center
        button1CircleShadows.layer.addSublayer(button1CircleLayer0)
        let button1CircleShapes = UIView()
        button1CircleShapes.frame = button1Circle.frame
        button1CircleShapes.clipsToBounds = true
        button1Circle.addSubview(button1CircleShapes)
        let button1CircleLayer1 = CALayer()
        button1CircleLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        button1CircleLayer1.bounds = button1CircleShapes.bounds
        button1CircleLayer1.position = button1CircleShapes.center
        button1CircleShapes.layer.addSublayer(button1CircleLayer1)
        button1CircleShapes.layer.borderWidth = 1.5
        button1CircleShapes.layer.cornerRadius = 15
        button1CircleShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button1Circle)
        button1Circle.translatesAutoresizingMaskIntoConstraints = false
        button1Circle.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button1Circle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button1Circle.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 97).isActive = true
        button1Circle.topAnchor.constraint(equalTo: parent.topAnchor, constant: 556).isActive = true
        
        // button1 - button1Star
        button1Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button1Star.image = UIImage(named: "vector.png")
        parent.addSubview(button1Star)
        button1Star.translatesAutoresizingMaskIntoConstraints = false
        button1Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button1Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button1Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 105).isActive = true
        button1Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 563).isActive = true
        
        // button1Label
        button1Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        let button1LabelShadows = UIView()
        button1LabelShadows.frame = button1Label.frame
        button1LabelShadows.clipsToBounds = false
        button1Label.addSubview(button1LabelShadows)
        let button1LabelshadowPath = UIBezierPath(roundedRect: button1LabelShadows.bounds, cornerRadius: 54)
        let button1Labellayer0 = CALayer()
        button1Labellayer0.shadowPath = button1LabelshadowPath.cgPath
        button1Labellayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        button1Labellayer0.shadowOpacity = 1
        button1Labellayer0.shadowRadius = 16
        button1Labellayer0.shadowOffset = CGSize(width: 0, height: 8)
        button1Labellayer0.bounds = button1LabelShadows.bounds
        button1Labellayer0.position = button1LabelShadows.center
        button1LabelShadows.layer.addSublayer(button1Labellayer0)
        let button1Labelshapes = UIView()
        button1Labelshapes.frame = button1Label.frame
        button1Labelshapes.clipsToBounds = true
        button1Label.addSubview(button1Labelshapes)
        let button1Labellayer1 = CALayer()
        button1Labellayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.71).cgColor
        button1Labellayer1.bounds = button1Labelshapes.bounds
        button1Labellayer1.position = button1Labelshapes.center
        button1Labelshapes.layer.addSublayer(button1Labellayer1)
        button1Labelshapes.layer.cornerRadius = 50
        button1Labelshapes.layer.borderWidth = 1.5
        button1Labelshapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button1Label)
        button1Label.translatesAutoresizingMaskIntoConstraints = false
        button1Label.widthAnchor.constraint(equalToConstant: 242.5).isActive = true
        button1Label.heightAnchor.constraint(equalToConstant: 97.85).isActive = true
        button1Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 76).isActive = true
        button1Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 523).isActive = true
        
        // button1Text
        button1Text.frame = CGRect(x: 0, y: 0, width: 69, height: 21)
        button1Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button1Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        button1Text.textAlignment = .center
        button1Text.text = item.name
        parent.addSubview(button1Text)
        button1Text.translatesAutoresizingMaskIntoConstraints = false
        button1Text.widthAnchor.constraint(equalToConstant: 69).isActive = true
        button1Text.heightAnchor.constraint(equalToConstant: 21).isActive = true
        button1Text.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 174).isActive = true
        button1Text.topAnchor.constraint(equalTo: parent.topAnchor, constant: 561).isActive = true
        
        // button1Button
        button1Button.frame = CGRect(x: 0, y: 0, width: 8, height: 17)
        button1Button.tintColor = .white
        
        let button1ButtonImage = CALayer()
        button1ButtonImage.contents = UIImage(named: "buttonVector")?.cgImage
        button1ButtonImage.bounds = button1Button.bounds
        button1ButtonImage.position = button1Button.center
        button1Button.layer.addSublayer(button1ButtonImage)
        
        parent.addSubview(button1Button)
        button1Button.translatesAutoresizingMaskIntoConstraints = false
        button1Button.widthAnchor.constraint(equalToConstant: 8).isActive = true
        button1Button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button1Button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 270).isActive = true
        button1Button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 563).isActive = true
        
        // button1Image
        button1Image.frame = CGRect(x: 0, y: 0, width: 67.04, height: 67.04)
        button1Image.backgroundColor = .none
        let button1ImageShadows = UIView()
        button1ImageShadows.frame = button1Image.frame
        button1ImageShadows.clipsToBounds = false
        button1Image.addSubview(button1ImageShadows)
        let button1ImageShadowPath = UIBezierPath(roundedRect: button1ImageShadows.bounds, cornerRadius: 33)
        let button1ImageLayer0 = CALayer()
        button1ImageLayer0.shadowPath = button1ImageShadowPath.cgPath
        button1ImageLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button1ImageLayer0.shadowOpacity = 1
        button1ImageLayer0.shadowRadius = 4
        button1ImageLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button1ImageLayer0.bounds = button1ImageShadows.bounds
        button1ImageLayer0.position = button1ImageShadows.center
        button1ImageShadows.layer.addSublayer(button1ImageLayer0)
        let button1ImageShapes = UIView()
        button1ImageShapes.frame = button1Image.frame
        button1ImageShapes.clipsToBounds = true
        button1Image.addSubview(button1ImageShapes)
        let button1ImageImage = UIImage(named: item.image)?.cgImage
        let button1ImageLayer1 = CALayer()
        button1ImageLayer1.contents = button1ImageImage
        button1ImageLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.2, tx: 0, ty: -0.1))
        button1ImageLayer1.bounds = button1ImageShapes.bounds
        button1ImageLayer1.position = button1ImageShapes.center
        button1ImageShapes.layer.addSublayer(button1ImageLayer1)
        button1ImageShapes.layer.cornerRadius = 33
        button1ImageShapes.layer.borderWidth = 1
        button1ImageShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button1Image)
        button1Image.translatesAutoresizingMaskIntoConstraints = false
        button1Image.widthAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.heightAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 92).isActive = true
        button1Image.topAnchor.constraint(equalTo: parent.topAnchor, constant: 539.23).isActive = true
        
    }
    
    func designButton2(weatherInfo: HomeWeatherInfo) {
        
        // 현재 온도
        var currentTemp = 0
    
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description // 현재 날씨
            currentTemp = Int(weatherInfo.temp.temp - 273.15) // 현재 온도
        }
        
        // 온도 조건을 만족하는 물품 ( 배열 )
        var button2List:[HomeWearInfo2] = []
        
        // 조건을 충족할 경우 배열에 추가
        for x in 0...wearList2.count-1 {
            if ( currentTemp < wearList2[x].max_temp && wearList2[x].min_temp < currentTemp ) {
                button2List.append(wearList2[x])
            }
        }
        
        if weatherName.contains("dust") {
            for x in 0...wearList2.count-1 {
                if ( wearList2[x].weather == "dust" ) {
                    button2List.append(wearList2[x])
                }
            }
        }
        else if weatherName.contains("rain") {
            for x in 0...wearList2.count-1 {
                if ( wearList2[x].weather == "rain" ) {
                    button2List.append(wearList2[x])
                }
            }
        }
        else if weatherName.contains("drizzle") {
            for x in 0...wearList2.count-1 {
                if ( wearList2[x].weather == "rain" ) {
                    button2List.append(wearList2[x])
                }
            }
        }
        else if weatherName.contains("thunderstorm") {
            for x in 0...wearList2.count-1 {
                if ( wearList2[x].weather == "rain" ) {
                    button2List.append(wearList2[x])
                }
            }
        }
        
        let randomNum = Int.random(in: 0...button2List.count-1)
        
        // 아이템 설정
        let item = button2List[randomNum]
        
        let parent = self.view!
        
        // button2
        button2.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button2.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        parent.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 127).isActive = true
        button2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 357).isActive = true
        
        // button2 - button2Circle
        button2Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let button2CircleShadows = UIView()
        button2CircleShadows.frame = button2Circle.frame
        button2CircleShadows.clipsToBounds = false
        button2Circle.addSubview(button2CircleShadows)
        let button2CircleShadowPath0 = UIBezierPath(roundedRect: button2CircleShadows.bounds, cornerRadius: 0)
        let button2CircleLayer0 = CALayer()
        button2CircleLayer0.shadowPath = button2CircleShadowPath0.cgPath
        button2CircleLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button2CircleLayer0.shadowOpacity = 1
        button2CircleLayer0.shadowRadius = 6
        button2CircleLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button2CircleLayer0.bounds = button2CircleShadows.bounds
        button2CircleLayer0.position = button2CircleShadows.center
        button2CircleShadows.layer.addSublayer(button2CircleLayer0)
        let button2CircleShapes = UIView()
        button2CircleShapes.frame = button2Circle.frame
        button2CircleShapes.clipsToBounds = true
        button2Circle.addSubview(button2CircleShapes)
        let button2CircleLayer1 = CALayer()
        button2CircleLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        button2CircleLayer1.bounds = button2CircleShapes.bounds
        button2CircleLayer1.position = button2CircleShapes.center
        button2CircleShapes.layer.addSublayer(button2CircleLayer1)
        button2CircleShapes.layer.borderWidth = 1.5
        button2CircleShapes.layer.cornerRadius = 15
        button2CircleShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button2Circle)
        button2Circle.translatesAutoresizingMaskIntoConstraints = false
        button2Circle.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button2Circle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button2Circle.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 127).isActive = true
        button2Circle.topAnchor.constraint(equalTo: parent.topAnchor, constant: 357).isActive = true
        
        // button2 - button2Star
        button2Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button2Star.image = UIImage(named: "vector.png")
        parent.addSubview(button2Star)
        button2Star.translatesAutoresizingMaskIntoConstraints = false
        button2Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button2Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button2Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 135).isActive = true
        button2Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 364).isActive = true
        
        // button2Label
        button2Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        let button2Shadows = UIView()
        button2Shadows.frame = button2Label.frame
        button2Shadows.clipsToBounds = false
        button2Label.addSubview(button2Shadows)
        let button2ShadowPath = UIBezierPath(roundedRect: button2Shadows.bounds, cornerRadius: 54)
        let button2Layer0 = CALayer()
        button2Layer0.shadowPath = button2ShadowPath.cgPath
        button2Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        button2Layer0.shadowOpacity = 1
        button2Layer0.shadowRadius = 16
        button2Layer0.shadowOffset = CGSize(width: 0, height: 8)
        button2Layer0.bounds = button2Shadows.bounds
        button2Layer0.position = button2Shadows.center
        button2Shadows.layer.addSublayer(button2Layer0)
        let button2Shapes = UIView()
        button2Shapes.frame = button2Label.frame
        button2Shapes.clipsToBounds = true
        button2Label.addSubview(button2Shapes)
        let button2Layer1 = CALayer()
        button2Layer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.71).cgColor
        button2Layer1.bounds = button2Shapes.bounds
        button2Layer1.position = button2Shapes.center
        button2Shapes.layer.addSublayer(button2Layer1)
        button2Shapes.layer.cornerRadius = 50
        button2Shapes.layer.borderWidth = 1.5
        button2Shapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button2Label)
        button2Label.translatesAutoresizingMaskIntoConstraints = false
        button2Label.widthAnchor.constraint(equalToConstant: 242.5).isActive = true
        button2Label.heightAnchor.constraint(equalToConstant: 97.85).isActive = true
        button2Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 105).isActive = true
        button2Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 324).isActive = true
        
        // button2Text
        button2Text.frame = CGRect(x: 0, y: 0, width: 69, height: 21)
        button2Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button2Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        button2Text.textAlignment = .center
        button2Text.text = item.name
        parent.addSubview(button2Text)
        button2Text.translatesAutoresizingMaskIntoConstraints = false
        button2Text.widthAnchor.constraint(equalToConstant: 69).isActive = true
        button2Text.heightAnchor.constraint(equalToConstant: 21).isActive = true
        button2Text.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        button2Text.topAnchor.constraint(equalTo: parent.topAnchor, constant: 362).isActive = true
        
        // button2Button
        button2Button.frame = CGRect(x: 0, y: 0, width: 8, height: 17)
        button2Button.tintColor = .white
        
        let button2ButtonImage = CALayer()
        button2ButtonImage.contents = UIImage(named: "buttonVector")?.cgImage
        button2ButtonImage.bounds = button2Button.bounds
        button2ButtonImage.position = button2Button.center
        button2Button.layer.addSublayer(button2ButtonImage)
        
        parent.addSubview(button2Button)
        button2Button.translatesAutoresizingMaskIntoConstraints = false
        button2Button.widthAnchor.constraint(equalToConstant: 8).isActive = true
        button2Button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button2Button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 300).isActive = true
        button2Button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 364).isActive = true
        
        // button2Image
        button2Image.frame = CGRect(x: 0, y: 0, width: 67.04, height: 67.04)
        button2Image.backgroundColor = .none
        let button2ImageShadows = UIView()
        button2ImageShadows.frame = button2Image.frame
        button2ImageShadows.clipsToBounds = false
        button2Image.addSubview(button2ImageShadows)
        let button2ImageShadowPath = UIBezierPath(roundedRect: button2ImageShadows.bounds, cornerRadius: 34)
        let button2ImageLayer0 = CALayer()
        button2ImageLayer0.shadowPath = button2ImageShadowPath.cgPath
        button2ImageLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button2ImageLayer0.shadowOpacity = 1
        button2ImageLayer0.shadowRadius = 4
        button2ImageLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button2ImageLayer0.bounds = button2ImageShadows.bounds
        button2ImageLayer0.position = button2ImageShadows.center
        button2ImageShadows.layer.addSublayer(button2ImageLayer0)
        let button2ImageShapes = UIView()
        button2ImageShapes.frame = button2Image.frame
        button2ImageShapes.clipsToBounds = true
        button2Image.addSubview(button2ImageShapes)
        let button2ImageImage = UIImage(named: item.image)?.cgImage
        let button2ImageLayer1 = CALayer()
        button2ImageLayer1.contents = button2ImageImage
        button2ImageLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.2, tx: 0, ty: -0.1))
        button2ImageLayer1.bounds = button2ImageShapes.bounds
        button2ImageLayer1.position = button2ImageShapes.center
        button2ImageShapes.layer.addSublayer(button2ImageLayer1)
        button2ImageShapes.layer.cornerRadius = 34
        button2ImageShapes.layer.borderWidth = 1
        button2ImageShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button2Image)
        button2Image.translatesAutoresizingMaskIntoConstraints = false
        button2Image.widthAnchor.constraint(equalToConstant: 67.04).isActive = true
        button2Image.heightAnchor.constraint(equalToConstant: 67.04).isActive = true
        button2Image.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 122).isActive = true
        button2Image.topAnchor.constraint(equalTo: parent.topAnchor, constant: 340.23).isActive = true
        
        
    }
    
    func designButton3(weatherInfo: HomeWeatherInfo) {
        
        // 현재 온도
        var currentTemp = 0
    
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description // 현재 날씨
            currentTemp = Int(weatherInfo.temp.temp - 273.15) // 현재 온도
        }
        
        // 온도 조건을 만족하는 물품 ( 배열 )
        var button3List:[HomeWearInfo3] = []
        
        // 조건을 충족할 경우 배열에 추가
        for x in 0...wearList3.count-1 {
            if ( currentTemp < wearList3[x].max_temp && wearList3[x].min_temp < currentTemp ) {
                button3List.append(wearList3[x])
            }
        }
        
        if weatherName.contains("rain") {
            for x in 0...wearList3.count-1 {
                if ( wearList3[x].weather == "rain" ) {
                    button3List.append(wearList3[x])
                }
            }
        }
        else if weatherName.contains("drizzle") {
            for x in 0...wearList3.count-1 {
                if ( wearList3[x].weather == "rain" ) {
                    button3List.append(wearList3[x])
                }
            }
        }
        else if weatherName.contains("thunderstorm") {
            for x in 0...wearList3.count-1 {
                if ( wearList3[x].weather == "rain" ) {
                    button3List.append(wearList3[x])
                }
            }
        }
        else if weatherName.contains("snow") {
            for x in 0...wearList3.count-1 {
                if ( wearList3[x].weather == "snow" ) {
                    button3List.append(wearList3[x])
                }
            }
        }
        else if weatherName.contains("sleet") {
            for x in 0...wearList3.count-1 {
                if ( wearList3[x].weather == "snow" ) {
                    button3List.append(wearList3[x])
                }
            }
        }
        
        let randomNum = Int.random(in: 0...button3List.count-1)
        
        // 아이템 설정
        let item = button3List[randomNum]
        
        let parent = self.view!
        
        // button3
        button3.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button3.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        parent.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 262).isActive = true
        button3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 662).isActive = true
        
        // button3 - button3Circle
        button3Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let button3CircleShadows = UIView()
        button3CircleShadows.frame = button3Circle.frame
        button3CircleShadows.clipsToBounds = false
        button3Circle.addSubview(button3CircleShadows)
        let button3CircleShadowPath0 = UIBezierPath(roundedRect: button3CircleShadows.bounds, cornerRadius: 0)
        let button3CircleLayer0 = CALayer()
        button3CircleLayer0.shadowPath = button3CircleShadowPath0.cgPath
        button3CircleLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button3CircleLayer0.shadowOpacity = 1
        button3CircleLayer0.shadowRadius = 6
        button3CircleLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button3CircleLayer0.bounds = button3CircleShadows.bounds
        button3CircleLayer0.position = button3CircleShadows.center
        button3CircleShadows.layer.addSublayer(button3CircleLayer0)
        let button3CircleShapes = UIView()
        button3CircleShapes.frame = button3Circle.frame
        button3CircleShapes.clipsToBounds = true
        button3Circle.addSubview(button3CircleShapes)
        let button3CircleLayer1 = CALayer()
        button3CircleLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor
        button3CircleLayer1.bounds = button3CircleShapes.bounds
        button3CircleLayer1.position = button3CircleShapes.center
        button3CircleShapes.layer.addSublayer(button3CircleLayer1)
        button3CircleShapes.layer.borderWidth = 1.5
        button3CircleShapes.layer.cornerRadius = 15
        button3CircleShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button3Circle)
        button3Circle.translatesAutoresizingMaskIntoConstraints = false
        button3Circle.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button3Circle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button3Circle.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 262).isActive = true
        button3Circle.topAnchor.constraint(equalTo: parent.topAnchor, constant: 662).isActive = true
        
        // button3 - button3Star
        button3Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button3Star.backgroundColor = .none
        button3Star.image = UIImage(named: "vector.png")
        parent.addSubview(button3Star)
        button3Star.translatesAutoresizingMaskIntoConstraints = false
        button3Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button3Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button3Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 270).isActive = true
        button3Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 669).isActive = true
        
        // button3Label
        button3Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        let button3Shadows = UIView()
        button3Shadows.frame = button3Label.frame
        button3Shadows.clipsToBounds = false
        button3Label.addSubview(button3Shadows)
        let button3ShadowPath = UIBezierPath(roundedRect: button3Shadows.bounds, cornerRadius: 54)
        let button3Layer0 = CALayer()
        button3Layer0.shadowPath = button3ShadowPath.cgPath
        button3Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        button3Layer0.shadowOpacity = 1
        button3Layer0.shadowRadius = 16
        button3Layer0.shadowOffset = CGSize(width: 0, height: 8)
        button3Layer0.bounds = button3Shadows.bounds
        button3Layer0.position = button3Shadows.center
        button3Shadows.layer.addSublayer(button3Layer0)
        let button3Shapes = UIView()
        button3Shapes.frame = button3Label.frame
        button3Shapes.clipsToBounds = true
        button3Label.addSubview(button3Shapes)
        let button3Layer1 = CALayer()
        button3Layer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.71).cgColor
        button3Layer1.bounds = button3Shapes.bounds
        button3Layer1.position = button3Shapes.center
        button3Shapes.layer.addSublayer(button3Layer1)
        button3Shapes.layer.cornerRadius = 50
        button3Shapes.layer.borderWidth = 1.5
        button3Shapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button3Label)
        button3Label.translatesAutoresizingMaskIntoConstraints = false
        button3Label.widthAnchor.constraint(equalToConstant: 242.5).isActive = true
        button3Label.heightAnchor.constraint(equalToConstant: 97.85).isActive = true
        button3Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 105).isActive = true
        button3Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 604).isActive = true
        
        // button3Text
        button3Text.frame = CGRect(x: 0, y: 0, width: 69, height: 21)
        button3Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button3Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        button3Text.textAlignment = .center
        button3Text.text = item.name
        parent.addSubview(button3Text)
        button3Text.translatesAutoresizingMaskIntoConstraints = false
        button3Text.widthAnchor.constraint(equalToConstant: 69).isActive = true
        button3Text.heightAnchor.constraint(equalToConstant: 21).isActive = true
        button3Text.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        button3Text.topAnchor.constraint(equalTo: parent.topAnchor, constant: 642).isActive = true
        
        // button3Button
        button3Button.frame = CGRect(x: 0, y: 0, width: 8, height: 17)
        button3Button.tintColor = .white
        
        let button3ButtonImage = CALayer()
        button3ButtonImage.contents = UIImage(named: "buttonVector")?.cgImage
        button3ButtonImage.bounds = button3Button.bounds
        button3ButtonImage.position = button3Button.center
        button3Button.layer.addSublayer(button3ButtonImage)
        
        parent.addSubview(button3Button)
        button3Button.translatesAutoresizingMaskIntoConstraints = false
        button3Button.widthAnchor.constraint(equalToConstant: 8).isActive = true
        button3Button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button3Button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 300).isActive = true
        button3Button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 644).isActive = true
        
        // button3Image
        button3Image.frame = CGRect(x: 0, y: 0, width: 67.04, height: 67.04)
        let button3ImageShadows = UIView()
        button3ImageShadows.frame = button3Image.frame
        button3ImageShadows.clipsToBounds = false
        button3Image.addSubview(button3ImageShadows)
        let button3ImageShadowPath = UIBezierPath(roundedRect: button3ImageShadows.bounds, cornerRadius: 34)
        let button3ImageLayer0 = CALayer()
        button3ImageLayer0.shadowPath = button3ImageShadowPath.cgPath
        button3ImageLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        button3ImageLayer0.shadowOpacity = 1
        button3ImageLayer0.shadowRadius = 4
        button3ImageLayer0.shadowOffset = CGSize(width: 0, height: 4)
        button3ImageLayer0.bounds = button3ImageShadows.bounds
        button3ImageLayer0.position = button3ImageShadows.center
        button3ImageShadows.layer.addSublayer(button3ImageLayer0)
        let button3ImageShapes = UIView()
        button3ImageShapes.frame = button3Image.frame
        button3ImageShapes.clipsToBounds = true
        button3Image.addSubview(button3ImageShapes)
        let button3ImageImage = UIImage(named: item.image)?.cgImage
        let button3ImageLayer1 = CALayer()
        button3ImageLayer1.contents = button3ImageImage
        button3ImageLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.2, tx: 0, ty: -0.1))
        button3ImageLayer1.bounds = button3ImageShapes.bounds
        button3ImageLayer1.position = button3ImageShapes.center
        button3ImageShapes.layer.addSublayer(button3ImageLayer1)
        button3ImageShapes.layer.cornerRadius = 34
        button3ImageShapes.layer.borderWidth = 1
        button3ImageShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(button3Image)
        button3Image.translatesAutoresizingMaskIntoConstraints = false
        button3Image.widthAnchor.constraint(equalToConstant: 67.04).isActive = true
        button3Image.heightAnchor.constraint(equalToConstant: 67.04).isActive = true
        button3Image.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 122).isActive = true
        button3Image.topAnchor.constraint(equalTo: parent.topAnchor, constant: 620.23).isActive = true
        
    }
    
    func designCharacter(weatherInfo: HomeWeatherInfo) {
        
        var characterName = "없음"
        
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description
        }
        
        switch(weatherName) {
        case "light intensity drizzle","drizzle","heavy intensity drizzle","light intensity drizzle rain","drizzle rain","heavy intensity drizzle rain","shower rain and drizzle","heavy shower rain and drizzle","shower drizzle","light intensity shower rain","shower rain","heavy intensity shower rain","ragged shower rain","rain","light rain","moderate rain","heavy intensity rain","very heavy rain","extreme rain" :
            characterName = "GURUMI_rain"
            break
        case "thunderstorm with light rain","thunderstorm with rain","thunderstorm with heavy rain","light thunderstorm","thunderstorm","heavy thunderstorm","ragged thunderstorm","thunderstorm with light drizzle","thunderstorm with drizzle","thunderstorm with heavy drizzle" :
            characterName = "GURUMI_thunder"
            break
        default:
            characterName = "GURUMI_sun"
            break
        }
        
        let parent = self.view!

        characterImage.frame = CGRect(x: 0, y: 0, width: 380, height: 499)
        characterImage.backgroundColor = UIColor(red: 0.984, green: 0.992, blue: 1, alpha: 1)

        let characterImagelayer0 = CALayer()
        
        characterImagelayer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
        characterImagelayer0.bounds = characterImage.bounds
        characterImagelayer0.position = characterImage.center
        characterImage.layer.addSublayer(characterImagelayer0)
        characterImage.animate(withGIFNamed: characterName)

        parent.addSubview(characterImage)
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.widthAnchor.constraint(equalToConstant: 380).isActive = true
        characterImage.heightAnchor.constraint(equalToConstant: 499).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: -3).isActive = true
        characterImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 270).isActive = true


    }


}

// 그라데이션 표현
extension UIImage {
    static func gradientImage(bounds: CGRect, colors: [UIColor]) -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors.map(\.cgColor)
        
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        let renderer = UIGraphicsImageRenderer(bounds: bounds)

        return renderer.image { ctx in
            gradientLayer.render(in: ctx.cgContext)
        }
    }
}
