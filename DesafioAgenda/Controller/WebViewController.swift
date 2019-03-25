//
//  WebViewController.swift
//  DesafioAgenda
//
//  Created by Rafael on 24/03/19.
//  Copyright © 2019 ALUNO. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var WebView: WKWebView!
    
    var site = URL(string: "https://www.google.com.br")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // let sit =  URL(string: "www.cade.com.br")
        let request = URLRequest(url: site!)
        WebView.load(request)
    }
    

}
