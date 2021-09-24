//
//  Array+Extention.swift
//  XavBotFramework
//
//  Created by Ajeet Sharma on 30/07/20.
//  Copyright © 2020 Ajeet Sharma. All rights reserved.
//

import Foundation
import UIKit


extension Array {

    mutating func remove(at indexs: [Int]) {
        guard !isEmpty else { return }
        let newIndexs = Set(indexs).sorted(by: >)
        newIndexs.forEach {
            guard $0 < count, $0 >= 0 else { return }
            remove(at: $0)
        }
    }

}
