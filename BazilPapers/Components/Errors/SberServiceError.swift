//
//  SberServiceError.swift
//  sberservice
//
//  Created by alex borisoft on 18.11.2019.
//  Copyright © 2019 sberbank. All rights reserved.
//

import Foundation


// MARK: - TODO: Make refactor error handling

enum SberServiceError: Error {
    case masterNotUUID
    case masterAvatarLinkNotFound
}
