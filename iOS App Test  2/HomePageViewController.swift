//
//  HomePageViewController.swift
//  iOS App Test  2
//
//  Created by Himanshu Khare on 30/06/21.
//

import UIKit

import CoreLocation
import SwiftyJSON
import Alamofire
class HomePageViewController: UIViewController {

    @IBOutlet weak var weatherInfo: UILabel!
    @IBOutlet weak var pincode: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    var cityName:String?
    var weatherModel:WeatherModel?
    @IBOutlet weak var menu: UIButton!
    var menuItems: [UIAction] {
        return [
            UIAction(title: "My Profile", image: UIImage(systemName: "person.fill"), handler: { (_) in
                print("my profile")
                let vc = self.storyboard!.instantiateViewController(identifier: "MyProfileViewController") as MyProfileViewController
                self.navigationController!.pushViewController(vc, animated: true)
            }),
            UIAction(title: "Logout", image: UIImage(systemName: "arrowshape.turn.up.forward.fill"), handler: { (_) in
                Singleton.shared.setUserMobileNo(mobileno: "")
                let vc = self.storyboard!.instantiateViewController(identifier: "LandingPageViewController") as LandingPageViewController
                self.navigationController?.pushViewController(vc, animated: true)
            })
        ]
    }
    var demoMenu: UIMenu {
        return UIMenu(title: "Choose", image: nil, identifier: nil, options: [], children: menuItems)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden=true
        // Do any additional setup after loading the view.
        
        menu.menu = demoMenu
        menu.showsMenuAsPrimaryAction = true
        pincode.text = Singleton.shared.getUserPincode()
        getLocationFromPostalCode(postalCode: Singleton.shared.getUserPincode())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden=true
    }
    
   
    func getLocationFromPostalCode(postalCode : String){
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(postalCode) {
                (placemarks, error) -> Void in
                // Placemarks is an optional array of type CLPlacemarks, first item in array is best guess of Address
                
                if let placemark = placemarks?[0] {
                    
                    if placemark.postalCode == postalCode{
                     // you can get all the details of place here
                        self.cityName = placemark.subAdministrativeArea
                        self.getWeather()
                    }
                    else{
                       print("Please enter valid zipcode")
                    }
                }
            }
        }
    @IBAction func showResults(_ sender: Any) {
        if(!pincode.text!.isEmpty && pincode.text?.count==6){
          getLocationFromPostalCode(postalCode: pincode.text!)
        }else {
            self.showToast(message: "Enter a valid pincode", bckgrndColor: .red)
        }
    }
    
    func getWeather(){
        let params: [String: Any] = [:]
        let headers : HTTPHeaders = [:]
        
        let request = ApiRoutes.OPEN_WEATHER_API + "?q="+cityName!+"&appid="+ApiRoutes.APPID
        print("request \(request)")
        let indicator = self.showIndicator()
        indicator.startAnimating()
        AF.request(request, method: .get, parameters: params, encoding: URLEncoding.default, headers: headers).responseJSON { (response:AFDataResponse<Any>) in
            switch(response.result) {
            case .success(let value):
                indicator.stopAnimating()
                let json = JSON(value).rawString()
                let data = Data(json!.utf8)
                let decoder = JSONDecoder()
                self.weatherModel = try! decoder.decode(WeatherModel.self, from: data)
                let icon = ApiRoutes.WEATHER_ICON+(self.weatherModel?.weather[0].icon)!+".png"
                let url = URL(string: icon)
                if(url != nil){
                    self.weatherIcon.load(url: url!)
                }
                let weather = "\(self.weatherModel!.name): \(self.weatherModel!.weather[0].description.uppercased()) \n Temp: \(Int(self.weatherModel!.main.temp - 273.15))℃\n Max Temp: \(Int(self.weatherModel!.main.temp_max - 273.15))℃\n Min Temp: \(Int(self.weatherModel!.main.temp_min - 273.15))℃\n Humidity: \(self.weatherModel!.main.humidity)%\n"
                print(weather)
                self.weatherInfo.text = weather
                break
            case .failure(let error):
                indicator.stopAnimating()
                print(error)
                self.showToast(message: "err \(error)", bckgrndColor: .red)
                break
            }
        }
    }
}
