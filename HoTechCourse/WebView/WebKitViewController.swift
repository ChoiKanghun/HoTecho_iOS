//
//  WebKitViewController.swift
//  HoTechCourse
//
//  Created by 최강훈 on 2021/05/04.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {

    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // viewDidLoad() 바로 다음에 함수를 호출하여 웹뷰가 즉시 출력될 수 있도록 작성
        loadWebPage("https://www.chaenchoi.com")
    }
    //웹뷰 로드 기능을 하는 함수 생성
    func loadWebPage(_ url:String) {
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        myWebView.load(myRequest)
    }
}
