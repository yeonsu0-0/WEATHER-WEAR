//
//  MyClosetViewController.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/29.
//

import UIKit
import CoreLocation

class MyClosetViewController: UIViewController, CLLocationManagerDelegate & UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.tabBar.backgroundColor = .white
        
        
        designVector()
        designSelect()
        designTempButton()
        designPlusButton()
        designCells(minTemp: -20,maxTemp: 40, favorite: false)
        
        getCurrentWeather()
        
        selectFavoriteLine.layer.isHidden = true
        selectAllButton_OFF.isHidden = true
        selectFavoriteButton_ON.isHidden = true
        selectAllLine.isHidden = false
        selectFavoriteButton_OFF.isHidden = false
        selectAllButton_ON.isHidden = false
        lineEraser.isHidden = false
        
        listAppend()
        
        favoriteONOFF = false
        
    }
    
    var favoriteONOFF = false
    
    let weatherImage = UILabel()
    
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
                guard let weatherInformation = try? decoder.decode(MyClosetWeatherInfo.self, from: data) else { return }
                DispatchQueue.main.async {
                    
                    self?.designWeather(weatherInfo: weatherInformation)
                    
                }
            } else {
                print("error")
            }
        }.resume()
    }
    
    // 날씨 이미지 & 날씨 설명
    func designWeather(weatherInfo: MyClosetWeatherInfo) {
        
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
    
    let vectorImage = UILabel()
    let mystyleLabel = UILabel()
    
    @IBOutlet weak var selectAll: UIButton!
    @IBOutlet weak var selectFavorite: UIButton!
    let selectAllButton_ON = UILabel()
    let selectAllButton_OFF = UILabel()
    let selectFavoriteButton_ON = UILabel()
    let selectFavoriteButton_OFF = UILabel()
    let selectAllLine = UILabel()
    let selectFavoriteLine = UILabel()
    let lineEraser = UILabel()
    
    @IBAction func selectAllClick(_sender: Any){
        selectFavoriteLine.layer.isHidden = true
        selectAllButton_OFF.isHidden = true
        selectFavoriteButton_ON.isHidden = true
        selectAllLine.isHidden = false
        selectFavoriteButton_OFF.isHidden = false
        selectAllButton_ON.isHidden = false
        lineEraser.isHidden = false
        
        favoriteONOFF = false
        
        button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        tempButtom1Clicked = false
        tempButtom2Clicked = false
        tempButtom3Clicked = false
        tempButtom4Clicked = false
        tempButtom5Clicked = false
        tempButtom6Clicked = false
        tempButtom7Clicked = false
        tempButtom8Clicked = false
        
        search_minTemp = -20
        search_maxTemp = 40
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func selectFavoriteClick(_sender: Any){
        selectFavoriteLine.layer.isHidden = false
        selectAllButton_OFF.isHidden = false
        selectFavoriteButton_ON.isHidden = false
        selectAllLine.isHidden = true
        selectFavoriteButton_OFF.isHidden = true
        selectAllButton_ON.isHidden = true
        lineEraser.isHidden = true
        
        favoriteONOFF = true
        
        button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        tempButtom1Clicked = false
        tempButtom2Clicked = false
        tempButtom3Clicked = false
        tempButtom4Clicked = false
        tempButtom5Clicked = false
        tempButtom6Clicked = false
        tempButtom7Clicked = false
        tempButtom8Clicked = false
        
        search_minTemp = -20
        search_maxTemp = 40
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    
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
        mystyleLabel.frame = CGRect(x: 0, y: 0, width: 84, height: 23)
        mystyleLabel.backgroundColor = .white
        mystyleLabel.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        mystyleLabel.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        mystyleLabel.text = "MY STYLE"
        
        parent.addSubview(mystyleLabel)
        mystyleLabel.translatesAutoresizingMaskIntoConstraints = false
        mystyleLabel.widthAnchor.constraint(equalToConstant: 84).isActive = true
        mystyleLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        mystyleLabel.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 45).isActive = true
        mystyleLabel.topAnchor.constraint(equalTo: parent.topAnchor, constant: 57).isActive = true
        
    }
    
    func designSelect() {
        
        let parent = self.view!
        
        // 전체 버튼
        selectAll.frame = CGRect(x: 0, y: 0, width: 34, height: 23)
        parent.addSubview(selectAll)
        selectAll.translatesAutoresizingMaskIntoConstraints = false
        selectAll.widthAnchor.constraint(equalToConstant: 34).isActive = true
        selectAll.heightAnchor.constraint(equalToConstant: 23).isActive = true
        selectAll.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        selectAll.topAnchor.constraint(equalTo: parent.topAnchor, constant: 115).isActive = true
        
        // 전체
        selectAllButton_ON.frame = CGRect(x: 0, y: 0, width: 34, height: 23)
        selectAllButton_ON.backgroundColor = .white
        selectAllButton_ON.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        selectAllButton_ON.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        selectAllButton_ON.text = "전체"
        parent.addSubview(selectAllButton_ON)
        selectAllButton_ON.translatesAutoresizingMaskIntoConstraints = false
        selectAllButton_ON.widthAnchor.constraint(equalToConstant: 34).isActive = true
        selectAllButton_ON.heightAnchor.constraint(equalToConstant: 23).isActive = true
        selectAllButton_ON.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        selectAllButton_ON.topAnchor.constraint(equalTo: parent.topAnchor, constant: 115).isActive = true
        
        // 즐겨찾기 버튼
        selectFavorite.frame = CGRect(x: 0, y: 0, width: 52, height: 18)
        parent.addSubview(selectFavorite)
        selectFavorite.translatesAutoresizingMaskIntoConstraints = false
        selectFavorite.widthAnchor.constraint(equalToConstant: 52).isActive = true
        selectFavorite.heightAnchor.constraint(equalToConstant: 18).isActive = true
        selectFavorite.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 68).isActive = true
        selectFavorite.topAnchor.constraint(equalTo: parent.topAnchor, constant: 118).isActive = true
        
        // 즐겨찾기
        selectFavoriteButton_OFF.frame = CGRect(x: 0, y: 0, width: 52, height: 18)
        selectFavoriteButton_OFF.backgroundColor = .white
        selectFavoriteButton_OFF.textColor = UIColor(red: 0.571, green: 0.571, blue: 0.571, alpha: 1)
        selectFavoriteButton_OFF.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        selectFavoriteButton_OFF.text = "즐겨찾기"
        parent.addSubview(selectFavoriteButton_OFF)
        selectFavoriteButton_OFF.translatesAutoresizingMaskIntoConstraints = false
        selectFavoriteButton_OFF.widthAnchor.constraint(equalToConstant: 52).isActive = true
        selectFavoriteButton_OFF.heightAnchor.constraint(equalToConstant: 18).isActive = true
        selectFavoriteButton_OFF.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 68).isActive = true
        selectFavoriteButton_OFF.topAnchor.constraint(equalTo: parent.topAnchor, constant: 118).isActive = true
        
        
        //-----------------
        
        
        // 전체 버튼
        selectAll.frame = CGRect(x: 0, y: 0, width: 34, height: 18)
        parent.addSubview(selectAll)
        selectAll.translatesAutoresizingMaskIntoConstraints = false
        selectAll.widthAnchor.constraint(equalToConstant: 34).isActive = true
        selectAll.heightAnchor.constraint(equalToConstant: 18).isActive = true
        selectAll.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        selectAll.topAnchor.constraint(equalTo: parent.topAnchor, constant: 118).isActive = true
        
        // 전체
        selectAllButton_OFF.text = "전체"
        selectAllButton_OFF.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 14)
        selectAllButton_OFF.sizeToFit()
        selectAllButton_OFF.backgroundColor = .white
        selectAllButton_OFF.textColor = UIColor(red: 0.571, green: 0.571, blue: 0.571, alpha: 1)
        parent.addSubview(selectAllButton_OFF)
        selectAllButton_OFF.translatesAutoresizingMaskIntoConstraints = false
        selectAllButton_OFF.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
        selectAllButton_OFF.topAnchor.constraint(equalTo: parent.topAnchor, constant: 118).isActive = true
        
        // 즐겨찾기 버튼
        selectFavorite.frame = CGRect(x: 0, y: 0, width: 68, height: 23)
        parent.addSubview(selectFavorite)
        selectFavorite.translatesAutoresizingMaskIntoConstraints = false
        selectFavorite.widthAnchor.constraint(equalToConstant: 52).isActive = true
        selectFavorite.heightAnchor.constraint(equalToConstant: 23).isActive = true
        selectFavorite.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 68).isActive = true
        selectFavorite.topAnchor.constraint(equalTo: parent.topAnchor, constant: 115).isActive = true
        
        // 즐겨찾기
        selectFavoriteButton_ON.text = "즐겨찾기"
        selectFavoriteButton_ON.font = UIFont(name: "SpoqaHanSansNeo-Bold", size: 18)
        selectFavoriteButton_ON.frame = CGRect(x: 0, y: 0, width: 100, height: 23)
        selectFavoriteButton_ON.backgroundColor = .white
        selectFavoriteButton_ON.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        parent.addSubview(selectFavoriteButton_ON)
        selectFavoriteButton_ON.translatesAutoresizingMaskIntoConstraints = false
        selectFavoriteButton_ON.widthAnchor.constraint(equalToConstant: 100).isActive = true
        selectFavoriteButton_ON.heightAnchor.constraint(equalToConstant: 23).isActive = true
        selectFavoriteButton_ON.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 68).isActive = true
        selectFavoriteButton_ON.topAnchor.constraint(equalTo: parent.topAnchor, constant: 115).isActive = true
        
        // ------------------------
        
        // selectAllLine
        selectAllLine.frame = CGRect(x: 0, y: 0, width: 29.5, height: 0)
        selectAllLine.backgroundColor = .white
        
        let stroke_all = UIView()
        stroke_all.bounds = selectAllLine.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_all.center = selectAllLine.center
        selectAllLine.addSubview(stroke_all)
        selectAllLine.bounds = selectAllLine.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_all.layer.borderWidth = 1
        stroke_all.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        parent.addSubview(selectAllLine)
        selectAllLine.translatesAutoresizingMaskIntoConstraints = false
        selectAllLine.widthAnchor.constraint(equalToConstant: 29.5).isActive = true
        selectAllLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
        selectAllLine.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true
        selectAllLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 139.5).isActive = true
        
        // selectFavoriteLine
        selectFavoriteLine.frame = CGRect(x: 0, y: 0, width: 62, height: 0)
        selectFavoriteLine.backgroundColor = .white
        
        let stroke_fav = UIView()
        stroke_fav.bounds = selectFavoriteLine.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_fav.center = selectFavoriteLine.center
        selectFavoriteLine.addSubview(stroke_fav)
        selectFavoriteLine.bounds = selectFavoriteLine.bounds.insetBy(dx: -0.5, dy: -0.5)
        stroke_fav.layer.borderWidth = 1
        stroke_fav.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        
        parent.addSubview(selectFavoriteLine)
        selectFavoriteLine.translatesAutoresizingMaskIntoConstraints = false
        selectFavoriteLine.widthAnchor.constraint(equalToConstant: 62).isActive = true
        selectFavoriteLine.heightAnchor.constraint(equalToConstant: 0).isActive = true
        selectFavoriteLine.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 70).isActive = true
        selectFavoriteLine.topAnchor.constraint(equalTo: parent.topAnchor, constant: 139.5).isActive = true
        
        
        // lineEraser
        lineEraser.frame = CGRect(x: 0, y: 0, width: 62, height: 3)
        lineEraser.backgroundColor = .white
        
        parent.addSubview(lineEraser)
        lineEraser.translatesAutoresizingMaskIntoConstraints = false
        lineEraser.widthAnchor.constraint(equalToConstant: 62).isActive = true
        lineEraser.heightAnchor.constraint(equalToConstant: 3).isActive = true
        lineEraser.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 70).isActive = true
        lineEraser.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
    }
    
    let tempButton1 = UIButton()
    @IBOutlet weak var tempButton1Layer: UIButton!
    let tempButton1Label = UILabel()
    let tempButton2 = UIButton()
    @IBOutlet weak var tempButton2Layer: UIButton!
    let tempButton2Label = UILabel()
    let tempButton3 = UIButton()
    @IBOutlet weak var tempButton3Layer: UIButton!
    let tempButton3Label = UILabel()
    let tempButton4 = UIButton()
    @IBOutlet weak var tempButton4Layer: UIButton!
    let tempButton4Label = UILabel()
    let tempButton5 = UIButton()
    @IBOutlet weak var tempButton5Layer: UIButton!
    let tempButton5Label = UILabel()
    let tempButton6 = UIButton()
    @IBOutlet weak var tempButton6Layer: UIButton!
    let tempButton6Label = UILabel()
    let tempButton7 = UIButton()
    @IBOutlet weak var tempButton7Layer: UIButton!
    let tempButton7Label = UILabel()
    let tempButton8 = UIButton()
    @IBOutlet weak var tempButton8Layer: UIButton!
    let tempButton8Label = UILabel()
    
    var search_minTemp = 0
    var search_maxTemp = 0
    var tempButtom1Clicked = false
    var tempButtom2Clicked = false
    var tempButtom3Clicked = false
    var tempButtom4Clicked = false
    var tempButtom5Clicked = false
    var tempButtom6Clicked = false
    var tempButtom7Clicked = false
    var tempButtom8Clicked = false
    
    var clicekdList = [Bool]()
    var listRemove = 0
    func listAppend() {
        
        if ( listRemove != 0){
            clicekdList.removeAll()
        }
        
        clicekdList.append(tempButtom1Clicked)
        clicekdList.append(tempButtom2Clicked)
        clicekdList.append(tempButtom3Clicked)
        clicekdList.append(tempButtom4Clicked)
        clicekdList.append(tempButtom5Clicked)
        clicekdList.append(tempButtom6Clicked)
        clicekdList.append(tempButtom7Clicked)
        clicekdList.append(tempButtom8Clicked)
        
        listRemove = listRemove + 1
        
        print(clicekdList[1])
        
    }
    
    let button1Layer1 = CALayer()
    let button2Layer1 = CALayer()
    let button3Layer1 = CALayer()
    let button4Layer1 = CALayer()
    let button5Layer1 = CALayer()
    let button6Layer1 = CALayer()
    let button7Layer1 = CALayer()
    let button8Layer1 = CALayer()
    
    @IBAction func tempButton1Click(_ sender: Any) {
        
        listAppend()
        
        print("버튼 1")
        
        var trueCount = 0
        var clickedCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 0 ){
                    clickedCount = x
                }
            }
            
        }
        
        if ( tempButtom1Clicked == false ) {
            tempButtom1Clicked = true
            button1Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = -20
                search_maxTemp = 4
            } else if ( trueCount == 1 ){
                search_minTemp = -20
            } else if ( trueCount == 2 ){
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = -20
                search_maxTemp = 4
            }
            
        }
        else if ( tempButtom1Clicked == true ) {
            tempButtom1Clicked = false
            button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom1Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
        
    }
    @IBAction func tempButton2Click(_ sender: Any) {
        
        print("버튼 2")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 1 ){
                    clickedCount = x
                }
                
                if ( x > 1 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom2Clicked == false ) {
            tempButtom2Clicked = true
            button2Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 5
                search_maxTemp = 5
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 5
                } else {
                    search_maxTemp = 5
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 5
                search_maxTemp = 5
            }
            
        } else if ( tempButtom2Clicked == true ) {
            tempButtom2Clicked = false
            button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom2Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton3Click(_ sender: Any) {
        
        print("버튼 3")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 2 ){
                    clickedCount = x
                }
                
                if ( x > 2 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom3Clicked == false ) {
            tempButtom3Clicked = true
            button3Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 9
                search_maxTemp = 9
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 9
                } else {
                    search_maxTemp = 9
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 9
                search_maxTemp = 9
            }
            
        } else if ( tempButtom3Clicked == true ) {
            tempButtom3Clicked = false
            button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 8
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 16
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 19
                    break
                case 5:
                    search_minTemp = 20
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 23
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom3Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton4Click(_ sender: Any) {
        
        print("버튼 4")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 3 ){
                    clickedCount = x
                }
                
                if ( x > 3 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom4Clicked == false ) {
            tempButtom4Clicked = true
            button4Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 12
                search_maxTemp = 12
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 12
                } else {
                    search_maxTemp = 12
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 12
                search_maxTemp = 12
            }
            
        } else if ( tempButtom4Clicked == true ) {
            tempButtom4Clicked = false
            button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom4Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton5Click(_ sender: Any) {
        
        print("버튼 5")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 4 ){
                    clickedCount = x
                }
                
                if ( x > 4 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom5Clicked == false ) {
            tempButtom5Clicked = true
            button5Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 17
                search_maxTemp = 17
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 17
                } else {
                    search_maxTemp = 17
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 17
                search_maxTemp = 17
            }
            
        } else if ( tempButtom5Clicked == true ) {
            tempButtom5Clicked = false
            button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom5Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton6Click(_ sender: Any) {
        
        print("버튼 6")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 5 ){
                    clickedCount = x
                }
                
                if ( x > 5 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom6Clicked == false ) {
            tempButtom6Clicked = true
            button6Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 22
                search_maxTemp = 22
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 22
                } else {
                    search_maxTemp = 22
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom7Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 22
                search_maxTemp = 22
            }
            
        } else if ( tempButtom6Clicked == true ) {
            tempButtom6Clicked = false
            button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom6Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton7Click(_ sender: Any) {
        
        print("버튼 7")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        var overCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 6 ){
                    clickedCount = x
                }
                
                if ( x > 6 ){
                    overCount = overCount + 1
                }
            }
            
        }
        
        if ( tempButtom7Clicked == false ) {
            tempButtom7Clicked = true
            button7Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 27
                search_maxTemp = 27
            } else if ( trueCount == 1 ){
                
                if ( overCount == 1 ){
                    search_minTemp = 27
                } else {
                    search_maxTemp = 27
                }
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom8Clicked = false
                
                search_minTemp = 27
                search_maxTemp = 27
            }
            
        } else if ( tempButtom7Clicked == true ) {
            tempButtom7Clicked = false
            button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 7:
                    search_minTemp = 28
                    search_maxTemp = 40
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom7Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    @IBAction func tempButton8Click(_ sender: Any) {
        
        print("버튼 8")
        
        listAppend()
        
        var trueCount = 0
        var clickedCount = 0
        
        for x in 0...clicekdList.count-1 {
            
            if ( clicekdList[x] == true ){
                trueCount = trueCount + 1
                
                if ( x != 7 ){
                    clickedCount = x
                }
                
            }
            
        }
        
        if ( tempButtom8Clicked == false ) {
            tempButtom8Clicked = true
            button8Layer1.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor
            
            if ( trueCount == 0 ) {
                search_minTemp = 28
                search_maxTemp = 40
            } else if ( trueCount == 1 ){
                
                search_maxTemp = 40
                
            } else if ( trueCount == 2 ){
                button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                tempButtom1Clicked = false
                tempButtom2Clicked = false
                tempButtom3Clicked = false
                tempButtom4Clicked = false
                tempButtom5Clicked = false
                tempButtom6Clicked = false
                tempButtom7Clicked = false
                
                search_minTemp = 28
                search_maxTemp = 40
            }
            
        } else if ( tempButtom8Clicked == true ) {
            tempButtom8Clicked = false
            button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            
            if ( trueCount == 1 ) {
                search_minTemp = -20
                search_maxTemp = 40
            } else if ( trueCount == 2 ){
                
                switch(clickedCount){
                case 0:
                    search_minTemp = -20
                    search_maxTemp = 4
                    break
                case 1:
                    search_minTemp = 5
                    search_maxTemp = 5
                    break
                case 2:
                    search_minTemp = 9
                    search_maxTemp = 9
                    break
                case 3:
                    search_minTemp = 12
                    search_maxTemp = 12
                    break
                case 4:
                    search_minTemp = 17
                    search_maxTemp = 17
                    break
                case 5:
                    search_minTemp = 22
                    search_maxTemp = 22
                    break
                case 6:
                    search_minTemp = 27
                    search_maxTemp = 27
                    break
                default:
                    break
                }
                
            }
        }
        
        print(tempButtom8Clicked)
        print(search_minTemp)
        print(search_maxTemp)
        
        designCells(minTemp: search_minTemp,maxTemp: search_maxTemp, favorite: favoriteONOFF)
    }
    
    
    func designTempButton() {
        
        let parent = self.view!
        
        // button1 Circle
        tempButton1.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tempButton1.backgroundColor = .white
        let button1Shadows = UIView()
        button1Shadows.frame = tempButton1.frame
        button1Shadows.clipsToBounds = false
        tempButton1.addSubview(button1Shadows)
        let button1ShadowPath = UIBezierPath(roundedRect: button1Shadows.bounds, cornerRadius: 17)
        let button1Layer0 = CALayer()
        button1Layer0.shadowPath = button1ShadowPath.cgPath
        button1Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button1Layer0.shadowOpacity = 1
        button1Layer0.shadowRadius = 9
        button1Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button1Layer0.bounds = button1Shadows.bounds
        button1Layer0.position = button1Shadows.center
        button1Shadows.layer.addSublayer(button1Layer0)
        let button1Shapes = UIView()
        button1Shapes.frame = tempButton1.frame
        button1Shapes.clipsToBounds = true
        tempButton1.addSubview(button1Shapes)
        button1Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button1Layer1.bounds = button1Shapes.bounds
        button1Layer1.position = button1Shapes.center
        button1Shapes.layer.addSublayer(button1Layer1)
        button1Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton1)
        tempButton1.translatesAutoresizingMaskIntoConstraints = false
        tempButton1.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 17.5).isActive = true
        tempButton1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        //button2Circle
        tempButton2.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tempButton2.backgroundColor = .white
        let button2Shadows = UIView()
        button2Shadows.frame = tempButton2.frame
        button2Shadows.clipsToBounds = false
        tempButton2.addSubview(button2Shadows)
        let button2ShadowPath = UIBezierPath(roundedRect: button2Shadows.bounds, cornerRadius: 17)
        let button2Layer0 = CALayer()
        button2Layer0.shadowPath = button2ShadowPath.cgPath
        button2Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button2Layer0.shadowOpacity = 1
        button2Layer0.shadowRadius = 9
        button2Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button2Layer0.bounds = button2Shadows.bounds
        button2Layer0.position = button2Shadows.center
        button2Shadows.layer.addSublayer(button2Layer0)
        let button2Shapes = UIView()
        button2Shapes.frame = tempButton2.frame
        button2Shapes.clipsToBounds = true
        tempButton2.addSubview(button2Shapes)
        button2Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button2Layer1.bounds = button2Shapes.bounds
        button2Layer1.position = button2Shapes.center
        button2Shapes.layer.addSublayer(button2Layer1)
        button2Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton2)
        tempButton2.translatesAutoresizingMaskIntoConstraints = false
        tempButton2.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton2.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 61.7).isActive = true
        tempButton2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // button3 Circle
        tempButton3.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tempButton3.backgroundColor = .white
        let button3Shadows = UIView()
        button3Shadows.frame = tempButton3.frame
        button3Shadows.clipsToBounds = false
        tempButton3.addSubview(button3Shadows)
        let button3ShadowPath = UIBezierPath(roundedRect: button3Shadows.bounds, cornerRadius: 17)
        let button3Layer0 = CALayer()
        button3Layer0.shadowPath = button3ShadowPath.cgPath
        button3Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button3Layer0.shadowOpacity = 1
        button3Layer0.shadowRadius = 9
        button3Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button3Layer0.bounds = button3Shadows.bounds
        button3Layer0.position = button3Shadows.center
        button3Shadows.layer.addSublayer(button3Layer0)
        let button3Shapes = UIView()
        button3Shapes.frame = tempButton3.frame
        button3Shapes.clipsToBounds = true
        tempButton3.addSubview(button3Shapes)
        button3Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button3Layer1.bounds = button3Shapes.bounds
        button3Layer1.position = button3Shapes.center
        button3Shapes.layer.addSublayer(button3Layer1)
        button3Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton3)
        tempButton3.translatesAutoresizingMaskIntoConstraints = false
        tempButton3.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton3.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 101).isActive = true
        tempButton3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        //button4 Circle
        tempButton4.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        tempButton4.backgroundColor = .white
        let button4Shadows = UIView()
        button4Shadows.frame = tempButton4.frame
        button4Shadows.clipsToBounds = false
        tempButton4.addSubview(button4Shadows)
        let button4ShadowPath = UIBezierPath(roundedRect: button4Shadows.bounds, cornerRadius: 17)
        let button4Layer0 = CALayer()
        button4Layer0.shadowPath = button4ShadowPath.cgPath
        button4Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button4Layer0.shadowOpacity = 1
        button4Layer0.shadowRadius = 9
        button4Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button4Layer0.bounds = button4Shadows.bounds
        button4Layer0.position = button4Shadows.center
        button4Shadows.layer.addSublayer(button4Layer0)
        let button4Shapes = UIView()
        button4Shapes.frame = tempButton4.frame
        button4Shapes.clipsToBounds = true
        tempButton4.addSubview(button4Shapes)
        button4Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button4Layer1.bounds = button4Shapes.bounds
        button4Layer1.position = button4Shapes.center
        button4Shapes.layer.addSublayer(button4Layer1)
        button4Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton4)
        tempButton4.translatesAutoresizingMaskIntoConstraints = false
        tempButton4.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton4.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton4.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 140.1).isActive = true
        tempButton4.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // buttom5 Circle
        tempButton5.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        tempButton5.backgroundColor = .white
        let button5Shadows = UIView()
        button5Shadows.frame = tempButton5.frame
        button5Shadows.clipsToBounds = false
        tempButton5.addSubview(button5Shadows)
        let button5ShadowPath = UIBezierPath(roundedRect: button5Shadows.bounds, cornerRadius: 17)
        let button5Layer0 = CALayer()
        button5Layer0.shadowPath = button5ShadowPath.cgPath
        button5Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button5Layer0.shadowOpacity = 1
        button5Layer0.shadowRadius = 9
        button5Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button5Layer0.bounds = button5Shadows.bounds
        button5Layer0.position = button5Shadows.center
        button5Shadows.layer.addSublayer(button5Layer0)
        let button5Shapes = UIView()
        button5Shapes.frame = tempButton5.frame
        button5Shapes.clipsToBounds = true
        tempButton5.addSubview(button5Shapes)
        button5Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button5Layer1.bounds = button5Shapes.bounds
        button5Layer1.position = button5Shapes.center
        button5Shapes.layer.addSublayer(button5Layer1)
        button5Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton5)
        tempButton5.translatesAutoresizingMaskIntoConstraints = false
        tempButton5.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton5.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton5.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 185.9).isActive = true
        tempButton5.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        //button6 Circle
        tempButton6.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        tempButton6.backgroundColor = .white
        let button6Shadows = UIView()
        button6Shadows.frame = tempButton6.frame
        button6Shadows.clipsToBounds = false
        tempButton6.addSubview(button6Shadows)
        let button6ShadowPath = UIBezierPath(roundedRect: button6Shadows.bounds, cornerRadius: 17)
        let button6Layer0 = CALayer()
        button6Layer0.shadowPath = button6ShadowPath.cgPath
        button6Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button6Layer0.shadowOpacity = 1
        button6Layer0.shadowRadius = 9
        button6Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button6Layer0.bounds = button6Shadows.bounds
        button6Layer0.position = button6Shadows.center
        button6Shadows.layer.addSublayer(button6Layer0)
        let button6Shapes = UIView()
        button6Shapes.frame = tempButton6.frame
        button6Shapes.clipsToBounds = true
        tempButton6.addSubview(button6Shapes)
        button6Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button6Layer1.bounds = button6Shapes.bounds
        button6Layer1.position = button6Shapes.center
        button6Shapes.layer.addSublayer(button6Layer1)
        button6Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton6)
        tempButton6.translatesAutoresizingMaskIntoConstraints = false
        tempButton6.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton6.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton6.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 232.1).isActive = true
        tempButton6.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // button7 Circle
        tempButton7.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        tempButton7.backgroundColor = .white
        let button7Shadows = UIView()
        button7Shadows.frame = tempButton7.frame
        button7Shadows.clipsToBounds = false
        tempButton7.addSubview(button7Shadows)
        let button7ShadowPath = UIBezierPath(roundedRect: button7Shadows.bounds, cornerRadius: 17)
        let button7Layer0 = CALayer()
        button7Layer0.shadowPath = button7ShadowPath.cgPath
        button7Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button7Layer0.shadowOpacity = 1
        button7Layer0.shadowRadius = 9
        button7Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button7Layer0.bounds = button7Shadows.bounds
        button7Layer0.position = button7Shadows.center
        button7Shadows.layer.addSublayer(button7Layer0)
        let button7Shapes = UIView()
        button7Shapes.frame = tempButton7.frame
        button7Shapes.clipsToBounds = true
        tempButton7.addSubview(button7Shapes)
        button7Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button7Layer1.bounds = button7Shapes.bounds
        button7Layer1.position = button7Shapes.center
        button7Shapes.layer.addSublayer(button7Layer1)
        button7Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton7)
        tempButton7.translatesAutoresizingMaskIntoConstraints = false
        tempButton7.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tempButton7.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton7.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 278.3).isActive = true
        tempButton7.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // button8 Circle
        tempButton8.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        tempButton8.backgroundColor = .white
        let button8Shadows = UIView()
        button8Shadows.frame = tempButton8.frame
        button8Shadows.clipsToBounds = false
        tempButton8.addSubview(button8Shadows)
        let button8ShadowPath = UIBezierPath(roundedRect: button8Shadows.bounds, cornerRadius: 17)
        let button8Layer0 = CALayer()
        button8Layer0.shadowPath = button8ShadowPath.cgPath
        button8Layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        button8Layer0.shadowOpacity = 1
        button8Layer0.shadowRadius = 9
        button8Layer0.shadowOffset = CGSize(width: 0, height: 3)
        button8Layer0.bounds = button8Shadows.bounds
        button8Layer0.position = button8Shadows.center
        button8Shadows.layer.addSublayer(button8Layer0)
        let button8Shapes = UIView()
        button8Shapes.frame = tempButton8.frame
        button8Shapes.clipsToBounds = true
        tempButton8.addSubview(button8Shapes)
        button8Layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        button8Layer1.bounds = button8Shapes.bounds
        button8Layer1.position = button8Shapes.center
        button8Shapes.layer.addSublayer(button8Layer1)
        button8Shapes.layer.cornerRadius = 17
        parent.addSubview(tempButton8)
        tempButton8.translatesAutoresizingMaskIntoConstraints = false
        tempButton8.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton8.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton8.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 327.5).isActive = true
        tempButton8.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // button1 Text
        tempButton1Label.sizeToFit()
        tempButton1Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton1Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        tempButton1Label.text = "~"
        parent.addSubview(tempButton1Label)
        tempButton1Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton1Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 28.5).isActive = true
        tempButton1Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 168).isActive = true
        
        // button2 Text
        tempButton2Label.sizeToFit()
        tempButton2Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton2Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton2Label.text = "5°"
        parent.addSubview(tempButton2Label)
        tempButton2Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton2Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 71).isActive = true
        tempButton2Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button3 Text
        tempButton3Label.sizeToFit()
        tempButton3Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton3Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton3Label.text = "9°"
        parent.addSubview(tempButton3Label)
        tempButton3Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton3Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 110).isActive = true
        tempButton3Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button4 Text
        tempButton4Label.sizeToFit()
        tempButton4Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton4Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton4Label.text = "12°"
        parent.addSubview(tempButton4Label)
        tempButton4Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton4Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 149).isActive = true
        tempButton4Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button5 Text
        tempButton5Label.sizeToFit()
        tempButton5Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton5Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton5Label.text = "17°"
        parent.addSubview(tempButton5Label)
        tempButton5Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton5Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 195.2).isActive = true
        tempButton5Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button6 Text
        tempButton6Label.sizeToFit()
        tempButton6Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton6Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton6Label.text = "22°"
        parent.addSubview(tempButton6Label)
        tempButton6Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton6Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 241).isActive = true
        tempButton6Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button7 Text
        tempButton7Label.sizeToFit()
        tempButton7Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton7Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        tempButton7Label.text = "27°"
        parent.addSubview(tempButton7Label)
        tempButton7Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton7Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 287.5).isActive = true
        tempButton7Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 169).isActive = true
        
        // button8 Text
        tempButton8Label.sizeToFit()
        tempButton8Label.textColor = UIColor(red: 0.421, green: 0.421, blue: 0.421, alpha: 1)
        tempButton8Label.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 16)
        tempButton8Label.text = "~"
        parent.addSubview(tempButton8Label)
        tempButton8Label.translatesAutoresizingMaskIntoConstraints = false
        tempButton8Label.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 338.5).isActive = true
        tempButton8Label.topAnchor.constraint(equalTo: parent.topAnchor, constant: 168).isActive = true
        
        // tempButton1Layer
        tempButton1Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton1Layer)
        tempButton1Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton1Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton1Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton1Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 17.5).isActive = true
        tempButton1Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // tempButton2Layer
        tempButton2Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton2Layer)
        tempButton2Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton2Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton2Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton2Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 61.7).isActive = true
        tempButton2Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        
        // tempButton3Layer
        tempButton3Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton3Layer)
        tempButton3Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton3Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton3Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton3Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 101).isActive = true
        tempButton3Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        
        tempButton4Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton4Layer)
        tempButton4Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton4Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton4Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton4Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 140.1).isActive = true
        tempButton4Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // tempButton5Layer
        tempButton5Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton5Layer)
        tempButton5Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton5Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton5Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton5Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 185.9).isActive = true
        tempButton5Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // tempButton6Layer
        tempButton6Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton6Layer)
        tempButton6Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton6Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton6Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton6Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 232.1).isActive = true
        tempButton6Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // tempButton7Layer
        tempButton7Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton7Layer)
        tempButton7Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton7Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton7Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton7Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 278.3).isActive = true
        tempButton7Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
        // tempButton8Layer
        tempButton8Layer.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        parent.addSubview(tempButton8Layer)
        tempButton8Layer.translatesAutoresizingMaskIntoConstraints = false
        tempButton8Layer.widthAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton8Layer.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempButton8Layer.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 327.5).isActive = true
        tempButton8Layer.topAnchor.constraint(equalTo: parent.topAnchor, constant: 162.5).isActive = true
        
    }
    
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         self.navigationItem.hidesBackButton = true
    }
    
    func designPlusButton() {
                
        let parent = self.view!

        let plusButtonBackground = UILabel()
        plusButtonBackground.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        plusButtonBackground.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        plusButtonBackground.layer.cornerRadius = 12
        parent.addSubview(plusButtonBackground)
        plusButtonBackground.translatesAutoresizingMaskIntoConstraints = false
        plusButtonBackground.widthAnchor.constraint(equalToConstant: 168).isActive = true
        plusButtonBackground.heightAnchor.constraint(equalToConstant: 258).isActive = true
        plusButtonBackground.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        plusButtonBackground.topAnchor.constraint(equalTo: parent.topAnchor, constant: 216).isActive = true
        
        let plusButtonCircle = UILabel()
        plusButtonCircle.frame = CGRect(x: 0, y: 0, width: 73, height: 73)
        plusButtonCircle.layer.cornerRadius = 36.5
        plusButtonCircle.layer.borderWidth = 1.5
        plusButtonCircle.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(plusButtonCircle)
        plusButtonCircle.translatesAutoresizingMaskIntoConstraints = false
        plusButtonCircle.widthAnchor.constraint(equalToConstant: 73).isActive = true
        plusButtonCircle.heightAnchor.constraint(equalToConstant: 73).isActive = true
        plusButtonCircle.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 62).isActive = true
        plusButtonCircle.topAnchor.constraint(equalTo: parent.topAnchor, constant: 312).isActive = true
        
        let plusButtonLine1 = UILabel()
        plusButtonLine1.frame = CGRect(x: 0, y: 0, width: 38.85, height: 0)
        plusButtonLine1.backgroundColor = .white
        let stroke1 = UIView()
        stroke1.bounds = plusButtonLine1.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke1.center = plusButtonLine1.center
        plusButtonLine1.addSubview(stroke1)
        plusButtonLine1.bounds = plusButtonLine1.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke1.layer.borderWidth = 1.5
        stroke1.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(plusButtonLine1)
        plusButtonLine1.translatesAutoresizingMaskIntoConstraints = false
        plusButtonLine1.widthAnchor.constraint(equalToConstant: 38.85).isActive = true
        plusButtonLine1.heightAnchor.constraint(equalToConstant: 0).isActive = true
        plusButtonLine1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 79.66).isActive = true
        plusButtonLine1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 349.09).isActive = true
        
        let plusButtonLine2 = UILabel()
        plusButtonLine2.frame = CGRect(x: 0, y: 0, width: 0, height: 38.85)
        plusButtonLine2.backgroundColor = .white
        let stroke2 = UIView()
        stroke2.bounds = plusButtonLine2.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke2.center = plusButtonLine2.center
        plusButtonLine2.addSubview(stroke2)
        plusButtonLine2.bounds = plusButtonLine2.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke2.layer.borderWidth = 1.5
        stroke2.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        parent.addSubview(plusButtonLine2)
        plusButtonLine2.translatesAutoresizingMaskIntoConstraints = false
        plusButtonLine2.widthAnchor.constraint(equalToConstant: 0).isActive = true
        plusButtonLine2.heightAnchor.constraint(equalToConstant: 38.85).isActive = true
        plusButtonLine2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 99.09).isActive = true
        plusButtonLine2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 329.66).isActive = true
        
        plusButton.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        plusButton.layer.cornerRadius = 12
        parent.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalToConstant: 168).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: 258).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        plusButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 216).isActive = true
        
    }
    
    @IBOutlet weak var imageButton1: UIButton!
    @IBOutlet weak var imageButton2: UIButton!
    @IBOutlet weak var imageButton3: UIButton!
    
    @IBAction func clickImageButton1(_ sender: Any){
        designBigView(imageCell: selectImages()[0] as! MyClosetImageCell)
    }
    @IBAction func clickImageButton2(_ sender: Any){
        designBigView(imageCell: selectImages()[1] as! MyClosetImageCell)
    }
    @IBAction func clickImageButton3(_ sender: Any){
        designBigView(imageCell: selectImages()[2] as! MyClosetImageCell)
    }
    
    func selectImages() -> Array<Any> {
        
        var selectList: [ MyClosetImageCell ] = []
        
        for x in 0...MyClosetList.count - 1{
            if (MyClosetList[MyClosetList.count - 1 - x].select == true){
                selectList.append(MyClosetList[MyClosetList.count - 1 - x])
            }
        }
        
        print(selectList)
        
        return selectList
    }
    
    
    let cell1Star = UIImageView()
    let cell2Star = UIImageView()
    let cell3Star = UIImageView()
    
    @IBOutlet weak var cell1StarButton: UIButton!
    @IBOutlet weak var cell2StarButton: UIButton!
    @IBOutlet weak var cell3StarButton: UIButton!
    
    @IBAction func star1Click(_ sender: Any){
        
        var myClosetCell: MyClosetImageCell
        
        myClosetCell = selectImages()[0] as! MyClosetImageCell
        
        if ( myClosetCell.favorite == true ){
            MyClosetList[myClosetCell.num-1].favorite = false
            cell1Star.image = UIImage(named: "star_empty")
        } else {
            MyClosetList[myClosetCell.num-1].favorite = true
            cell1Star.image = UIImage(named: "star_full")
        }
    }
    @IBAction func star2Click(_ sender: Any){
        var myClosetCell: MyClosetImageCell
        
        myClosetCell = selectImages()[1] as! MyClosetImageCell
        
        if ( myClosetCell.favorite == true ){
            MyClosetList[myClosetCell.num-1].favorite = false
            cell2Star.image = UIImage(named: "star_empty")
        } else {
            MyClosetList[myClosetCell.num-1].favorite = true
            cell2Star.image = UIImage(named: "star_full")
        }
    }
    @IBAction func star3Click(_ sender: Any){
        var myClosetCell: MyClosetImageCell
        
        myClosetCell = selectImages()[2] as! MyClosetImageCell
        
        if ( myClosetCell.favorite == true ){
            MyClosetList[myClosetCell.num-1].favorite = false
            cell3Star.image = UIImage(named: "star_empty")
        } else {
            MyClosetList[myClosetCell.num-1].favorite = true
            cell3Star.image = UIImage(named: "star_full")
        }
    }
    
    
    func designCells(minTemp: Int, maxTemp: Int, favorite: Bool){
        
        for x in 0...MyClosetList.count - 1 {
            MyClosetList[x].select = false
        }
        
        var closetList: [ MyClosetImageCell ] = []
        
        if ( favorite == true ){
            for x in 0...MyClosetList.count - 1 {
                if ( MyClosetList[MyClosetList.count - 1 - x].temp >= minTemp && MyClosetList[MyClosetList.count - 1 - x].temp <= maxTemp && MyClosetList[MyClosetList.count - 1 - x].favorite == true ){
                    closetList.append(MyClosetList[MyClosetList.count - 1 - x])
                    MyClosetList[MyClosetList.count - 1 - x].select = true
                }
            }
        } else {
            for x in 0...MyClosetList.count - 1 {
                if ( MyClosetList[MyClosetList.count - 1 - x].temp >= minTemp && MyClosetList[MyClosetList.count - 1 - x].temp <= maxTemp ){
                    closetList.append(MyClosetList[MyClosetList.count - 1 - x])
                    MyClosetList[MyClosetList.count - 1 - x].select = true
                }
            }
        }
        
        let parent = self.view!
        
        let cell1 = UIImageView()
        cell1.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        cell1.backgroundColor = .white
        cell1.layer.cornerRadius = 12
        cell1.image = closetList[0].image
        cell1.contentMode = .scaleAspectFill
        cell1.clipsToBounds = true
        parent.addSubview(cell1)
        cell1.translatesAutoresizingMaskIntoConstraints = false
        cell1.widthAnchor.constraint(equalToConstant: 168).isActive = true
        cell1.heightAnchor.constraint(equalToConstant: 258).isActive = true
        cell1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 193).isActive = true
        cell1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 216).isActive = true
        
        cell1Star.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        if(closetList[0].favorite == false){
            cell1Star.image = UIImage(named: "star_empty")
        } else {
            cell1Star.image = UIImage(named: "star_full")
        }
        parent.addSubview(cell1Star)
        cell1Star.translatesAutoresizingMaskIntoConstraints = false
        cell1Star.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell1Star.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell1Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 333).isActive = true
        cell1Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 226).isActive = true
        
        let cell1TempBackGround = UILabel()
        cell1TempBackGround.frame = CGRect(x: 0, y: 0, width: 35, height: 19)
        cell1TempBackGround.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        cell1TempBackGround.layer.cornerRadius = 10
        parent.addSubview(cell1TempBackGround)
        cell1TempBackGround.translatesAutoresizingMaskIntoConstraints = false
        cell1TempBackGround.widthAnchor.constraint(equalToConstant: 35).isActive = true
        cell1TempBackGround.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell1TempBackGround.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 317).isActive = true
        cell1TempBackGround.topAnchor.constraint(equalTo: parent.topAnchor, constant: 445).isActive = true
        
        let cell1Temp = UILabel()
        cell1Temp.textAlignment = .center
        cell1Temp.frame = CGRect(x: 0, y: 0, width: 19.5, height: 14)
        cell1Temp.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell1Temp.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 11)
        cell1Temp.text = String(closetList[0].temp)+"°"
        parent.addSubview(cell1Temp)
        cell1Temp.translatesAutoresizingMaskIntoConstraints = false
        cell1Temp.widthAnchor.constraint(equalToConstant: 19.5).isActive = true
        cell1Temp.heightAnchor.constraint(equalToConstant: 14).isActive = true
        cell1Temp.leadingAnchor.constraint(equalTo: cell1TempBackGround.leadingAnchor, constant: 7.75).isActive = true
        cell1Temp.topAnchor.constraint(equalTo: cell1TempBackGround.topAnchor, constant: 2.5).isActive = true
        
        imageButton1.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        imageButton1.layer.cornerRadius = 12
        parent.addSubview(imageButton1)
        imageButton1.translatesAutoresizingMaskIntoConstraints = false
        imageButton1.widthAnchor.constraint(equalToConstant: 168).isActive = true
        imageButton1.heightAnchor.constraint(equalToConstant: 258).isActive = true
        imageButton1.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 193).isActive = true
        imageButton1.topAnchor.constraint(equalTo: parent.topAnchor, constant: 216).isActive = true
        
        cell1StarButton.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        parent.addSubview(cell1StarButton)
        cell1StarButton.translatesAutoresizingMaskIntoConstraints = false
        cell1StarButton.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell1StarButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell1StarButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 333).isActive = true
        cell1StarButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 226).isActive = true
        
        
        let cell2 = UIImageView()
        cell2.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        cell2.backgroundColor = .white
        cell2.layer.cornerRadius = 12
        cell2.image = closetList[1].image
        cell2.contentMode = .scaleAspectFill
        cell2.clipsToBounds = true
        parent.addSubview(cell2)
        cell2.translatesAutoresizingMaskIntoConstraints = false
        cell2.widthAnchor.constraint(equalToConstant: 168).isActive = true
        cell2.heightAnchor.constraint(equalToConstant: 258).isActive = true
        cell2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        cell2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 487).isActive = true
        
        cell2Star.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        if(closetList[1].favorite == false){
            cell2Star.image = UIImage(named: "star_empty")
        } else {
            cell2Star.image = UIImage(named: "star_full")
        }
        parent.addSubview(cell2Star)
        cell2Star.translatesAutoresizingMaskIntoConstraints = false
        cell2Star.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell2Star.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell2Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 155).isActive = true
        cell2Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 497).isActive = true
        
        let cell2TempBackGround = UILabel()
        cell2TempBackGround.frame = CGRect(x: 0, y: 0, width: 35, height: 19)
        cell2TempBackGround.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        cell2TempBackGround.layer.cornerRadius = 10
        parent.addSubview(cell2TempBackGround)
        cell2TempBackGround.translatesAutoresizingMaskIntoConstraints = false
        cell2TempBackGround.widthAnchor.constraint(equalToConstant: 35).isActive = true
        cell2TempBackGround.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell2TempBackGround.leadingAnchor.constraint(equalTo: cell2.leadingAnchor, constant: 124).isActive = true
        cell2TempBackGround.topAnchor.constraint(equalTo: cell2.topAnchor, constant: 229).isActive = true
        
        let cell2Temp = UILabel()
        cell2Temp.textAlignment = .center
        cell2Temp.frame = CGRect(x: 0, y: 0, width: 19.5, height: 14)
        cell2Temp.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell2Temp.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 11)
        cell2Temp.text = String(closetList[1].temp)+"°"
        parent.addSubview(cell2Temp)
        cell2Temp.translatesAutoresizingMaskIntoConstraints = false
        cell2Temp.widthAnchor.constraint(equalToConstant: 19.5).isActive = true
        cell2Temp.heightAnchor.constraint(equalToConstant: 14).isActive = true
        cell2Temp.leadingAnchor.constraint(equalTo: cell2TempBackGround.leadingAnchor, constant: 7.75).isActive = true
        cell2Temp.topAnchor.constraint(equalTo: cell2TempBackGround.topAnchor, constant: 2.5).isActive = true
        
        imageButton2.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        imageButton2.layer.cornerRadius = 12
        parent.addSubview(imageButton2)
        imageButton2.translatesAutoresizingMaskIntoConstraints = false
        imageButton2.widthAnchor.constraint(equalToConstant: 168).isActive = true
        imageButton2.heightAnchor.constraint(equalToConstant: 258).isActive = true
        imageButton2.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 15).isActive = true
        imageButton2.topAnchor.constraint(equalTo: parent.topAnchor, constant: 487).isActive = true
        
        cell2StarButton.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        parent.addSubview(cell2StarButton)
        cell2StarButton.translatesAutoresizingMaskIntoConstraints = false
        cell2StarButton.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell2StarButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell2StarButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 155).isActive = true
        cell2StarButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 497).isActive = true
        
        let cell3 = UIImageView()
        cell3.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        cell3.backgroundColor = .white
        cell3.layer.cornerRadius = 12
        cell3.image = closetList[2].image
        cell3.contentMode = .scaleAspectFill
        cell3.clipsToBounds = true
        parent.addSubview(cell3)
        cell3.translatesAutoresizingMaskIntoConstraints = false
        cell3.widthAnchor.constraint(equalToConstant: 168).isActive = true
        cell3.heightAnchor.constraint(equalToConstant: 258).isActive = true
        cell3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 193).isActive = true
        cell3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 487).isActive = true
        
        cell3StarButton.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        parent.addSubview(cell3StarButton)
        cell3StarButton.translatesAutoresizingMaskIntoConstraints = false
        cell3StarButton.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell3StarButton.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell3StarButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 333).isActive = true
        cell3StarButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 497).isActive = true
        
        let cell3TempBackGround = UILabel()
        cell3TempBackGround.frame = CGRect(x: 0, y: 0, width: 35, height: 19)
        cell3TempBackGround.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6).cgColor
        cell3TempBackGround.layer.cornerRadius = 10
        parent.addSubview(cell3TempBackGround)
        cell3TempBackGround.translatesAutoresizingMaskIntoConstraints = false
        cell3TempBackGround.widthAnchor.constraint(equalToConstant: 35).isActive = true
        cell3TempBackGround.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell3TempBackGround.leadingAnchor.constraint(equalTo: cell3.leadingAnchor, constant: 124).isActive = true
        cell3TempBackGround.topAnchor.constraint(equalTo: cell3.topAnchor, constant: 229).isActive = true
        
        let cell3Temp = UILabel()
        cell3Temp.textAlignment = .center
        cell3Temp.frame = CGRect(x: 0, y: 0, width: 19.5, height: 14)
        cell3Temp.textColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        cell3Temp.font = UIFont(name: "SpoqaHanSansNeo-Regular", size: 11)
        cell3Temp.text = String(closetList[2].temp)+"°"
        parent.addSubview(cell3Temp)
        cell3Temp.translatesAutoresizingMaskIntoConstraints = false
        cell3Temp.widthAnchor.constraint(equalToConstant: 19.5).isActive = true
        cell3Temp.heightAnchor.constraint(equalToConstant: 14).isActive = true
        cell3Temp.leadingAnchor.constraint(equalTo: cell3TempBackGround.leadingAnchor, constant: 7.75).isActive = true
        cell3Temp.topAnchor.constraint(equalTo: cell3TempBackGround.topAnchor, constant: 2.5).isActive = true
        
        imageButton3.frame = CGRect(x: 0, y: 0, width: 168, height: 258)
        imageButton3.backgroundColor = .white
        imageButton3.layer.cornerRadius = 12
        imageButton3.addSubview(cell3)
        imageButton3.translatesAutoresizingMaskIntoConstraints = false
        imageButton3.widthAnchor.constraint(equalToConstant: 168).isActive = true
        imageButton3.heightAnchor.constraint(equalToConstant: 258).isActive = true
        imageButton3.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 193).isActive = true
        imageButton3.topAnchor.constraint(equalTo: parent.topAnchor, constant: 487).isActive = true
        
        cell3Star.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        if(closetList[2].favorite == false){
            cell3Star.image = UIImage(named: "star_empty")
        } else {
            cell3Star.image = UIImage(named: "star_full")
        }
        parent.addSubview(cell3Star)
        cell3Star.translatesAutoresizingMaskIntoConstraints = false
        cell3Star.widthAnchor.constraint(equalToConstant: 19).isActive = true
        cell3Star.heightAnchor.constraint(equalToConstant: 19).isActive = true
        cell3Star.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 333).isActive = true
        cell3Star.topAnchor.constraint(equalTo: parent.topAnchor, constant: 497).isActive = true
        
    }
    
    @IBOutlet weak var arrowButton: UIButton!
    @IBAction func clickArrow(_ sender: Any) {
        
        arrowButton.isHidden = true
        backGround.isHidden = true
        bigImageView.isHidden = true
        bigDateText.isHidden = true
        arrow.isHidden = true
        lineView.isHidden = true
        starView.isHidden = true
        plusButton.isHidden = false
        imageButton1.isHidden = false
        imageButton2.isHidden = false
        imageButton3.isHidden = false
        
        selectAll.isHidden = false
        selectFavorite.isHidden = false
        tempButton1.isHidden = false
        tempButton2.isHidden = false
        tempButton3.isHidden = false
        tempButton4.isHidden = false
        tempButton5.isHidden = false
        tempButton6.isHidden = false
        tempButton7.isHidden = false
        tempButton8.isHidden = false
        
        print("눌림")
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    let backGround = UILabel()
    let bigImageView = UIImageView()
    let bigDateText = UILabel()
    let arrow = UIImageView()
    let lineView = UILabel()
    let starView = UIImageView()
    
    func designBigView(imageCell: MyClosetImageCell) {
        
        self.tabBarController?.tabBar.isHidden = true
        
        let parent = self.view!
        
        backGround.frame = CGRect(x: 0, y: 0, width: parent.bounds.width, height: parent.bounds.height)
        backGround.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.0)
        parent.addSubview(backGround)
        backGround.translatesAutoresizingMaskIntoConstraints = false
        backGround.widthAnchor.constraint(equalToConstant: parent.bounds.width).isActive = true
        backGround.heightAnchor.constraint(equalToConstant: parent.bounds.height).isActive = true
        backGround.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        backGround.topAnchor.constraint(equalTo: parent.topAnchor, constant: 0).isActive = true
        
        bigImageView.frame = CGRect(x: 0, y: 0, width: 375, height: 576)
        bigImageView.backgroundColor = .white
        bigImageView.image = imageCell.image
        bigImageView.contentMode = .scaleAspectFill
        bigImageView.clipsToBounds = true
        parent.addSubview(bigImageView)
        bigImageView.translatesAutoresizingMaskIntoConstraints = false
        bigImageView.widthAnchor.constraint(equalToConstant: 375).isActive = true
        bigImageView.heightAnchor.constraint(equalToConstant: 576).isActive = true
        bigImageView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 0).isActive = true
        bigImageView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 135).isActive = true

        bigDateText.frame = CGRect(x: 0, y: 0, width: 87, height: 18)
        bigDateText.backgroundColor = .white
        bigDateText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        bigDateText.font = UIFont(name: "SpoqaHanSansNeo-Medium", size: 14)
        bigDateText.text = imageCell.date
        parent.addSubview(bigDateText)
        bigDateText.translatesAutoresizingMaskIntoConstraints = false
        bigDateText.widthAnchor.constraint(equalToConstant: 87).isActive = true
        bigDateText.heightAnchor.constraint(equalToConstant: 18).isActive = true
        bigDateText.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 62).isActive = true
        bigDateText.topAnchor.constraint(equalTo: parent.topAnchor, constant: 89).isActive = true
        
        
        lineView.frame = CGRect(x: 0, y: 0, width: 0, height: 47.5)
        lineView.backgroundColor = .white
        let stroke = UIView()
        stroke.bounds = lineView.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke.center = lineView.center
        lineView.addSubview(stroke)
        lineView.bounds = lineView.bounds.insetBy(dx: -0.75, dy: -0.75)
        stroke.layer.borderWidth = 1.5
        stroke.layer.borderColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1).cgColor
        parent.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.widthAnchor.constraint(equalToConstant: 0).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 47.5).isActive = true
        lineView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 311).isActive = true
        lineView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 74.5).isActive = true
        
        
        arrow.frame = CGRect(x: 0, y: 0, width: 20.5, height: 16)
        arrow.image = UIImage(named: "arrow")
        parent.addSubview(arrow)
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.widthAnchor.constraint(equalToConstant: 20.5).isActive = true
        arrow.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrow.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true
        arrow.topAnchor.constraint(equalTo: parent.topAnchor, constant: 90).isActive = true
        
        
        starView.frame = CGRect(x: 0, y: 0, width: 19, height: 19)
        
        if ( imageCell.favorite == true ){
            starView.image = UIImage(named: "full_star")
        } else {
            starView.image = UIImage(named: "empty_star")
        }
        
        
        parent.addSubview(starView)
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.widthAnchor.constraint(equalToConstant: 19).isActive = true
        starView.heightAnchor.constraint(equalToConstant: 19).isActive = true
        starView.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 327).isActive = true
        starView.topAnchor.constraint(equalTo: parent.topAnchor, constant: 90).isActive = true
        
        arrowButton.frame = CGRect(x: 0, y: 0, width: 20.5, height: 16)
        parent.addSubview(arrowButton)
        arrowButton.translatesAutoresizingMaskIntoConstraints = false
        arrowButton.widthAnchor.constraint(equalToConstant: 20.5).isActive = true
        arrowButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        arrowButton.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 22).isActive = true
        arrowButton.topAnchor.constraint(equalTo: parent.topAnchor, constant: 90).isActive = true
        
        
        plusButton.isHidden = true
        imageButton1.isHidden = true
        imageButton2.isHidden = true
        imageButton3.isHidden = true
        backGround.isHidden = false
        bigImageView.isHidden = false
        bigDateText.isHidden = false
        arrow.isHidden = false
        lineView.isHidden = false
        starView.isHidden = false
        arrowButton.isHidden = false
        
        selectAll.isHidden = true
        selectFavorite.isHidden = true
        tempButton1.isHidden = true
        tempButton2.isHidden = true
        tempButton3.isHidden = true
        tempButton4.isHidden = true
        tempButton5.isHidden = true
        tempButton6.isHidden = true
        tempButton7.isHidden = true
        tempButton8.isHidden = true
        
        
    }
    
    
    
    
}
