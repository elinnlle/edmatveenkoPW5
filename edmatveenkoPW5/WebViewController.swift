//
//  WebViewController.swift (View)
//  edmatveenkoPW5
//
//  Created by Эльвира Матвеенко on 18.12.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    // MARK: - Properties
    var url: URL?
    private var webView: WKWebView!
    
    // MARK: - Constants
    private let webViewFrameInsets: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Setup WebView
        webView = WKWebView()
        view.addSubview(webView)
        webView.frame = view.bounds.insetBy(dx: webViewFrameInsets, dy: webViewFrameInsets) // Устанавливаем фрейм для webView
        if let url = url {
            webView.load(URLRequest(url: url)) // Загружаем URL в webView
        }
    }
}

