//
//  AlbumsCollectionViewModel.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit
import Combine

protocol AlbumViewData {
    var collectionViewData: CurrentValueSubject<VSCollectionViewData, Never> { get }
}

protocol AlbumCollectionViewAPI: AlbumViewData {
    
    func fetchPhotos()
    var isEditing: Bool { get  set }
}

// Main View Model
class AlbumCollectionViewModel: AlbumCollectionViewAPI {

    init(interactor: AlbumsInteractor = AlbumsInteractor(), isEditing: Bool = false) {
        self.interactor = interactor
        self.isEditing = isEditing
    }
    
    let interactor: AlbumsInteractor
    var isEditing: Bool
    var collectionViewData: CurrentValueSubject<VSCollectionViewData, Never> = CurrentValueSubject(VSCollectionViewData())
    
    var canSelect: Bool {
        return isEditing
    }

    func fetchPhotos() {
        guard let urls = interactor.fetchAlbumUrls() else { return }
        var collectionData = VSCollectionViewData()
        let sectionSnap = SectionSnapshot(viewData: AlbumSectionModel(photoUrls: urls, viewData: self))
        guard let sectionModel = sectionSnap.viewData as? AlbumSectionModel else { return }
        
        collectionData.appendSections([sectionSnap])
        collectionData.appendItems(sectionModel.cellItems.map { CellSnapshot(cellModel: $0) }, toSection: sectionSnap)
        collectionViewData.value = collectionData
    }
}

struct AlbumSectionModel: SectionViewData {
    
    var sectionId: String
    var cellItems: [CellViewData] = []
    var header: SectionHeaderViewData?
    
    var sectionType: String {
        return AlbumSectionType.photos.rawValue
    }

    init(photoUrls: [String], viewData: AlbumViewData) {
        self.sectionId = ProcessInfo.processInfo.globallyUniqueString
        photoUrls.forEach { (url) in
            cellItems.append(PhotoCellModel(photoUrl: url, viewData: viewData))
        }
    }
}

struct PhotoCellModel: CellViewData {
    
    var cellId: String
    var viewData: AlbumViewData

    let imageUrl: String
    init(photoUrl: String, viewData: AlbumViewData) {
        self.cellId = UUID().uuidString
        self.imageUrl = photoUrl
        self.viewData = viewData
    }
    
    var cellType: String {
        return AlbumCellType.photos.rawValue
    }

    var isSelected: Bool = false
    
    var photoURL: String {
        return "PhotoData/\(imageUrl)"
    }
}

struct AlbumsInteractor {
    
    let fileManager: FileManager
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
    }
    
    func fetchAlbumUrls() -> [String]? {

        guard let contents = try? fileManager.contentsOfDirectory(atPath: "\(Bundle.main.bundlePath)/PhotoData") else { return nil }
        return contents
    }
}
