//
//  WatchViewController.swift
//  Weather-Wear
//
//  Created by yeonsu on 2023/01/25.
//

import UIKit
import YoutubePlayer_in_WKWebView
import CoreLocation

class WatchViewController:UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var playerView: WKYTPlayerView!
    @IBOutlet weak var playerView2: WKYTPlayerView!
    @IBOutlet weak var playerView3: WKYTPlayerView!
    @IBOutlet weak var playerView4: WKYTPlayerView!
    @IBOutlet weak var playerView5: WKYTPlayerView!
    @IBOutlet weak var playerView6: WKYTPlayerView!

    let playvarsDic = ["playsinline": 1]

    override func viewDidLoad() {
        super.viewDidLoad()

        playerView.load(withVideoId: "cSW0xgQaYsI", playerVars: playvarsDic)
        playerView2.load(withVideoId: "MvyW_7s91T0", playerVars: playvarsDic)
        playerView3.load(withVideoId: "btAh3WdEVXg", playerVars: playvarsDic)
        playerView4.load(withVideoId: "tJ7sU2ONnUE", playerVars: playvarsDic)
        playerView5.load(withVideoId: "CbYO8TUKphw", playerVars: playvarsDic)
        playerView6.load(withVideoId: "9-Hcdveq4nE", playerVars: playvarsDic)
        
        
        getCurrentWeather()
        designVector()
        

    }
    
    
    let vectorImage = UILabel()
    let watchLabel = UILabel()
    
    func designVector() {
        
        let parent = self.view!
        
        // vectorImage
        vectorImage.frame = CGRect(x: 0, y: 0, width: 17, height: 20)
        vectorImage.backgroundColor = .white
        
        let vectorImageImage = CALayer()
        vectorImageImage.contents = UIImage(named: "black_vector.png")?.cgImage
        vectorImageImage.bounds = vectorImage.bounds
        vectorImageImage.position = vectorImage.center
        vectorImage.layer.addSublayer(vectorImageImage)
        
        vectorImage.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        parent.addSubview(vectorImage)
        vectorImage.translatesAutoresizingMaskIntoConstraints = false
        vectorImage.widthAnchor.constraint(equalToConstant: 17).isActive = true
        vectorImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        vectorImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        vectorImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 57).isActive = true
        
        // mystyleLabel
        watchLabel.frame = CGRect(x: 0, y: 0, width: 63, height: 23)
        watchLabel.backgroundColor = .white
        watchLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        watchLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        watchLabel.text = "WATCH"
        
        parent.addSubview(watchLabel)
        watchLabel.translatesAutoresizingMaskIntoConstraints = false
        watchLabel.widthAnchor.constraint(equalToConstant: 84).isActive = true
        watchLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        watchLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 45).isActive = true
        watchLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 57).isActive = true
        
    }
    
    
    
    let weatherImage = UILabel()
    
    // 날씨 이미지 
    func designWeather(weatherInfo: WatchWeatherInfo) {
        
        var weatherName = ""
        
        var weatherImageName = "없음"
        
        if let weather = weatherInfo.weather.first {
            weatherName = weather.description
        }
        
        switch(weatherName) {
        case "clear sky" :
            weatherImageName = "clear_sky.png"
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

        weatherImage.frame = CGRect(x: 0, y: 0, width: 38, height: 38)
        weatherImage.backgroundColor = .white
        weatherImage.alpha = 0.3
        weatherImage.layer.compositingFilter = "multiplyBlendMode"
        let image0 = UIImage(named: weatherImageName)?.cgImage
        let layer0 = CALayer()
        layer0.contents = image0
        layer0.bounds = weatherImage.bounds
        layer0.position = weatherImage.center
        weatherImage.layer.addSublayer(layer0)
        parent.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        weatherImage.widthAnchor.constraint(equalToConstant: 38).isActive = true
        weatherImage.heightAnchor.constraint(equalToConstant: 38).isActive = true
        weatherImage.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 320).isActive = true
        weatherImage.topAnchor.constraint(equalTo: parent.topAnchor, constant: 50).isActive = true
        
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
                guard let weatherInformation = try? decoder.decode(WatchWeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    
                    self?.designWeather(weatherInfo: weatherInformation)
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
}
