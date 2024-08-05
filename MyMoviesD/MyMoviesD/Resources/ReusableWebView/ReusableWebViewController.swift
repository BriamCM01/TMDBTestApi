//
//  ReusableWebViewController.swift
//  MyMoviesD
//
//  Created by Briam Cano on 05/08/24.
//

import UIKit
import WebKit

class ReusableWebViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webViewReuse: WKWebView!
    @IBOutlet weak var btnClose: UIButton!
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupWebView()
    }
    
    init(url: String) {
        super.init(nibName: "ReusableWebViewController", bundle: .main)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        fatalError("Init coder has not implemented")
    }
    
    func setupWebView() {
        webViewReuse.navigationDelegate = self
        if let url = URL(string: url) {
            let urlRequest = URLRequest(url: url)
            webViewReuse.load(urlRequest)
        }
    }
    
    @IBAction func didTouchClose(_ sender: Any) {
        dismiss(animated: true)
    }
    
}
