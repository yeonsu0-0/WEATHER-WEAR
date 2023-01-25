//
//  HomeWearInfo.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/23.
//

struct HomeWearInfo {
    let min_temp: Int
    let max_temp: Int
    let name: String
    let image: String
    let position: Int
}

var pola = HomeWearInfo(min_temp: -10, max_temp: 7, name: "목폴라", image:"pola.png",
                 position: 1)

var wearList:[HomeWearInfo] = [pola]

