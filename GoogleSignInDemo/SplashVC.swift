//
//  SplashVC.swift
//  GoogleSignInDemo
//
//  Created by XcelTec-126 on 12/03/24.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationForLogin()
    }
    

    func navigationForLogin(){
        
        if UserDefaults.standard.object(forKey: "email") as? String == "" || UserDefaults.standard.object(forKey: "email") as? String == nil {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListVC") as! ListVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
