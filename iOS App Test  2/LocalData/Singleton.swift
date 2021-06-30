//
//  Singleton.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import Foundation

public class Singleton{
    static let shared = Singleton()
   
    
    func setUserName(name: String){
        UserDefaults.standard.set(name,forKey: "name")
    }
    
    func getUserName() -> String{
        return UserDefaults.standard.string(forKey: "name") ?? ""
    }
    
     func setUserMobileNo(mobileno: String){
         UserDefaults.standard.set(mobileno,forKey: "mobileno")
     }
     
     func getUserMobileNo() -> String{
         return UserDefaults.standard.string(forKey: "mobileno") ?? ""
     }
    
     func setUserGender(gender: String){
         UserDefaults.standard.set(gender,forKey: "gender")
     }
     
     func getUserGender() -> String{
         return UserDefaults.standard.string(forKey: "gender") ?? ""
     }
    
    func setUserDOB(dob: String){
        UserDefaults.standard.set(dob,forKey: "dob")
    }
    
    func getUserDOB() -> String{
        return UserDefaults.standard.string(forKey: "dob") ?? ""
    }
    
    func setUserAddressLine1(addressLine1: String){
        UserDefaults.standard.set(addressLine1,forKey: "addressLine1")
    }
    
    func getUserAddressLin1() -> String{
        return UserDefaults.standard.string(forKey: "addressLine1") ?? ""
    }
    
    func setUserAddressLine2(addressLine2: String){
        UserDefaults.standard.set(addressLine2,forKey: "addressLine2")
    }
    
    func getUserAddressLine2() -> String{
        return UserDefaults.standard.string(forKey: "addressLine2") ?? ""
    }
    
    func setUserPincode(pincode: String){
        UserDefaults.standard.set(pincode,forKey: "pincode")
    }
    
    func getUserPincode() -> String{
        return UserDefaults.standard.string(forKey: "pincode") ?? ""
    }
    
    func setUserDistrict(district: String){
        UserDefaults.standard.set(district,forKey: "district")
    }
    
    func getUserDistrict() -> String{
        return UserDefaults.standard.string(forKey: "district") ?? ""
    }

    func setUserState(state: String){
        UserDefaults.standard.set(state,forKey: "state")
    }
    
    func getUserState() -> String{
        return UserDefaults.standard.string(forKey: "state") ?? ""
    }
}
