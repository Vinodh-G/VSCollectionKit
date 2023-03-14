
import UIKit


public protocol AsyncLoad {
    func setImageFrom(imageURLString: String,
                      placeHolderImage: UIImage?,
                      completionHandler: DownloadHandler?)
}

public typealias DownloadHandler = (_ image: UIImage?,  _ error: Error?) -> Void

private var kImageURLKey: String = "imageURLKey"

extension UIImageView: AsyncLoad {

    var imageURLId: String{

        get{
            return objc_getAssociatedObject(self, &kImageURLKey) as! String
        }
        set(newValue){
            objc_setAssociatedObject(self, &kImageURLKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    public func setImageFrom(imageURLString: String,
                             placeHolderImage: UIImage? = nil,
                             completionHandler: DownloadHandler? = nil) {

        guard !imageURLString.isEmpty  else {
            if let handler = completionHandler {
                handler(nil, nil)
            }
            return
        }

        if placeHolderImage != nil {
            image = placeHolderImage;
        }

        imageURLId = imageURLString
        ImageDownloadManager.shared.getImageFromURL(imageURLString: imageURLString) { (image: UIImage?, error: Error?) in

            guard let image = image else {
                if let handler = completionHandler {
                    handler(nil, error)
                }
                return
            }

            self.updateImage(image: image, imageUrl: imageURLString)
            if let handler = completionHandler {
                handler(image, nil);
            }
        }
    }

    private func updateImage(image: UIImage, imageUrl: String) {

        if imageUrl == imageURLId {
            UIView.transition(with: self,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.image = image;
            },
                              completion: nil)
        }
    }
}
