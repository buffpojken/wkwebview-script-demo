//
//  ViewController.swift
//  tombo
//
//  Created by Daniel Sundström on 2017-01-05.
//  Copyright © 2017 Daniel Sundström. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKScriptMessageHandler {

    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        let content = WKUserContentController()
        content.add(self, name: "mungo")
        let config = WKWebViewConfiguration()
        config.userContentController = content;
        
        webView = WKWebView(frame: self.view.bounds, configuration: config)
        self.view = webView!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = Bundle.main.url(forResource: "index", withExtension: "html"){
            webView!.loadFileURL(url, allowingReadAccessTo: url)
        }
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        switch(message.name){
            case "mungo":
                print("This was called");
                print(message.body)        
            default:
                    print("unknown message called...");
            
        }
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake{
            webView!.evaluateJavaScript("nativeCall()", completionHandler: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

