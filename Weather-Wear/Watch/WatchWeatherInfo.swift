//
//  WatchWeatherInfo.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/29.
//

import Foundation

struct WatchWeatherInfo: Codable {
    let weather: [WatchWeather]
    let temp: WatchTemp
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case weather
        case temp = "main"
        case name
    }
}

struct WatchWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct WatchTemp: Codable {
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

