
import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    private enum Constants {
        static let email = "email"
    }
    
    @IBOutlet weak var googleSignInBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
    }
}

extension ViewController {
    @IBAction func googleSignInBtnAction(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { result, error in
            guard error == nil else { return }
            guard let signInResult = result else { return }
            let user = signInResult.user

            UserDefaults.standard.setValue(user.profile?.email, forKey: Constants.email)
            let vc:ListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as! ListVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
