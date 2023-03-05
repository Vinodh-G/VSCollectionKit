//
//  AlbumsCollectionViewModel.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation
import VSCollectionKit

protocol AlbumCollectionViewAPI {
    var collectionViewData: VSCollectionViewData? { get set }
    func fetchPhotos()
    var viewUpdateBlock: ViewUpdateBlock? { get set }
    var isEditing: Bool { get  set }
}


protocol PhotosSelectionAPI {
    var canSelect: Bool { get }
    func select(cellModel: CellViewData)
}

typealias ViewUpdateBlock = (_ collectionData: VSCollectionViewData?, _ error: String?) -> Void

// Main View Model
class AlbumCollectionViewModel: AlbumCollectionViewAPI {

    let interactor: AlbumsInteractor
    var isEditing: Bool
    var viewUpdateBlock: ViewUpdateBlock?
    
    init(interactor: AlbumsInteractor = AlbumsInteractor(), isEditing: Bool = false) {
        self.interactor = interactor
        self.isEditing = isEditing
    }

    var collectionViewData: VSCollectionViewData?
    
    var canSelect: Bool {
        return isEditing
    }

    func fetchPhotos() {
        guard let urls = interactor.fetchAlbumUrls() else { return }
        var collectionData = VSCollectionViewData()
        let sectionSnap = SectionSnapshot(viewData: AlbumSectionModel(photoUrls: urls))
        guard let sectionModel = sectionSnap.viewData as? AlbumSectionModel else { return }
        
        collectionData.appendSections([sectionSnap])
        collectionData.appendItems(sectionModel.cellItems.map { CellSnapshot(cellModel: $0) }, toSection: sectionSnap)
        collectionViewData = collectionData
        viewUpdateBlock?(collectionData, nil)
    }
}

extension AlbumCollectionViewModel: PhotosSelectionAPI {
    func select(cellModel: CellViewData) {

    }
}

struct AlbumSectionModel: SectionViewData {
    
    var sectionId: String
    var cellItems: [CellViewData] = []
    var header: SectionHeaderViewData?
    
    var sectionType: String {
        return AlbumSectionType.photos.rawValue
    }

    init(photoUrls: [String]) {
        self.sectionId = ProcessInfo.processInfo.globallyUniqueString
        photoUrls.forEach { (url) in
            cellItems.append(PhotoCellModel(photoUrl: url))
        }
    }
}

struct PhotoCellModel: CellViewData {
    var cellId: String
    
    var cellType: String {
        return AlbumCellType.photos.rawValue
    }

    let imageUrl: String
    init(photoUrl: String) {
        cellId = UUID().uuidString
        imageUrl = photoUrl
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
