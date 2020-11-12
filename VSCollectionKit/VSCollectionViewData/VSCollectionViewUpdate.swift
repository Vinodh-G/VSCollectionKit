//
//  VNCollectionViewUpdate.swift
//  VSCollectionKit
//
//  Created by Vinodh Govindaswamy on 07/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

import Foundation

public struct VSCollectionViewUpdate {

    public enum UpdateType {
        case insert
        case delete
        case reload
    }

    public var updates: [Update]

    public init(updates: [Update]) {
        self.updates = updates
    }

    public struct Update {
        public let type: UpdateType
        public var updatedSections: IndexSet? = nil
        public var updatedRows: [DataIndexPath]? = nil

        public init(type: UpdateType, sections: IndexSet?, rows: [DataIndexPath]?) {
            self.type = type
            self.updatedSections = sections
            self.updatedRows = rows
        }
    }
}
