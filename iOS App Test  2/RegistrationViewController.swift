//
//  RegistrationViewController.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import UIKit
import CoreLocation
import SwiftyJSON
import Alamofire
class RegistrationViewController: UIViewController {

    @IBOutlet weak var mobileNo: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var gender: UITextField!
    @IBOutlet weak var addressLine1: UITextField!
    @IBOutlet weak var addressLine2: UITextField!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var district: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var age: UITextField!
    var geocoder:CLGeocoder!
    var strmobileNo=""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=false
        geocoder = CLGeocoder()
        mobileNo.text = strmobileNo
        dob.addInputViewDatePicker(target: self, selector: #selector(selectDob))
        pincode.addTarget(self, action: #selector(pincodeChange(_:)), for: .editingChanged)
    }
    
    @objc func pincodeChange(_ textField: UITextField) {
        if(textField.text?.count==6){
            getLocationFromPostalCode(postalCode: pincode.text!)
        }
    }
    
    func getLocationFromPostalCode(postalCode:String){
        let params : [String:Any]=[:]
        let headers : HTTPHeaders = [:]
        let indicator = self.showIndicator()
        indicator.startAnimating()
        AF.request(ApiRoutes.POSTAL_CODE_API+postalCode, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            switch(response.result) {
            case .success(let value):
                indicator.stopAnimating()
                let json = JSON(value).array![0].rawString()
                let data = Data(json!.utf8)
                let decoder = JSONDecoder()
                let model = try! decoder.decode(PincodeModel.self, from: data)
                if(model.PostOffice?.count ?? 0>0){
                    self.state.text = model.PostOffice?[0].State
                    self.district.text = model.PostOffice?[0].District
                }
                break
            case .failure(let error):
                indicator.stopAnimating()
                self.showToast(message: "\(error)", bckgrndColor: .red)
                print(error)
                break
            }
        }
    }
    
    @objc func selectDob(_ sender: Any) {
        if let datePicker = self.dob.inputView as? UIDatePicker {
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
            let gregorian = Calendar(identifier: .gregorian)
            let ageComponents = gregorian.dateComponents([.year], from: datePicker.date, to: Date())
            let age = ageComponents.year!
            self.age.text = String(age)
            self.dob.text = dateFormatter.string(from: datePicker.date)
        }
        self.dob.resignFirstResponder()
    }
    
    @IBAction func doRegister(_ sender: Any) {
        if(isAllFieldsValid()){
            Singleton.shared.setUserName(name: fullName.text!)
            Singleton.shared.setUserState(state: state.text!)
            Singleton.shared.setUserGender(gender: gender.text!)
            Singleton.shared.setUserPincode(pincode: pincode.text!)
            Singleton.shared.setUserDistrict(district: district.text!)
            Singleton.shared.setUserDOB(dob: dob.text!)
            Singleton.shared.setUserAddressLine1(addressLine1: addressLine1.text!)
            Singleton.shared.setUserAddressLine2(addressLine2: addressLine2.text!)
            Singleton.shared.setUserMobileNo(mobileno: mobileNo.text!)
            let homevc = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
            self.navigationController!.pushViewController(homevc, animated: true)
            
        }
    }
    func isAllFieldsValid()->Bool{
        if((mobileNo.text!.isEmpty)){
            self.showToast(message: "Please enter mobile no", bckgrndColor: .red)
            return false
        }else if((mobileNo.text!.count != 10)){
            self.showToast(message: "Please enter valid mobile no", bckgrndColor: .red)
            return false
        }
        else if((fullName.text!.isEmpty)){
            self.showToast(message: "Please enter full name", bckgrndColor: .red)
            return false
        }else if((gender.text!.isEmpty)){
            self.showToast(message: "Please enter gender", bckgrndColor: .red)
            return false
        }else if((addressLine1.text!.isEmpty)){
            self.showToast(message: "Please enter address Line 1", bckgrndColor: .red)
            return false
        }else if((addressLine2.text!.isEmpty)){
            self.showToast(message: "Please enter address Line 2", bckgrndColor: .red)
            return false
        }else if((pincode.text!.isEmpty)){
            self.showToast(message: "Please enter pincode", bckgrndColor: .red)
            return false
        }else if((district.text!.isEmpty)){
            self.showToast(message: "Please enter district", bckgrndColor: .red)
            return false
        }else if((state.text!.isEmpty)){
            self.showToast(message: "Please enter state", bckgrndColor: .red)
            return false
        }else if((dob.text!.isEmpty)){
            self.showToast(message: "Please enter dob", bckgrndColor: .red)
            return false
        }
        return true
    }
}
