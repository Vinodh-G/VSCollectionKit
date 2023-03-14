//
//  MessageSectionModel.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 15/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import MessageService
import VSCollectionKit

struct MessageSectionModel: SectionViewData {
    
    init(messages: [MessagesResponse.Message]) {
        self.messages = messages
        self.sectionId = UUID().uuidString
        self.items = cellModels(for: self.messages)
    }
    
    var sectionId: String
    
    var sectionType: String {
        return MessageSectionType.messages.rawValue
    }
    var header: SectionHeaderViewData? = nil
    var items: [CellViewData] = []

    private let messages: [MessagesResponse.Message]

    func cellModels(for messages: [MessagesResponse.Message]) -> [MessageCellModel] {
        let messageCellModels = messages.map { MessageCellModel(message: $0) }
        return messageCellModels
    }
}
