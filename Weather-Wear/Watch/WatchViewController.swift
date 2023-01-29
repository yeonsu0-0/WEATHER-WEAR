//
//  WatchViewController.swift
//  Weather-Wear
//
//  Created by yeonsu on 2023/01/25.
//

import UIKit
import YoutubePlayer_in_WKWebView

class WatchViewController:UIViewController {

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
        

    }
}
