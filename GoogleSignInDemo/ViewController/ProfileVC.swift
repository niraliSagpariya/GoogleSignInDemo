import UIKit
import GoogleSignIn

class ProfileVC: UIViewController {
    
    private enum Constants {
        static let email = "email"
    }
    
    @IBOutlet weak var signOutBtn: UIButton!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        userNameLbl.text = UserDefaults.standard.object(forKey: Constants.email) as? String
    }
}

extension ProfileVC {
    @IBAction func signOutBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signOut()
        UserDefaults.standard.setValue("", forKey: Constants.email)
        let vc:ViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
