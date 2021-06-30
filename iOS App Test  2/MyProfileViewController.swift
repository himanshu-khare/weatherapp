//
//  MyProfileViewController.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import UIKit

class MyProfileViewController: UIViewController {
    @IBOutlet weak var profileInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        let name = Singleton.shared.getUserName()
        let dob = Singleton.shared.getUserDOB()
        let gender = Singleton.shared.getUserGender()
        let addressLine1 = Singleton.shared.getUserAddressLin1()
        let addressLine2 = Singleton.shared.getUserAddressLine2()
        let district = Singleton.shared.getUserDistrict()
        let state = Singleton.shared.getUserState()
        let mobileno = Singleton.shared.getUserMobileNo()
        
        profileInfo.text = "Name: \(name), \(mobileno)\nDOB: \(dob)\nGender: \(gender)\nAddress: \(addressLine1),\(addressLine2),\(district),\(state)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
