import UIKit
import Kingfisher

class ListVC: UIViewController {
    @IBOutlet weak var listCollectionview: UICollectionView!
    @IBOutlet weak var profileBtn: UIControl!
    let viewModel = ListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getListOfImages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func profileBtnAction(_ sender: Any) {
        let vc:ProfileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension ListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        let post = viewModel.posts[indexPath.item]
        let url = URL(string: post.urls.regular)
        let processor = DownsamplingImageProcessor(size: cell.dataImage.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        cell.dataImage.kf.indicatorType = .activity
        cell.dataImage.kf.setImage(
            with: url,
            placeholder: UIImage(named: "picture"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
            }
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/2, height: 220)
    }
}

extension ListVC: ListViewModelDelegate {
    func didFetchUsageData() {
        DispatchQueue.main.async {
            self.listCollectionview.reloadData()
        }
    }
}
