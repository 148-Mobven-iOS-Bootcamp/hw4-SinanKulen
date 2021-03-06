//
//  WebViewContainerViewController.swift
//  UIComponents
//
//  Created by Semih Emre ÜNLÜ on 9.01.2022.
//

import UIKit
import WebKit

class WebViewContainerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWebView()
        configureActivityIndicator()
    }

    var urlString = "https://www.google.com"

    func configureWebView() {
     //   guard let url = URL(string: urlString) else { return }
     //   let urlRequest = URLRequest(url: url)
        
        let htmlCode = """
                    <div class="container">
                    <div class="terminal">
                    <p class="prompt">Mobven iOS Bootcamp Homework</p>
                    <p class="prompt output new-output"></p>
                    </div>
                    </div>
                    """
        webView.loadHTMLString(htmlCode, baseURL: nil)

        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false

        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
//        webView.configuration = configuration
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.addObserver(self,
                            forKeyPath: #keyPath(WKWebView.isLoading),
                            options: .new,
                            context: nil)
   //     webView.load(urlRequest)
    }

    func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.color = .red
        activityIndicator.hidesWhenStopped = true
    }

    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {

        if keyPath == "loading" {
            webView.isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }

    }

    @IBAction func reloadButtonTapped(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoBack {
            webView.goBack()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func forwardButtonTapped(_ sender: UIBarButtonItem) {
        if webView.canGoForward {
            webView.goForward()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    @IBAction func safariButtonTapped(_ sender: Any) {
        
        if let url = URL(string: "https://www.google.com") {
            UIApplication.shared.open(url)
        }
    }
}

extension WebViewContainerViewController: WKNavigationDelegate {
    
}

extension WebViewContainerViewController: WKUIDelegate {

}
