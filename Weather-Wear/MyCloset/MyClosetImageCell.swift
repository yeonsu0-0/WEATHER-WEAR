//
//  MyClosetImageCell.swift
//  Weather-Wear
//
//  Created by 이지민 on 2023/01/29.
//

import UIKit

struct MyClosetImageCell {
    
    let num: Int
    let temp: Int
    let image: UIImage
    let date: String
    var favorite: Bool
    var select: Bool
    
}

var image1 = MyClosetImageCell(num: 1,temp: 3,image: UIImage(named: "image1")!,date: "23년 1월 21일", favorite: true, select: false)
var image2 = MyClosetImageCell(num: 2,temp: 3,image: UIImage(named: "image2")!,date: "23년 1월 21일", favorite: true, select: false)
var image3 = MyClosetImageCell(num: 3,temp: 3,image: UIImage(named: "image3")!,date: "23년 1월 21일", favorite: true, select: false)
var image4 = MyClosetImageCell(num: 4,temp: 5,image: UIImage(named: "image4")!,date: "23년 1월 21일", favorite: false, select: false)
var image5 = MyClosetImageCell(num: 5,temp: 5,image: UIImage(named: "image5")!,date: "23년 1월 21일", favorite: true, select: false)
var image6 = MyClosetImageCell(num: 6,temp: 5,image: UIImage(named: "image6")!,date: "23년 1월 21일", favorite: true, select: false)
var image7 = MyClosetImageCell(num: 7,temp: 9,image: UIImage(named: "image7")!,date: "23년 1월 21일", favorite: true, select: false)
var image8 = MyClosetImageCell(num: 8,temp: 9,image: UIImage(named: "image8")!,date: "23년 1월 21일", favorite: true, select: false)
var image9 = MyClosetImageCell(num: 9,temp: 9,image: UIImage(named: "image9")!,date: "23년 1월 21일", favorite: true, select: false)
var image10 = MyClosetImageCell(num: 10,temp: 12,image: UIImage(named: "image10")!,date: "23년 1월 21일", favorite: true, select: false)
var image11 = MyClosetImageCell(num: 11,temp: 12,image: UIImage(named: "image11")!,date: "23년 1월 21일", favorite: true, select: false)
var image12 = MyClosetImageCell(num: 12,temp: 12,image: UIImage(named: "image12")!,date: "23년 1월 21일", favorite: true, select: false)
var image13 = MyClosetImageCell(num: 13,temp: 5,image: UIImage(named: "image13")!,date: "23년 1월 21일", favorite: true, select: false)

var MyClosetList:[MyClosetImageCell] = [image1,image2,image3,image4,image5,image6,image7,image8,image9,image10,image11,image12,image13]

