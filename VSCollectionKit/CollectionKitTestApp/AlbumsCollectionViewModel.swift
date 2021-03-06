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
    func fetchPhotos(callBack: @escaping CallBack)
}

typealias CallBack = (_ collectionData: VSCollectionViewData?, _ error: String?) -> Void

// Main View Model
class AlbumCollectionViewModel: AlbumCollectionViewAPI {

    let interactor: AlbumsInteractor
    init(interactor: AlbumsInteractor = AlbumsInteractor()) {
        self.interactor = interactor
    }

    var collectionViewData: VSCollectionViewData?

    func fetchPhotos(callBack: @escaping CallBack) {
        guard let urls = interactor.fetchAlbumUrls() else { return }
        var collectionData = VSCollectionViewData()
        let sectionSnap = SectionSnapshot(sectionModel: AlbumSectionModel(photoUrls: urls))
        collectionData.appendSections([sectionSnap])
        collectionData.appendItems(sectionSnap.cellSnapshots, toSection: sectionSnap)
        collectionViewData = collectionData
        callBack(collectionData, nil)
    }
}

struct AlbumSectionModel: SectionModel {
    
    var sectionId: String
    var cellItems: [CellModel] = []
    var header: HeaderViewModel?
    
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

struct PhotoCellModel: CellModel {
    var cellId: String
    
    var cellType: String {
        return AlbumCellType.photos.rawValue
    }

    let imageUrl: String
    init(photoUrl: String) {
        cellId = UUID().uuidString
        imageUrl = photoUrl
    }

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
