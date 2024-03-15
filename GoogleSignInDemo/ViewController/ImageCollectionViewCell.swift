import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  @IBOutlet weak var dataImage: UIImageView!
    
    func configureCell(image: UIImage){
        dataImage.image = image
    }
}
