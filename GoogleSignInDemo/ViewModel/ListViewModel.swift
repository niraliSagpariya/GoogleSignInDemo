
import UIKit

protocol ListViewModelDelegate: AnyObject {
    func didFetchUsageData()
}

class ListViewModel {
    
    weak var delegate: ListViewModelDelegate?
    let networker = NetworkManager.shared
    var posts: [Post] = []

    func getListOfImages(){
        networker.posts(query: "puppies") { [weak self] posts, error in
          if let error = error {
            print("error", error)
            return
          }
            self?.posts = posts ?? []
            self?.delegate?.didFetchUsageData()
        }
    }
}


