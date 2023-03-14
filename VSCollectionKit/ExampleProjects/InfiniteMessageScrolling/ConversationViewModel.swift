//
//  MesengerViewModel.swift
//  MesengerUI
//
//  Created by Vinodh Govindaswamy on 13/02/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit
import MessageService
import Combine

protocol ConversationViewAPI {
    var title: String { get }
    var collectionViewData: CurrentValueSubject<VSCollectionViewData, Never> { get }
    func fetchMessages()
    func shouldLoadNextPage(indexPaths: [IndexPath]) -> Bool
    func fetchNextPage()
}

protocol ConversationViewDeleteAction {
    func deleteMessage(at indexPath: IndexPath)
}

protocol ConversationViewRetryAction {
    func retry()
}

internal class ConversationViewModel: ConversationViewAPI {

    var collectionViewData: CurrentValueSubject<VSCollectionViewData, Never> = CurrentValueSubject(VSCollectionViewData())

    var title: String {
        return "Poet's hangout"
    }

    private let conversationId: String
    private let interactor: ConversationInteractor
    private let mesengerUIConfig: MesengerUIConfig
    private var nextPageToken: String?
    private var requestTable: [String: Bool] = [:]
    private var sections: [String: SectionViewData] = [:]

    init(conversationId: String,
         interactor: ConversationInteractor = ConversationInteractor(),
         mesengerUIConfig: MesengerUIConfig = MesengerUIConfig()) {
        self.conversationId = conversationId
        self.interactor = interactor
        self.mesengerUIConfig = mesengerUIConfig
    }

    func fetchMessages() {
        collectionViewData.value = tableDataforInitialLoading()
        fetchMessage(requestPageToken: nil)
    }

    func fetchNextPage() {
        if let pageToken = nextPageToken,
            requestTable[pageToken] == nil {
            requestTable[pageToken] = true
            fetchMessage(requestPageToken: nextPageToken)
        }
    }

    private func fetchMessage(requestPageToken: String?) {

        let requestParam = MessagesRequestParam(conversationId: conversationId,
                                                pageSize: mesengerUIConfig.fetchSize,
                                                pageToken: nextPageToken)

        interactor.fetchMessages(messageRequestParam: requestParam) { [weak self] (messageResponse, error) in
            guard let self = self else { return }

            guard let response = messageResponse else {

                self.collectionViewData.value = self.collectionData(for: error)
                return
            }

            if let pageToken = response.pageToken {
                self.requestTable[pageToken] = nil
            }

            self.nextPageToken = response.pageToken
            self.collectionViewData.value = self.collectionData(for: response)
        }
    }
    
    func shouldLoadNextPage(indexPaths: [IndexPath]) -> Bool {
        if let messsageSection = sections[MessageSectionType.messages.rawValue] as? MessageSectionModel {
            let exceedingIndices = indexPaths.filter { $0.item >= (messsageSection.items.count - 1) }
            return !exceedingIndices.isEmpty
        }
        return false
    }
    
    private func collectionData(for response: MessagesResponse) -> VSCollectionViewData {

        var currentData = collectionViewData.value
        
        if var loadingSection = sections[MessageSectionType.loading.rawValue] as? LoadingSectionModel {
                        
            if response.pageToken != nil {
                currentData.deleteItems(loadingSection.items.map { CellSnapshot(cellModel: $0) })
                loadingSection.initialLoading = false
                currentData.appendItems(loadingSection.items.map { CellSnapshot(cellModel: $0) }, toSection: SectionSnapshot(viewData: loadingSection))
                sections[loadingSection.sectionType] = loadingSection
            } else {
                currentData.deleteSections([SectionSnapshot(viewData: loadingSection)])
                sections[loadingSection.sectionType] = nil
            }
            
            if var messageSection = sections[MessageSectionType.messages.rawValue] as? MessageSectionModel {
                let newItems = messageSection.cellModels(for: response.messages)
                messageSection.items.append(contentsOf: newItems)
                currentData.appendItems(newItems.map { CellSnapshot(cellModel: $0) }, toSection: SectionSnapshot(viewData: messageSection))
                sections[messageSection.sectionType] = messageSection
            } else {
                let messageSection = MessageSectionModel(messages: response.messages)
                let sectionSnapShot = SectionSnapshot(viewData: messageSection)
                currentData.insertSections([sectionSnapShot],
                                           beforeSection: SectionSnapshot(viewData: loadingSection))
                currentData.appendItems(messageSection.items.map { CellSnapshot(cellModel: $0) }, toSection: sectionSnapShot)
                sections[messageSection.sectionType] = messageSection
            }
        }
        
        return currentData
    }

    private func collectionData(for error: Error?) -> VSCollectionViewData {
        let currentData = collectionViewData.value

        return currentData
    }

    private func tableDataforInitialLoading() -> VSCollectionViewData {

        var collectionData = VSCollectionViewData()
        let section = LoadingSectionModel()
        let sectioSnapShot = SectionSnapshot(viewData: section)
        sections[section.sectionType] = section
        collectionData.appendSections([sectioSnapShot])
        collectionData.appendItems(section.items.map { CellSnapshot(cellModel: $0) }, toSection: sectioSnapShot)

        return collectionData
    }
}

extension ConversationViewModel: ConversationViewDeleteAction {

    func deleteMessage(at indexPath: IndexPath) {
//        guard var currData = tableViewData,
//            indexPath.section < currData.sections.count,
//            indexPath.row < currData.sections[indexPath.section].items.count else { return }
//
//        currData.resetUpdate()
//        currData.deleteItem(at: indexPath)
//
//        tableViewData = currData
//        guard let updateHandler = viewUpdateHandler else { return }
//        updateHandler(currData, nil)
    }
}

extension ConversationViewModel: ConversationViewRetryAction {
    func retry() {
//        guard var currData = collectionViewData,
//            let errorSection = tableViewData?.sectionModel(for: MessageSectionType.error.rawValue) else { return }
//        currData.resetUpdate()
//        currData.delete(section: errorSection)
//
//        var loadingSection = LoadingSectionModel()
//        loadingSection.initialLoading = currData.sections.count == 0 ? true : false
//        currData.add(section: loadingSection)
//
//        guard let updateHandler = viewUpdateHandler else { return }
//        updateHandler(currData, nil)
//        self.collectionViewData = currData

        fetchMessage(requestPageToken: nextPageToken)
    }
}

struct ConversationErrorHandler {
    // TODO: Error handling for different error types
    // Auto retry trigger based on error types
    static func errorMessage(for error: Error?) -> (String, String) {
        return ("Curently unable to load messages at this point of time, kindly retry.", "Retry")
    }
}

public struct MesengerUIConfig {
    public let fetchSize: Int = 20
}
