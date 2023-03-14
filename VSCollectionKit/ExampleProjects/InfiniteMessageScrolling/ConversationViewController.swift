//
//  ViewController.swift
//  InfiniteMessageScrolling
//
//  Created by Vinodh Swamy on 11/03/23.
//  Copyright © 2023 Vinodh Govindaswamy. All rights reserved.
//

import UIKit
import VSCollectionKit
import Combine

enum MessageSectionType: String {
    case loading
    case messages
    case error
}

enum MessageCellType: String {
    case loadingskeleton
    case loadMore
    case messages
    case error
}

class ConversationViewController: VSCollectionViewController {

    private var viewModel: ConversationViewAPI
    private var cancelBag: Set<AnyCancellable> = []
    
    init(viewModel: ConversationViewAPI) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.title
        observeViewModelUpdates()
        viewModel.fetchMessages()
        
        configureNavBar()
        observePrefetchTrigger()
        self.overrideUserInterfaceStyle = .light
    }
    
    override var sectionHandlerTypes: [String : SectionHandler.Type] {
        return [MessageSectionType.loading.rawValue: LoadingSectionHandler.self,
                MessageSectionType.error.rawValue: ErrorSectionHandler.self,
                MessageSectionType.messages.rawValue: MessageSectionHandler.self]
    }
    
    private func configureNavBar() {
        // TODO: SearchController not functional yet, need to work on this extended time
        let searchController = UISearchController()
        searchController.searchBar.isUserInteractionEnabled = false
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = UIColor.white
        navigationController?.view.backgroundColor = UIColor.white
        navigationController?.overrideUserInterfaceStyle = .light
    }

    private func observeViewModelUpdates() {

        viewModel.collectionViewData
            .sink { [weak self] (collectionData) in
                guard let self = self else { return }
                self.apply(collectionData: collectionData)
            }
            .store(in: &cancelBag)
    }
    
    private func observePrefetchTrigger() {
        preFetchDidTrigger = { [weak self] (indexpaths) in
            guard let self = self,
                  self.viewModel.shouldLoadNextPage(indexPaths: indexpaths) else { return }
            self.viewModel.fetchNextPage()
        }
    }
}

