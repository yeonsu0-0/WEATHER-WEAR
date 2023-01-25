//
//  HomeViewController.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/23.
//

import UIKit
import SafariServices

class HomeViewController: UIViewController {
    
    // 날짜 - check
    @IBOutlet weak var dateLabel: UILabel!
    // 도시 - check
    @IBOutlet weak var cityLabel: UILabel!
    // 로고 이미지
    @IBOutlet weak var logoImage: UIImageView!
    // 온도 - min, max, current - check
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var curTempLabel: UILabel!
    // 날씨 이미지 & 설명
    @IBOutlet weak var weatherImage: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    // 버튼 디자인
    @IBOutlet weak var button1: UIButton!
    var button1Circle = UILabel()
    var button1Star = UIImageView()
    @IBOutlet weak var button2: UIButton!
    var button2Circle = UILabel()
    var button2Star = UIImageView()
    @IBOutlet weak var button3: UIButton!
    var button3Circle = UILabel()
    var button3Star = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 로고 이미지 표시
        logoImage.image = UIImage(named: "logo.png")
        
        // 날짜 표시
        configureDate()
        
        // 서울 날씨 표시
        self.getCurrentWeather(cityName: "Seoul")
        
        // 디자인 구현
        designLabel()
    }
    
    // 옷 보는 버튼 1
    @IBAction func button1(_ sender: Any) {
        
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
    @IBOutlet weak var button1Label: UILabel!
    @IBOutlet weak var button1Image: UILabel!
    @IBOutlet weak var button1Text: UILabel!
    @IBOutlet weak var button1Button: UIButton!
    @IBAction func button1Click(_ sender: Any) {
        let Url = NSURL(string: "https://www.musinsa.com/app/")
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url! as URL)
        self.present(SafariView, animated: true, completion: nil)
    }
    // 옷 보는 버튼 2
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
    @IBOutlet weak var button2Label: UILabel!
    @IBOutlet weak var button2Image: UILabel!
    @IBOutlet weak var button2Text: UILabel!
    @IBOutlet weak var button2Button: UIButton!
    @IBAction func button2Click(_ sender: Any) {
        let Url = NSURL(string: "https://www.musinsa.com/app/")
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url! as URL)
        self.present(SafariView, animated: true, completion: nil)
    }
    // 옷 보는 버튼 3
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
    @IBOutlet weak var button3Label: UILabel!
    @IBOutlet weak var button3Image: UILabel!
    @IBOutlet weak var button3Text: UILabel!
    @IBOutlet weak var button3Button: UIButton!
    @IBAction func button3Click(_ sender: Any) {
        let Url = NSURL(string: "https://www.musinsa.com/app/")
        let SafariView: SFSafariViewController = SFSafariViewController(url: Url! as URL)
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
        //self.cityLabel.text = weatherInfo.name
        self.cityLabel.text = "서울시"
        // 온도 표시 - min, max, current ( 라벨에 데이터 입력 )
        self.minTempLabel.text = "\(Int(weatherInfo.temp.minTemp - 273.15 - 3))°"
        self.maxTempLabel.text = "\(Int(weatherInfo.temp.maxTemp - 273.15 + 5))°"
        self.curTempLabel.text = "\(Int(weatherInfo.temp.temp - 273.15))°"
        // 날씨 표시 - 영어로 ( 라벨에 데이터 입력 )
        if let weather = weatherInfo.weather.first {
            self.weatherLabel.text = weather.description
            // 날씨 이미지 표시
            //weatherImageView(weatherName: weather.description)
        }
        
    }
    
    // api 정보 받기
    func getCurrentWeather(cityName: String) {
        
        // api URL
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&lang=kr&appid=b308fb73c7d88403377ebbb42c75f617") else { return }
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
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
    
    // 날씨별 날씨 이미지 설정 및 캐릭터 이미지 설정 ( 캐릭터 이미지는 추후 추가 )
    /*func weatherImageView(weatherName: String) {
        
        switch(weatherName) {
        case "clear sky" :
            weatherImage.image = UIImage(named: "01.png")
            break
        case "few clouds" :
            weatherImage.image = UIImage(named: "02.png")
            break
        case "scattered clouds" :
            weatherImage.image = UIImage(named: "03.png")
            break
        case "broken clouds","overcast clouds" :
            weatherImage.image = UIImage(named: "04.png")
            break
        case "light intensity drizzle","drizzle","heavy intensity drizzle","light intensity drizzle rain","drizzle rain","heavy intensity drizzle rain","shower rain and drizzle","heavy shower rain and drizzle","shower drizzle","light intensity shower rain","shower rain","heavy intensity shower rain","ragged shower rain" :
            weatherImage.image = UIImage(named: "05.png")
            break
        case "rain","light rain","moderate rain","heavy intensity rain","very heavy rain","extreme rain" :
            weatherImage.image = UIImage(named: "06.png")
            break
        case "thunderstorm with light rain","thunderstorm with rain","thunderstorm with heavy rain","light thunderstorm","thunderstorm","heavy thunderstorm","ragged thunderstorm","thunderstorm with light drizzle","thunderstorm with drizzle","thunderstorm with heavy drizzle" :
            weatherImage.image = UIImage(named: "07.png")
            break
        case "snow","freezing rain","light snow","Heavy snow","Sleet","Light shower sleet","Shower sleet","Light rain and snow","Rain and snow","Light shower snow","Shower snow","Heavy shower snow" :
            weatherImage.image = UIImage(named: "08.png")
            break
        case "mist","Smoke","Haze","sand/ dust whirls","fog","sand","dust","volcanic ash","squalls","tornado" :
            weatherImage.image = UIImage(named: "09.png")
            break
        default:
            break
        }
    }*/
    
    
    func designLabel() {
        
        // 얘는 고정
        let parent = self.view!
        
        view.frame = CGRect(x: 0, y: 0, width: 375, height: 812)
        view.backgroundColor = .white
        view.layer.backgroundColor = UIColor(red: 0.984, green: 0.992, blue: 1, alpha: 1).cgColor
        
        // dateLabel
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
        
        // cityLabel
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
        
        // curTempLabel
        curTempLabel.frame = CGRect(x: 0, y: 0, width: 102, height: 88)
        curTempLabel.backgroundColor = .none
        let gradient = UIImage.gradientImage(bounds: curTempLabel.bounds, colors: [UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0), UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)])
        curTempLabel.textColor = UIColor(patternImage: gradient)
        curTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 50)
        curTempLabel.font = UIFont.systemFont(ofSize: 50)
        curTempLabel.textAlignment = .center
        
        parent.addSubview(curTempLabel)
        curTempLabel.translatesAutoresizingMaskIntoConstraints = false
        curTempLabel.widthAnchor.constraint(equalToConstant: 98).isActive = true
        curTempLabel.heightAnchor.constraint(equalToConstant: 88).isActive = true
        curTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 140).isActive = true
        curTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 157).isActive = true
        
        // logoLabel
        logoImage.frame = CGRect(x: 0, y: 0, width: 52.44, height: 34.15)
        logoImage.backgroundColor = .white
        logoImage.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        parent.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 52.44).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 34.15).isActive = true
        logoImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 302.56).isActive = true
        logoImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 52).isActive = true
        
        // weatherImage
        weatherImage.frame = CGRect(x: 0, y: 0, width: 33, height: 33)
        weatherImage.backgroundColor = .white
        
        let layerWeatherImage = CALayer()
        layerWeatherImage.contents = UIImage(named: "01.png")?.cgImage
        layerWeatherImage.bounds = weatherImage.bounds
        layerWeatherImage.position = weatherImage.center
        weatherImage.layer.addSublayer(layerWeatherImage)
        
        parent.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: 33).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 33).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 109).isActive = true
        weatherImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 253).isActive = true
        
        // minTemp 배경
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
        
        // minTemp 텍스트
        minTempLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        minTempLabel.backgroundColor = .white
        minTempLabel.textColor = UIColor(red: 0.925, green: 0.243, blue: 0.243, alpha: 1)
        minTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        minTempLabel.font = UIFont.systemFont(ofSize: 14)
        minTempLabel.textAlignment = .center
        
        parent.addSubview(minTempLabel)
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        minTempLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        minTempLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        minTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 149).isActive = true
        minTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 121).isActive = true
        
        // maxTemp 배경
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
        
        // maxTemp 텍스트
        maxTempLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        maxTempLabel.backgroundColor = .white
        maxTempLabel.textColor = UIColor(red: 0.294, green: 0.322, blue: 0.965, alpha: 1)
        maxTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        maxTempLabel.font = UIFont.systemFont(ofSize: 14)
        maxTempLabel.textAlignment = .center
        
        parent.addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxTempLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        maxTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        maxTempLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 121).isActive = true
        
        // weatherLabel
        weatherLabel.frame = CGRect(x: 0, y: 0, width: 121, height: 23)
        weatherLabel.backgroundColor = .white
        weatherLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        weatherLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 18)
        weatherLabel.textAlignment = .center
        /*weatherLabel.attributedText = NSMutableAttributedString(string: "강풍을 동반한 비", attributes: [NSAttributedString.Key.kern: -0.45])*/
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherLabel.widthAnchor.constraint(equalToConstant: 121).isActive = true
        weatherLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        weatherLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 148).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 256).isActive = true
        
        // button1
        button1.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button1.backgroundColor = .white
        button1.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        parent.addSubview(button1)
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 97).isActive = true
        button1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 556).isActive = true
        
        // 아이템 설정
        let item = wearList[0]
        
        // button1Label
        button1Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        button1Label.backgroundColor = .white
        
        let wear3ButtonLabelShadows = UIView()
        wear3ButtonLabelShadows.frame = button1Label.frame
        wear3ButtonLabelShadows.clipsToBounds = false
        button1Label.addSubview(wear3ButtonLabelShadows)
        
        let wear3ButtonLabelshadowPath = UIBezierPath(roundedRect: wear3ButtonLabelShadows.bounds, cornerRadius: 54)
        let wear3ButtonLabellayer0 = CALayer()
        wear3ButtonLabellayer0.shadowPath = wear3ButtonLabelshadowPath.cgPath
        wear3ButtonLabellayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        wear3ButtonLabellayer0.shadowOpacity = 1
        wear3ButtonLabellayer0.shadowRadius = 16
        wear3ButtonLabellayer0.shadowOffset = CGSize(width: 0, height: 8)
        wear3ButtonLabellayer0.bounds = wear3ButtonLabelShadows.bounds
        wear3ButtonLabellayer0.position = wear3ButtonLabelShadows.center
        wear3ButtonLabelShadows.layer.addSublayer(wear3ButtonLabellayer0)
        
        let wear3ButtonLabelshapes = UIView()
        wear3ButtonLabelshapes.frame = button1Label.frame
        wear3ButtonLabelshapes.clipsToBounds = true
        button1Label.addSubview(wear3ButtonLabelshapes)
        
        let wear3ButtonLabellayer1 = CALayer()
        wear3ButtonLabellayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.71).cgColor
        wear3ButtonLabellayer1.bounds = wear3ButtonLabelshapes.bounds
        wear3ButtonLabellayer1.position = wear3ButtonLabelshapes.center
        wear3ButtonLabelshapes.layer.addSublayer(wear3ButtonLabellayer1)
        wear3ButtonLabelshapes.layer.cornerRadius = 50
        wear3ButtonLabelshapes.layer.borderWidth = 1.5
        wear3ButtonLabelshapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        parent.addSubview(button1Label)
        button1Label.translatesAutoresizingMaskIntoConstraints = false
        button1Label.widthAnchor.constraint(equalToConstant: 242.5).isActive = true
        button1Label.heightAnchor.constraint(equalToConstant: 97.85).isActive = true
        button1Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 76).isActive = true
        button1Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 523).isActive = true
        
        // button1Text
        button1Text.frame = CGRect(x: 0, y: 0, width: 69, height: 21)
        button1Text.backgroundColor = .none
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
        button1Button.backgroundColor = .none
        button1Button.tintColor = .white
        
        parent.addSubview(button1Button)
        button1Button.translatesAutoresizingMaskIntoConstraints = false
        button1Button.widthAnchor.constraint(equalToConstant: 8).isActive = true
        button1Button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button1Button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 270).isActive = true
        button1Button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 563).isActive = true
        
        // button1Image
        button1Image.frame = CGRect(x: 0, y: 0, width: 67.04, height: 67.04)
        button1Image.backgroundColor = .none
        
        let wear3ImageLabelShadows = UIView()
        wear3ImageLabelShadows.frame = button1Image.frame
        wear3ImageLabelShadows.clipsToBounds = false
        button1Image.addSubview(wear3ImageLabelShadows)
        
        let wear3ImageLabelShadowPath = UIBezierPath(roundedRect: wear3ImageLabelShadows.bounds, cornerRadius: 33)
        let wear3ImageLabelLayer0 = CALayer()
        wear3ImageLabelLayer0.shadowPath = wear3ImageLabelShadowPath.cgPath
        wear3ImageLabelLayer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        wear3ImageLabelLayer0.shadowOpacity = 1
        wear3ImageLabelLayer0.shadowRadius = 4
        wear3ImageLabelLayer0.shadowOffset = CGSize(width: 0, height: 4)
        wear3ImageLabelLayer0.bounds = wear3ImageLabelShadows.bounds
        wear3ImageLabelLayer0.position = wear3ImageLabelShadows.center
        wear3ImageLabelShadows.layer.addSublayer(wear3ImageLabelLayer0)
        
        let wear3ImageLabelShapes = UIView()
        wear3ImageLabelShapes.frame = button1Image.frame
        wear3ImageLabelShapes.clipsToBounds = true
        button1Image.addSubview(wear3ImageLabelShapes)
        
        // 이미지
        let wear3ImageLabelImage = UIImage(named: item.image)?.cgImage
        
        let wear3ImageLabelLayer1 = CALayer()
        wear3ImageLabelLayer1.contents = wear3ImageLabelImage
        wear3ImageLabelLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.2, tx: 0, ty: -0.1))
        wear3ImageLabelLayer1.bounds = wear3ImageLabelShapes.bounds
        wear3ImageLabelLayer1.position = wear3ImageLabelShapes.center
        wear3ImageLabelShapes.layer.addSublayer(wear3ImageLabelLayer1)
        wear3ImageLabelShapes.layer.cornerRadius = 33
        wear3ImageLabelShapes.layer.borderWidth = 1
        wear3ImageLabelShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        parent.addSubview(button1Image)
        button1Image.translatesAutoresizingMaskIntoConstraints = false
        button1Image.widthAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.heightAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 92).isActive = true
        button1Image.topAnchor.constraint(equalTo: parent.topAnchor, constant: 539.23).isActive = true
        
        // button2
        button2.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button2.backgroundColor = .white
        button2.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        parent.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 127).isActive = true
        button2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 357).isActive = true
        
        // button2Label
        button2Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        button2Label.backgroundColor = .white
        
        var button2Shadows = UIView()
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
        
        var button2Shapes = UIView()
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
        button2Text.backgroundColor = .none
        button2Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button2Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        
        button2Text.text = "바람막이"
        
        parent.addSubview(button2Text)
        button2Text.translatesAutoresizingMaskIntoConstraints = false
        button2Text.widthAnchor.constraint(equalToConstant: 69).isActive = true
        button2Text.heightAnchor.constraint(equalToConstant: 21).isActive = true
        button2Text.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        button2Text.topAnchor.constraint(equalTo: parent.topAnchor, constant: 362).isActive = true
        
        // button2Button
        button2Button.frame = CGRect(x: 0, y: 0, width: 8, height: 17)
        button2Button.backgroundColor = .none
        button2Button.tintColor = .white
        
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
        
        // 이미지
        let button2ImageImage = UIImage(named: "closet")?.cgImage
        
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
        
        // button3
        button3.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button3.backgroundColor = .white
        button3.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor
        
        parent.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        button3.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 262).isActive = true
        button3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 662).isActive = true
        
        // button3Label
        button3Label.frame = CGRect(x: 0, y: 0, width: 242.5, height: 97.85)
        button3Label.backgroundColor = .white
        
        var button3Shadows = UIView()
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
        
        var button3Shapes = UIView()
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
        button3Text.backgroundColor = .none
        button3Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button3Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        
        button3Text.text = "바람막이"
        
        parent.addSubview(button3Text)
        button3Text.translatesAutoresizingMaskIntoConstraints = false
        button3Text.widthAnchor.constraint(equalToConstant: 69).isActive = true
        button3Text.heightAnchor.constraint(equalToConstant: 21).isActive = true
        button3Text.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 204).isActive = true
        button3Text.topAnchor.constraint(equalTo: parent.topAnchor, constant: 642).isActive = true
        
        // button3Button
        button3Button.frame = CGRect(x: 0, y: 0, width: 8, height: 17)
        button3Button.backgroundColor = .none
        button3Button.tintColor = .white
        
        parent.addSubview(button3Button)
        button3Button.translatesAutoresizingMaskIntoConstraints = false
        button3Button.widthAnchor.constraint(equalToConstant: 8).isActive = true
        button3Button.heightAnchor.constraint(equalToConstant: 17).isActive = true
        button3Button.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 300).isActive = true
        button3Button.topAnchor.constraint(equalTo: parent.topAnchor, constant: 644).isActive = true
        
        // button3Image
        button3Image.frame = CGRect(x: 0, y: 0, width: 67.04, height: 67.04)
        button3Image.backgroundColor = .none
        
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
        
        // 이미지
        let button3ImageImage = UIImage(named: "closet")?.cgImage
        
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
        
        
        // button1 동그라미
        button1Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button1Circle.backgroundColor = .white
        
        var button1CircleShadows = UIView()
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
        
        var button1CircleShapes = UIView()
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
        
        // button1 별
        button1Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button1Star.backgroundColor = .none
        button1Star.image = UIImage(named: "vector.png")
        
        parent.addSubview(button1Star)
        button1Star.translatesAutoresizingMaskIntoConstraints = false
        button1Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button1Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button1Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 105).isActive = true
        button1Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 563).isActive = true
        
        // button2 동그라미
        button2Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button2Circle.backgroundColor = .white
        
        var button2CircleShadows = UIView()
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
        
        var button2CircleShapes = UIView()
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
        
        // button2 별
        button2Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button2Star.backgroundColor = .none
        button2Star.image = UIImage(named: "vector.png")
        
        parent.addSubview(button2Star)
        button2Star.translatesAutoresizingMaskIntoConstraints = false
        button2Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button2Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button2Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 135).isActive = true
        button2Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 364).isActive = true
        
        // button3 동그라미
        button3Circle.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button3Circle.backgroundColor = .white
        
        var button3CircleShadows = UIView()
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
        
        var button3CircleShapes = UIView()
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
        
        // button3 별
        button3Star.frame = CGRect(x: 0, y: 0, width: 14, height: 16)
        button3Star.backgroundColor = .none
        button3Star.image = UIImage(named: "vector.png")
        
        parent.addSubview(button3Star)
        button3Star.translatesAutoresizingMaskIntoConstraints = false
        button3Star.widthAnchor.constraint(equalToConstant: 14).isActive = true
        button3Star.heightAnchor.constraint(equalToConstant: 16).isActive = true
        button3Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 270).isActive = true
        button3Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 669).isActive = true
        
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
