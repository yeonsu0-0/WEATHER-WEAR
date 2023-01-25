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
        print("안녕")
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
    
    // 배경 선택 시 버튼 사라짐
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        
        if ( button1Label.layer.isHidden == false && button1Image.layer.isHidden == false && button1Text.layer.isHidden == false && button1Button.layer.isHidden == false ) {
            button1Label.layer.isHidden = true
            button1Image.layer.isHidden = true
            button1Text.layer.isHidden = true
            button1Button.layer.isHidden = true
            
            button1.layer.isHidden = false
        }
        
    }
    
    // 버튼 - 더보기
    @IBAction func wearPlusButton(_ sender: Any) {
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
        self.minTempLabel.text = "\(Int(weatherInfo.temp.minTemp - 273.15))°"
        self.maxTempLabel.text = "\(Int(weatherInfo.temp.maxTemp - 273.15))°"
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
        curTempLabel.backgroundColor = .white
        let gradient = UIImage.gradientImage(bounds: curTempLabel.bounds, colors: [UIColor(red: 212/255, green: 212/255, blue: 212/255, alpha: 1.0), UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)])
        curTempLabel.textColor = UIColor(patternImage: gradient)
        curTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 50)
        curTempLabel.font = UIFont.systemFont(ofSize: 50)
        
        parent.addSubview(curTempLabel)
        curTempLabel.translatesAutoresizingMaskIntoConstraints = false
        curTempLabel.widthAnchor.constraint(equalToConstant: 98).isActive = true
        curTempLabel.heightAnchor.constraint(equalToConstant: 88).isActive = true
        curTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 138).isActive = true
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
        
        // maxTemp
        maxTempLabel.frame = CGRect(x: 0, y: 0, width: 30, height: 18)
        maxTempLabel.backgroundColor = .white
        maxTempLabel.textColor = UIColor(red: 0.294, green: 0.322, blue: 0.965, alpha: 1)
        maxTempLabel.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        maxTempLabel.font = UIFont.systemFont(ofSize: 14)

        parent.addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        maxTempLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        maxTempLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        maxTempLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 203).isActive = true
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
        
        // wear3Label
        button1Text.frame = CGRect(x: 0, y: 0, width: 69, height: 21)
        button1Text.backgroundColor = .none
        button1Text.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        button1Text.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 18)
        
        button1Text.text = "바람막이"
        
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

        /*let wear32ButtonStroke = UIView()
        wear32ButtonStroke.bounds = button1Button.bounds.insetBy(dx: -0.75, dy: -0.75)
        wear32ButtonStroke.center = button1Button.center
        button1Button.addSubview(wear32ButtonStroke)
        button1Button.bounds = button1Button.bounds.insetBy(dx: -0.75, dy: -0.75)
        //wear32ButtonStroke.layer.borderWidth = 1.5
        wear32ButtonStroke.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor*/
        
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

        let wear3ImageLabelShadowPath = UIBezierPath(roundedRect: wear3ImageLabelShadows.bounds, cornerRadius: 34)
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
        let wear3ImageLabelImage = UIImage(named: "02.png")?.cgImage
        
        let wear3ImageLabelLayer1 = CALayer()
        wear3ImageLabelLayer1.contents = wear3ImageLabelImage
        wear3ImageLabelLayer1.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.2, tx: 0, ty: -0.1))
        wear3ImageLabelLayer1.bounds = wear3ImageLabelShapes.bounds
        wear3ImageLabelLayer1.position = wear3ImageLabelShapes.center
        wear3ImageLabelShapes.layer.addSublayer(wear3ImageLabelLayer1)
        wear3ImageLabelShapes.layer.cornerRadius = 34
        wear3ImageLabelShapes.layer.borderWidth = 1
        wear3ImageLabelShapes.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor

        parent.addSubview(button1Image)
        button1Image.translatesAutoresizingMaskIntoConstraints = false
        button1Image.widthAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.heightAnchor.constraint(equalToConstant: 67.04).isActive = true
        button1Image.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 92).isActive = true
        button1Image.topAnchor.constraint(equalTo: parent.topAnchor, constant: 539.23).isActive = true
        
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
