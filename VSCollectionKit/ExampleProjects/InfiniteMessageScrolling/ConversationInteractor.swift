//
//  ConversationInteractor.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 13/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import MessageService

class ConversationInteractor {

    let service: MessagesAPI
    init(service: MessagesAPI = MessageServicePlugin.messageServicePlugin()) {
        self.service = service
    }

    func fetchMessages(messageRequestParam: MessagesRequestParam, callback: @escaping (_ messageResponse: MessagesResponse?, _ error: Error?) -> Void) {

        service.chatMessages(for: messageRequestParam) { (responseParam) in
            guard let messageResponse = responseParam.messages else {
                callback(nil, responseParam.error)
                return
            }
            
            // TODO: write the messages to database service, so next time, when user launches the app,
            // uses the message from DB and fetch the messages later from service
            callback(messageResponse, nil)
        }
    }
}
