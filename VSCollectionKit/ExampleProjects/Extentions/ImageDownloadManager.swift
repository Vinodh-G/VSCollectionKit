
import UIKit

class ImageDownloadManager: NSObject {

    static let shared: ImageDownloadManager = ImageDownloadManager()

    private override init() {}

    var imageCache: NSCache <NSString, UIImage> = NSCache()
    lazy var downloadsSession: URLSession = URLSession(configuration: URLSessionConfiguration.default)

    func getImageFromURL(imageURLString:String,
                         completionHandler:@escaping DownloadHandler) {

        if let cachedImage = imageCache.object(forKey: imageURLString as NSString) as UIImage? {
            completionHandler(cachedImage, nil)
            return
        }

        downloadImageFor(imageURLString: imageURLString,
                         downloadHandler: completionHandler)
    }

    private func downloadImageFor(imageURLString: String,
                                  downloadHandler: @escaping DownloadHandler) {
        let imageLoaderTask = downloadsSession.dataTask(with: URL(string: imageURLString)!, completionHandler: { (data : Data?, response : URLResponse?, error : Error?) in

            DispatchQueue.main.async {
                guard let validData = data else {
                    downloadHandler(nil, error)
                    return;
                }

                guard let image = UIImage(data: validData) else {
                    downloadHandler(nil, error)
                    return;
                }

                self.imageCache.setObject(image, forKey: imageURLString as NSString)
                downloadHandler(image, nil)
            }
        })

        imageLoaderTask.resume()
    }
}

