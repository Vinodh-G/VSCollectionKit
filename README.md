# VSCollectionKit


**VSCollectionKit** is a library for building applications views/screens in a consistent and understandable way, with advantages like composition, independent and testing.

VSCollectionView a handy framework supporting functionality of a UICollectionView or UICollectionViewController in a much simpler way. VSCollectionKit also avoids a lot of collectionView related code hassle and duplicates.

Lets see what we get using this kit for developing the application views.

**Composition:** VSCollectionKit breaks down larger features into smaller components that can be isolated modules and be easily combined to form a full feature.

**Mobility:** Using VSCollectionKit, we can develop a component to be independent ie., the component doesn't know anything about the user using it. This gives us a confident of using it in multiple places of same project hassle free.

**Testing:** Using VSCollectionKit, each and every component can be tested individually. As it makes smaller independent components to become a bigger complex viewcontrollers, there will be less or NIL integrity issues (fixing in one place which causes a bug in a different place).

Here is an example that helps you to understand better. The screenshots of the Test app developed using VSCollectionKit presented below.
![](Images/VSCollectionKit_Examples2.png)


### VSCollectionKit Components
VSCollectionKit consist of VSCollectionViewController which  is subclass of UIViewController with UICollectionView. 
VSCollectionViewController works in association with 5 other parts like
- VSCollectionViewDataSource
- VSCollectionViewData
- VSCollectionViewDelegate
- VSCollectionViewLayoutProvider
- VSCollectionViewSectionHandller

Though the component names justify their functionality, a brief description for our strong foundations.

**VSCollectionViewDataSource** is a subclass of NSObject confirming to UICollectionViewDataSource mainly involved in handling or supplying data to our collectionView. It takes VSCollectionViewData and applies inserting and updating the  changes to the current UICollectionView.

**VSCollectionViewData** is a struct that mostly contains the details about our data to be displayed on CollectionView. It contains an array of sections confirming to SectionModel protocol. Also, updates array containing details about the changes in data which is getting applied to a collection via VSCollectionViewDataSource.

The SectionModel, CellModel and HeaderViewModel protocols looks somthing like below

[](https://gist.github.com/Vinodh-G/d13272bb648c06ea3244e723b8c86215)

```
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
```

**VSCollectionViewDelegate** is subclass of NSObject confirming to UICollectionViewDelegate. This class mainly involves handling delegate events of collectionView. Please note that we are not using this delegate for determining the size of cell or supplementary view.

**VSCollectionViewLayoutProvider** is component who is responsible for supplying the layout information to the collectionView. VSCollectionKit uses UICollectionViewCompostionalLayout for cell and supplementaryview size information.

**VSCollectionViewSectionHandller** would supply the cell information, layout information and helps in handling events from the collectionView via VSCollectionViewSectionHandller.

![](Images/VSCollectionKit_Class_Diagram.png)

That's the theoretical view VSCollectionKit and its components!!!!

### How to use VSCollectionKit?

**VSCollectionViewSectionHandller** VSCollectionViewSectionHandller handles adding and removing of SectionHandler for the VSCollectionViewController. We can have n number of sections supported by collectionview via VSCollectionViewSectionHandller's addSectionHandler(handler: SectionHandler) function.

The protocol declaration of SectionHandler is as below.
```
public protocol SectionHandler: SectionLayoutInfo {
    var type: String { get }
    func registerCells(for collectionView: UICollectionView)
    func cellProvider(_ collectionView: UICollectionView,
                      _ indexPath: IndexPath,
                      _ cellModel: CellModel) -> UICollectionViewCell
    
    var sectionHeaderFooterProvider: SectionHeaderFooterProvider? { get }
    var sectionDelegateHandler: SectionDelegateHandler? { get }
}

public protocol SectionHeaderFooterProvider: AnyObject {
    func supplementaryViewProvider(_ collectionView: UICollectionView,
                                   _ kind: String,
                                   _ indexPath: IndexPath,
                                   _ headerViewModel: HeaderViewModel) -> UICollectionReusableView?
}

public protocol SectionLayoutInfo: AnyObject {
    func sectionLayoutProvider(_ sectionModel: SectionModel,
                               _ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection?
}

public protocol SectionDelegateHandler: AnyObject {
    func didSelect(_ collectionView: UICollectionView,
                   _ indexPath: IndexPath,
                   _ cellModel: CellModel)
    func willDisplayCell(_ collectionView: UICollectionView,
                         _ indexPath: IndexPath,
                         _ cell: UICollectionViewCell,
                         _ cellModel: CellModel)
}
```

Probably you caught them right!! Yes the collectionview related functions falls in the individual SectionHandler.It seems to be less complexed because it contains only the necessary functions to be implemented, if we still need more we can always go and extent it from components like VSCollectionViewDataSource and VSCollectionViewDelegate.

# An example on how we can use VSCollectionKit to display grid of photos from local.

As you know, the VSCollectionViewController understands data by VSCollectionData, so our example is quite simple showing list of photos in CollectionView. We would be converting the list of image urls to VSCollectionData's SectionModel and CellModel.

A quick snippet of what i was talking about.
![](/Images/AlbumSectionmodel.png)

Having a thought on how we are providing the cell and layout information? Let's think it together! We need to create a class confirming to protocol SectionHandler, which is where we would be implementing the necessary functions to supply the cell and layout information to the collection view.

![](/Images/AlbumsSectionHandlers.png)

The final touch of how are we applying the data to collectionView shown below.
![](/Images/QuickSnipet_Howtoapplycollectiondat.png)
So we need to override func willAddSectionControllers() and add all the sectionHandlers which we would be using in our collectionView, provided each sectionControllers should confirm to protocol SectionHandler as shown above.



### How to Use VSCollectionKit in project

Include the below line in the project cathrage file
```
  git "https://github.com/Vinodh-G/VSCollectionKit.git" >= 0.3
```  
and then call ``` carthage update ``` from the project folder where it is used.

The above step will get vscollectionkit to your project, now go to your app project settings
click on build phase, scroll to embed framework section.
Add vscollectionkit.framework to embed framework section by clicking the + icon (Note you can find the vscollectionkit.framework in path /Carthage/Build/iOS/VSCollectionKit.framework inside your project) 

Something similar as shown below used in the NewsApp.
<img width="1056" alt="B337147C-70E1-4052-9CAB-31648F76AEFD" src="https://user-images.githubusercontent.com/5305527/81490517-cbcf3b00-92a0-11ea-8e82-ffd29de1a025.png">



There is News Sample App have developed using the same VSCollectionKit, it supported via Cathrage.
https://github.com/Vinodh-G/NewsApp


