//
//  ErrorCellModel.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 23/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit

struct ErrorCellModel: CellViewData {
    var cellId: String
    let errorMessage: String
    let actionTitle: String
    
    var cellType: String {
        return MessageCellType.error.rawValue
    }
    
    init(errorMessage: String, actionTitle: String) {
        self.errorMessage = errorMessage
        self.actionTitle = actionTitle
        self.cellId = UUID().uuidString
    }
}
