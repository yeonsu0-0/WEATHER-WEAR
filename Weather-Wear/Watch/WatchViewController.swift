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
    
    let playvarsDic = ["playsinline": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.load(withVideoId: "cSW0xgQaYsI", playerVars: playvarsDic)
        playerView2.load(withVideoId: "9-Hcdveq4nE", playerVars: playvarsDic)

    }
}
