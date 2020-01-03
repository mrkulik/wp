//
//  ChainController+NotifyInMain.swift
//  sberservice
//
//  Created by User on 9/11/19.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation

extension ChainController {
    func notifyAboutSuccessInMain(object: Any?) {
        DispatchQueue.main.async {
            self.notifyAboutSuccess(object: object)
        }
    }
    
    func notifyAboutFailInMain(error: Error?) {
        DispatchQueue.main.async {
            self.notifyAboutFail(error: error)
        }
    }
}
