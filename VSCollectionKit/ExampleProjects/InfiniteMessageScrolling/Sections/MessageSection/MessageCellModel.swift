//
//  MessageCellModel.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 15/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import MessageService
import VSCollectionKit

protocol MessageCellAPI {
    var authorName: String { get }
    var authorImageURL: String { get }
    var messageContent: String { get }
    var timestamp: String { get }
}

struct MessageCellModel: CellViewData, MessageCellAPI {
    
    init(message: MessagesResponse.Message) {
        self.message = message
        self.cellId = UUID().uuidString
    }

    var cellId: String
    
    private let message: MessagesResponse.Message

    var cellType: String {
        return MessageCellType.messages.rawValue
    }
    
    var authorName: String {
        return message.author.name
    }

    var authorImageURL: String {
        return "\(messengerbaseURL)\(message.author.photoUrl ?? "")"
    }

    var messageContent: String {
        return message.content
    }

    var timestamp: String {
        return message.lastUpdated.elapsedTimeString()
    }
}
