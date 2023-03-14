//
//  ErrorSectionModel.swift
//  Messenger
//
//  Created by Vinodh Govindaswamy on 23/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit

struct ErrorSectionModel: SectionViewData {
    var sectionId: String
    
    var sectionType: String {
        return MessageSectionType.error.rawValue
    }

    var header: SectionHeaderViewData? = nil
    var items: [CellViewData]

    init(errorMessage: String, actionTitle: String) {
        items = [ErrorCellModel(errorMessage: errorMessage, actionTitle: actionTitle)]
        sectionId = UUID().uuidString
    }
}
