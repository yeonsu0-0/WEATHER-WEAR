//
//  HomeWearInfo2.swift
//  GuruTeam3
//
//  Created by 이지민 on 2023/01/26.
//

struct HomeWearInfo2 {
    let min_temp: Int
    let max_temp: Int
    let name: String
    let image: String
    let weather: String
}

let wear21 = HomeWearInfo2(min_temp: -100, max_temp: 100, name: "마스크", image: "마스크.png", weather: "dust")
let wear22 = HomeWearInfo2(min_temp: -20, max_temp: 40, name: "모자", image: "모자.png", weather: "normal")
let wear23 = HomeWearInfo2(min_temp: -20, max_temp: 8, name: "목도리", image: "목도리.png", weather: "normal")
let wear24 = HomeWearInfo2(min_temp: -20, max_temp: 4, name: "바라클라바", image: "바라클라바.png", weather: "normal")
let wear25 = HomeWearInfo2(min_temp: 30, max_temp: 40, name: "선글라스", image: "선글라스.png", weather: "hot")
let wear26 = HomeWearInfo2(min_temp: 30, max_temp: 40, name: "양산", image: "양산.png", weather: "hot")
let wear27 = HomeWearInfo2(min_temp: -100, max_temp: -100, name: "우비", image: "우비.png", weather: "rain")
let wear28 = HomeWearInfo2(min_temp: -100, max_temp: -100, name: "우산", image: "우산.png", weather: "rain")
let wear29 = HomeWearInfo2(min_temp: -20, max_temp: 8, name: "장갑", image: "장갑.png", weather: "normal")

let wearList2:[HomeWearInfo2] = [wear21,wear22,wear23,wear24,wear25,wear26,wear27,wear28,wear29]
