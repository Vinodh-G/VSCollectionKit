# VSCollectionKit

VSCollectionKit is handy framework supporting funtionality of a UICollectionView or UICollectionViewController with much easier than way we work with UICollectionView, and avoiding a lot of code duplicates. 

VSCollectionKit consist of VSCollectionViewController is subclass of UIViewController with UICollectionView, VSCollectionViewController works in association with 5 other parts like VSCollectionViewDataSource,
VSCollectionViewData,
VSCollectionViewDelegate,
VSCollectionViewLayoutProvider &
VSCollectionViewSectionHandller

As the names of the above components slightly justifys what actaully they are meant for, still will go over one by one

VSCollectionViewDataSource is subclass of NSObject confirming to UICollectionViewDataSource, this is class which is mainly involved in handling or supplying data to our collectionView, is takes VSCollectionViewData and applies the new insertions or update changes to current UICollectionView.
this is very import piece in VSCollectionKit, we moslty not be interacting with it, we only talk directly to VSCollectionViewController

VSCollectionViewData is struct moslty contains the details about our collectionviewData, 
struct VSCollectionViewData {
    public var sections: [SectionModel] = []
    private var updates: [VSCollectionViewUpdate.Update] = []
}

this contains array of sections confirming to SectionModel protocol, and an updates array containing details about the changes in data which is getting applied to a collection via VSCollectionViewDataSource

the SectionModel, CellModel and HeaderViewModel protocols looks somthing like below

public protocol SectionModel {
    var sectionType: String { get }
    var sectionID: String { get }
    var header: HeaderViewModel? { get }
    var items: [CellModel] { get set }
}

public protocol HeaderViewModel {
    var headerType: String { get }
}

public protocol CellModel {
    var cellType: String { get }
    var cellID: String { get }
}

VSCollectionViewDelegate  is subclass of NSObject confirming to UICollectionViewDelegate, this class  mainly involved in handling delegate events of collectionView, not we are not using this delegate for determining the size of cell or supplymentoryview


VSCollectionViewLayoutProvider as name suggests that is guy is resposible for supplying the layout informations to collectionView, this is using UICollectionViewCompostionalLayout, but still will not be using it direclty rather we would be supplying the layout information via this

VSCollectionViewSectionHandller the last and important component of VSCollectionKit with which we would be moslty interacting with, we would be supplying the cell information, layout information and handling events from the collectionView via VSCollectionViewSectionHandller, will look the below class diagram to find more details on how are they connected.
