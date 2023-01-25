//
//  HomeWeatherInfo.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/23.
//

struct HomeWeatherInfo: Codable {
    let weather: [HomeWeather]
    let temp: HomeTemp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}

struct HomeWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct HomeTemp: Codable {
    let temp: Double
    let feelsLike: Double
    let minTemp: Double
    let maxTemp: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case minTemp = "temp_min"
        case maxTemp = "temp_max"
    }
}

