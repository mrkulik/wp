//
//  AdsPopUpViewController.swift
//  BazilPapers
//
//  Created by Kulik on 8/9/20.
//  Copyright © 2020 Kulik. All rights reserved.
//

import UIKit
import GoogleMobileAds


protocol AdsPopUpViewControllerDelegate: class {
    func gotReward()
}


class AdsPopUpViewController: UIViewController {

    private var rewardedAd: GADRewardedAd?
    
    weak var delegate: AdsPopUpViewControllerDelegate?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var watchLabel: UILabel!
    @IBOutlet weak var watchSubtitleLabel: UILabel!
    
    @IBAction func sbscPressed(_ sender: UIButton) {
        let vc = IAPViewController.initial()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func watchPressed(_ sender: UIButton) {
        if rewardedAd?.isReady == true {
           rewardedAd?.present(fromRootViewController: self, delegate:self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.watchLabel.text = NSLocalizedString("Loading content", comment: "Loading content")
        self.watchSubtitleLabel.text = NSLocalizedString("please, wait", comment: "please, wait")
        
        rewardedAd = createAndLoadRewardedAd()
        // Do any additional setup after loading the view.
    }
    
    private func createAndLoadRewardedAd() -> GADRewardedAd? {
        rewardedAd = GADRewardedAd(adUnitID: "ca-app-pub-3940256099942544/1712485313")
        rewardedAd?.load(GADRequest()) { error in
            if let error = error {
                print("Loading failed: \(error)")
                self.watchLabel.text = NSLocalizedString("Watch unavailable", comment: "Watch unavailable")
                self.watchSubtitleLabel.text = NSLocalizedString("please, try again later", comment: "please, try again later")
            } else {
                self.watchLabel.text = NSLocalizedString("Watch", comment: "Watch")
                self.watchSubtitleLabel.text = NSLocalizedString("to save this wallpaper", comment: "to save this wallpaper")
            }
        }
        return rewardedAd
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AdsPopUpViewController: GADRewardedAdDelegate {
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        self.dismiss(animated: true, completion: {
            self.delegate?.gotReward()
        })
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.rewardedAd = createAndLoadRewardedAd()
    }
    
}


extension AdsPopUpViewController: IAPViewControllerDelegate {
    func didPurchase() {
        self.dismiss(animated: true, completion: {
            self.delegate?.gotReward()
        })
    }
}
