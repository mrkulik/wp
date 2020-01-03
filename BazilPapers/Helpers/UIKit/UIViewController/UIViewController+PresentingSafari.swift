//
//  UIViewController+PresentingSafari.swift
//  sberservice
//
//  Created by admin on 7/22/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation
import SafariServices

extension UIViewController {
    func presentSafariViewController(url: URL?) {
        guard let url = url else {
            return
        }
        
        let vc = self.makeSafariViewController(url: url)
        self.present(vc, animated: true)
    }

    func makeSafariViewController(url: URL) -> SFSafariViewController {
        let vc = SFSafariViewController(url: url)
        vc.delegate = UIViewController.safariDelegate
        
        return vc
    }
    
    private static let safariDelegate = WebViewControllerDelegate()
}

fileprivate class WebViewControllerDelegate: NSObject, SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

