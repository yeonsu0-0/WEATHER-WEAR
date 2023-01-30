//
//  HomeWearInfo3.swift
//  GuruTeam3
//
//  Created by 이지민 on 2023/01/26.
//

struct HomeWearInfo3 {
    let min_temp: Int
    let max_temp: Int
    let name: String
    let image: String
    let weather: String
}

let wear31 = HomeWearInfo3(min_temp: 5, max_temp: 8, name: "레깅스", image: "레깅스.png", weather: "normal")
let wear32 = HomeWearInfo3(min_temp: 17, max_temp: 19, name: "롱스커트", image: "롱스커트.png", weather: "normal")
let wear33 = HomeWearInfo3(min_temp: 20, max_temp: 27, name: "면바지", image: "면바지.png", weather: "normal")
let wear34 = HomeWearInfo3(min_temp: 28, max_temp: 40, name: "미니스커트", image: "미니스커트.png", weather: "normal")
let wear35 = HomeWearInfo3(min_temp: 23, max_temp: 40, name: "반바지", image: "반바지.png", weather: "normal")
let wear36 = HomeWearInfo3(min_temp: -100, max_temp: -100, name: "방수신발", image: "방수신발.png", weather: "snow")
let wear37 = HomeWearInfo3(min_temp: 23, max_temp: 27, name: "스커트", image: "스커트.png", weather: "normal")
let wear38 = HomeWearInfo3(min_temp: 9, max_temp: 11, name: "스타킹", image: "스타킹.png", weather: "normal")
let wear39 = HomeWearInfo3(min_temp: 20, max_temp: 40, name: "슬랙스", image: "슬랙스.png", weather: "normal")
let wear310 = HomeWearInfo3(min_temp: -100, max_temp: -100, name: "장화", image: "장화.png", weather: "rain")
let wear311 = HomeWearInfo3(min_temp: -20, max_temp: 40, name: "청바지", image: "청바지.png", weather: "normal")

let wearList3:[HomeWearInfo3] = [wear31,wear32,wear33,wear34,wear35,wear36,wear37,wear38,wear39,wear310,wear311]

