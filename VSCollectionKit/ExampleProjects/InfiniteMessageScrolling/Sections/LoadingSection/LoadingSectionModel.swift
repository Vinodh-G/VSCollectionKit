//
//  LoadingSectionModel.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 16/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import VSCollectionKit

struct LoadingSectionModel: SectionViewData {
    
    init() {
        sectionId = UUID().uuidString
        items = cellModels(initialLoading: initialLoading)
    }
    
    var sectionId: String
    var header: SectionHeaderViewData? = nil
    var items: [CellViewData] = []
    
    var sectionType: String {
        return MessageSectionType.loading.rawValue
    }
    
    var initialLoading: Bool = true {
        didSet {
            items = cellModels(initialLoading: initialLoading)
        }
    }

    func cellModels(initialLoading: Bool) -> [CellViewData] {
        return initialLoading ? (1..<6).map{ _ in LoadingCellModel(type: .loadingskeleton) } : [LoadingCellModel(type: .loadMore)]
    }
}
