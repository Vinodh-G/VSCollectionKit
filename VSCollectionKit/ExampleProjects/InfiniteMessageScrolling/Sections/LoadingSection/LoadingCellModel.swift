//
//  LoadingCellModel.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 16/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit

struct LoadingCellModel: CellViewData {
    var cellId: String
    var cellType: String
    
    init(type: MessageCellType) {
        cellType = type.rawValue
        cellId = UUID().uuidString
    }
}
