//
//  DetailViewController.swift
//  Quarantine
//
//  Created by Volodymyr on 10/6/19.
//  Copyright © 2019 Home. All rights reserved.
//

import UIKit
import WebKit

protocol EmailApproveDelegate: class {
    func approve(_ email: Email)
    func reject(_ email: Email)
}

class DetailViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView?
    @IBOutlet weak var typeEmailLable: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var infoImageView: UIImageView!
    @IBOutlet weak var webView: WKWebView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    // MARK: - Properties
    weak var delegate: EmailApproveDelegate?
    private (set) var viewModel: DetailViewModel?
    
    
    // MARK: -  Initializations and Deallocations
    static func instantiate(_ viewModel: DetailViewModel) -> DetailViewController {
        let controller = DetailViewController.instantiateViewControllerFromMain(identifier: "DetailViewController")
        controller.viewModel = viewModel

        return controller
    }
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = viewModel?.title
        self.congigureView()
        self.setupViewModel()
    }

    
    // MARK: - IBActions
    @IBAction func onApprove(_ sender: UIButton) {
        viewModel?.email.map { delegate?.approve($0) }
    }
    
    @IBAction func onRegect(_ sender: UIButton) {
        viewModel?.email.map { delegate?.approve($0) }
    }
    
    
    // MARK: - Private methods
    private func setupViewModel() {
        if viewModel.isEmpty {
            self.viewModel = DetailViewModel(email: nil)
        }
    }
    private func congigureView() {
        self.webView?.navigationDelegate = self
        authorImageView.roundAllCorners(Float(authorImageView.frame.width / 2))
        authorImageView.addBorder(color: .green, thickness: 2)
        self.updateView()
    }
    
    private func updateView() {
        self.activityIndicator?.startAnimating()
        viewModel.map { viewModel in
            webView?.evaluateJavaScript("document.body.remove()", completionHandler: nil)
            let request = URLRequest.init(url: viewModel.rundomUrl(),
                                          cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 30)
            self.webView?.load(request)
        }

        viewModel?.email.map {
            self.typeEmailLable.text = $0.type.string + ": "
            self.authorImageView.setImage(with: $0.avatarUrl)
            self.authorNameLabel.text = $0.authorName
            self.bodyLabel.text = $0.body
        }
        
        contentView?.isHidden = (viewModel?.email.isEmpty).default
    }
}

extension DetailViewController: EmailSelectionDelegate {
    func didSelectEmailCell(_ email: Email?) {
        viewModel?.email = email
        self.updateView()
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator?.stopAnimating()
    }
}
