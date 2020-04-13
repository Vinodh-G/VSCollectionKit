//
//  VSCollectionViewDataTests.swift
//  VSCollectionKitTests
//
//  Created by Vinodh Govindaswamy on 13/04/20.
//  Copyright © 2020 Vinodh Govindaswamy. All rights reserved.
//

@testable import VSCollectionKit
import XCTest

class VSCollectionViewDataTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: Insert/Add Sections
    func testInsertSectionAtIndexVerifySectionCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection, at: 0)
        XCTAssertEqual(collectionData.sections.count, 3)
    }

    func testInsertSectionAtIndexVerifySectionName() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection, at: 0)
        guard let section = collectionData.sections[0] as? MockSectionModel else {
            XCTAssert(false, "Section type should be MockSectionModel")
            return
        }

        XCTAssertEqual(section.sectionName, "Section Three")
    }

    func testAddSectionVerifySectionCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Four")
        collectionData.add(section: newSection)
        XCTAssertEqual(collectionData.sections.count, 3)
    }

    func testAddSectionVerifySectionName() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Four")
        collectionData.add(section: newSection)
        guard let section = collectionData.sections.last as? MockSectionModel else {
            XCTAssert(false, "Section type should be MockSectionModel")
            return
        }

        XCTAssertEqual(section.sectionName, "Section Four")
    }

    func testAddItemsToSectionVerifyItemsCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections[0].items.count, 20)

        let newItems = [MockCellModel(cellType: "MockCell", cellInfo: "Cell Info New 1"),
                        MockCellModel(cellType: "MockCell", cellInfo: "Cell Info New 1")]
        collectionData.add(items: newItems, to: collectionData.sections[0])


        XCTAssertEqual(collectionData.sections[0].items.count, 22)
    }

    func testAddItemsToSectionVerifyItemsInfo() {
        var collectionData = mockCollectionViewData()

        let newItems = [MockCellModel(cellType: "MockCell", cellInfo: "Cell Info New 1"),
                        MockCellModel(cellType: "MockCell", cellInfo: "Cell Info New 2")]
        collectionData.add(items: newItems, to: collectionData.sections[0])

        guard let cellModel = collectionData.sections[0].items.last as? MockCellModel else {
            XCTAssert(false, "Cell type should be MockCellModel")
            return
        }

        XCTAssertEqual(cellModel.info, "Cell Info New 2")
    }

    func testSectionModelForType() {
        let collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)

        let mockSection = collectionData.sectionModel(for: "MockSection")
        XCTAssertNotNil(mockSection)
    }

    // MARK: Update Sections

    func testUpdateSectionVerifySectionName() {
        var collectionData = mockCollectionViewData()
        guard var firstSection = collectionData.sections[0] as? MockSectionModel else {
            XCTAssert(false, "Section should be of type MockSectionModel")
            return
        }
        firstSection.sectionName = "Updated SectionName"
        collectionData.update(newSection: firstSection)

        guard let updatedSection = collectionData.sections[0] as? MockSectionModel else {
            XCTAssert(false, "Section should be of type MockSectionModel")
            return
        }

        XCTAssertEqual(updatedSection.sectionName, "Updated SectionName")
    }

    func testUpdateSectionVerifySectionCount() {
        var collectionData = mockCollectionViewData()
        guard var firstSection = collectionData.sections[0] as? MockSectionModel else {
            XCTAssert(false, "Section should be of type MockSectionModel")
            return
        }
        firstSection.sectionName = "Updated SectionName"
        XCTAssertEqual(collectionData.sections.count, 2)
        collectionData.update(newSection: firstSection)
        XCTAssertEqual(collectionData.sections.count, 2)
    }

    func testUpdateItemsVerifyItemsCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections[0].items.count, 20)
        collectionData.deleteItem(at: IndexPath(item: 2, section: 0))
        XCTAssertEqual(collectionData.sections[0].items.count, 19)
    }

    // MARK: Delete Sections
    func testDeleteSectionVerifySectionCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections.count, 2)
        let firstSection = collectionData.sections[0]
        collectionData.delete(section: firstSection)
        XCTAssertEqual(collectionData.sections.count, 1)
    }

    func testDeleteItemsVerifyItemsCount() {
        var collectionData = mockCollectionViewData()
        XCTAssertEqual(collectionData.sections[0].items.count, 20)
        collectionData.deleteItem(at: IndexPath(item: 2, section: 0))
        XCTAssertEqual(collectionData.sections[0].items.count, 19)
    }

    func testDeleteItemsVerifyItemsInfo() {
        var collectionData = mockCollectionViewData()
        guard let cellModel = collectionData.sections[0].items[2] as? MockCellModel else { return }
        XCTAssertEqual(cellModel.info, "Cell 2")
        collectionData.deleteItem(at: IndexPath(item: 2, section: 0))

        guard let newCellModel = collectionData.sections[0].items[2] as? MockCellModel else { return }
        XCTAssertEqual(newCellModel.info, "Cell 3")
    }


    func testInitialUpdateValue() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()
        XCTAssertEqual(collectionData.update.updates.count, 0)
    }

    // MARK: CollectionData Insert Updates
    func testInsertSectionUpdateCount() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()
        XCTAssertEqual(collectionData.update.updates.count, 0)

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection, at: 0)

        XCTAssertEqual(collectionData.update.updates.count, 1)
    }

    func testInsertTwoSectionUpdateCount() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        let newSection2 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)
        collectionData.add(section: newSection2)

        XCTAssertEqual(collectionData.update.updates.count, 2)
    }

    func testInsertSectionUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection, at: 0)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.insert)
    }

    func testInsertSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection, at: 0)

        XCTAssertEqual(collectionData.update.updates[0].updatedSections, IndexSet(integer: 0))
    }

    func testInsertTwoSectionVerifyUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        let newSection2 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)
        collectionData.add(section: newSection2)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.insert)
        XCTAssertEqual(collectionData.update.updates[1].type, VSCollectionViewUpdate.UpdateType.insert)
    }

    func testInsertTwoSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        let newSection2 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)
        collectionData.add(section: newSection2)

        XCTAssertEqual(collectionData.update.updates[0].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[1].updatedSections, IndexSet(integer: 3))
    }

    func testInsertItemsTwoSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newItem1 = MockCellModel(cellType: "MockCell", cellInfo: "New Cell 1")
        let newItem2 = MockCellModel(cellType: "MockCell", cellInfo: "New Cell 1")
        collectionData.add(items: [newItem1], to: collectionData.sections[0])
        collectionData.add(items: [newItem2], to: collectionData.sections[1])

        XCTAssertEqual(collectionData.update.updates[0].updatedRows, [IndexPath(item: 20, section: 0)])
        XCTAssertEqual(collectionData.update.updates[1].updatedRows, [IndexPath(item: 20, section: 1)])
    }

    func testInsertItemsTwoSectionVerifyUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newItem1 = MockCellModel(cellType: "MockCell", cellInfo: "New Cell 1")
        let newItem2 = MockCellModel(cellType: "MockCell", cellInfo: "New Cell 1")
        collectionData.add(items: [newItem1], to: collectionData.sections[0])
        collectionData.add(items: [newItem2], to: collectionData.sections[1])

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.insert)
        XCTAssertEqual(collectionData.update.updates[1].type,VSCollectionViewUpdate.UpdateType.insert)
    }

    // MARK: CollectionData Delete Updates
    func testDeleteSectionUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let firstSection = collectionData.sections[0]
        collectionData.delete(section: firstSection)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.delete)
    }

    func testDeleteTwoSectionUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let section1 = collectionData.sections[0]
        let section2 = collectionData.sections[1]
        collectionData.delete(section: section2)
        collectionData.delete(section: section1)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.delete)
        XCTAssertEqual(collectionData.update.updates[1].type, VSCollectionViewUpdate.UpdateType.delete)
    }

    func testDeleteTwoSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section1 = collectionData.sections[0]
        let section3 = collectionData.sections[2]
        collectionData.delete(section: section1)
        collectionData.delete(section: section3)

        XCTAssertEqual(collectionData.update.updates[1].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[2].updatedSections, IndexSet(integer: 1))
    }

    func testDeleteItemsTwoSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        collectionData.deleteItem(at: IndexPath(item: 0, section: 0))
        collectionData.deleteItem(at: IndexPath(item: 19, section: 1))

        XCTAssertEqual(collectionData.update.updates[0].updatedRows, [IndexPath(item: 0, section: 0)])
        XCTAssertEqual(collectionData.update.updates[1].updatedRows, [IndexPath(item: 19, section: 1)])
    }

    // MARK: CollectionData Reload Updates

    func testReloadSectionUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let firstSection = collectionData.sections[0]
        collectionData.update(newSection: firstSection)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.reload)
    }

    func testReloadTwoSectionUpdateType() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let section1 = collectionData.sections[0]
        let section2 = collectionData.sections[1]
        collectionData.update(newSection: section1)
        collectionData.update(newSection: section2)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.reload)
        XCTAssertEqual(collectionData.update.updates[1].type, VSCollectionViewUpdate.UpdateType.reload)
    }

    func testUpdateTwoSectionVerifyUpdateIndexPath() {
        var collectionData = mockCollectionViewData()
        collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section1 = collectionData.sections[0]
        let section2 = collectionData.sections[1]
        collectionData.update(newSection: section1)
        collectionData.update(newSection: section2)

        XCTAssertEqual(collectionData.update.updates[1].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[2].updatedSections, IndexSet(integer: 1))
    }

    // MARK: Insert/Delete/Update Combination

    func testInsertDeleteUpdateSectionsVerifyUpdateCount() {
        var collectionData = mockCollectionViewData()
         collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section3 = collectionData.sections[2]
        collectionData.delete(section: section3)
        collectionData.update(newSection: newSection1)

        XCTAssertEqual(collectionData.update.updates.count, 3)
    }

    func testInsertDeleteUpdateSectionsVerifyUpdateType() {
        var collectionData = mockCollectionViewData()
         collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section3 = collectionData.sections[2]
        collectionData.delete(section: section3)
        collectionData.update(newSection: newSection1)

        XCTAssertEqual(collectionData.update.updates[0].type, VSCollectionViewUpdate.UpdateType.insert)
        XCTAssertEqual(collectionData.update.updates[1].type, VSCollectionViewUpdate.UpdateType.delete)
        XCTAssertEqual(collectionData.update.updates[2].type, VSCollectionViewUpdate.UpdateType.reload)
    }

    func testInsertDeleteUpdateSectionsVerifyUpdateIndexPaths() {
        var collectionData = mockCollectionViewData()
         collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section3 = collectionData.sections[2]
        collectionData.delete(section: section3)
        collectionData.update(newSection: newSection1)

        XCTAssertEqual(collectionData.update.updates[0].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[1].updatedSections, IndexSet(integer: 2))
        XCTAssertEqual(collectionData.update.updates[2].updatedSections, IndexSet(integer: 0))
    }

    func testInsertDeleteUpdateItemsAndSectionsVerifyUpdateIndexPaths() {
        var collectionData = mockCollectionViewData()
         collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)
        collectionData.add(items: [MockCellModel(cellType: "MockCell", cellInfo: "Cell 21")], to: collectionData.sections[1])
        collectionData.deleteItem(at: IndexPath(item: 19, section: 1))

        let section3 = collectionData.sections[2]
        collectionData.delete(section: section3)
        collectionData.update(newSection: newSection1)

        XCTAssertEqual(collectionData.update.updates[0].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[1].updatedRows, [IndexPath(item: 20, section: 1)])
        XCTAssertEqual(collectionData.update.updates[2].updatedRows, [IndexPath(item: 19, section: 1)])
        XCTAssertEqual(collectionData.update.updates[3].updatedSections, IndexSet(integer: 2))
        XCTAssertEqual(collectionData.update.updates[4].updatedSections, IndexSet(integer: 0))
    }

    func testInsertDeleteUpdateItemsAndSectionsVerifyUpdateIndexPathsCase2() {
        var collectionData = mockCollectionViewData()
         collectionData.resetUpdate()

        let newSection1 = MockSectionModel(sectionType: "MockSection", sectionName: "Section Three")
        collectionData.insert(section: newSection1, at: 0)

        let section3 = collectionData.sections[2]
        collectionData.delete(section: section3)
        collectionData.update(newSection: newSection1)

        collectionData.add(items: [MockCellModel(cellType: "MockCell", cellInfo: "Cell 21")], to: collectionData.sections[0])
        collectionData.deleteItem(at: IndexPath(item: 5, section: 1))

        XCTAssertEqual(collectionData.update.updates[0].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[1].updatedSections, IndexSet(integer: 2))
        XCTAssertEqual(collectionData.update.updates[2].updatedSections, IndexSet(integer: 0))
        XCTAssertEqual(collectionData.update.updates[3].updatedRows, [IndexPath(item: 20, section: 0)])
        XCTAssertEqual(collectionData.update.updates[4].updatedRows, [IndexPath(item: 5, section: 1)])
    }
}
