//
//  URL+Extention.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 16/07/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import Foundation
extension URL {
    var typeIdentifier: String? {
        return (try? resourceValues(forKeys: [.typeIdentifierKey]))?.typeIdentifier
    }
    var localizedName: String? {
        return (try? resourceValues(forKeys: [.localizedNameKey]))?.localizedName
    }
    
    func valueOfParameter(_ queryParamaterName: String) -> String? {
        guard let url = URLComponents(string: self.absoluteString) else { return nil }
        return url.queryItems?.first(where: { $0.name == queryParamaterName })?.value
    }
}
