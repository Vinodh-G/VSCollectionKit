//
//  AlbumsCollectionViewModel.swift
//  CollectionKitTestApp
//
//  Created by Vinodh Govindaswamy on 19/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

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
        let section = AlbumSectionModel(photoUrls: urls)
        var collectionData = VSCollectionViewData()
        collectionData.add(section: section)
        collectionViewData = collectionData
        callBack(collectionData, nil)
    }
}

struct AlbumSectionModel: SectionModel {
    var sectionType: String {
        return AlbumSectionType.photos.rawValue
    }

    var sectionID: String
    var header: HeaderViewModel?
    var items: [CellModel] = []

    init(photoUrls: [String]) {
        self.sectionID = UUID().uuidString
        photoUrls.forEach { (url) in
            items.append(PhotoCellModel(photoUrl: url))
        }
    }
}

struct PhotoCellModel: CellModel {
    var cellType: String {
        return AlbumCellType.photos.rawValue
    }

    let cellID: String
    let imageUrl: String
    init(photoUrl: String) {
        cellID = UUID().uuidString
        imageUrl = photoUrl
    }

    var photoURL: String {
        return "PhotoData/\(imageUrl)"
    }
}

class AlbumsInteractor {
    func fetchAlbumUrls() -> [String]? {

        let fileManager = FileManager.default
        guard let contents = try? fileManager.contentsOfDirectory(atPath: "\(Bundle.main.bundlePath)/PhotoData") else { return nil }
        return contents
    }
}
