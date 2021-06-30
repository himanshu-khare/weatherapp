//
//  ViewController.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import UIKit

class LandingPageViewController: UIViewController {

    @IBOutlet weak var mobileNoField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden=true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
    @IBAction func continueToRegistration(_ sender: Any) {
        if(!mobileNoField.text!.isEmpty && mobileNoField.text!.count==10){
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "RegistrationViewController") as! RegistrationViewController
            vc.strmobileNo=mobileNoField.text!
            self.navigationController?.pushViewController(vc,animated: true)
            
        }else if(mobileNoField.text!.isEmpty){
            self.showToast(message: "Please enter mobile no", bckgrndColor: .red)
        }else{
            self.showToast(message: "Please enter valid mobile no", bckgrndColor: .red)
        }
    }
}

