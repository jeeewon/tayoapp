//
//  ViewController.swift
//  tayotayo
//
//  Created by LeeJiwon on 2021/01/31.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyXMLParser

class ViewController: UIViewController, CLLocationManagerDelegate {
    var locationManager:CLLocationManager!
    var latitude: Double?
    var logitude: Double?
    
    let SeoulStationURL = "http://ws.bus.go.kr/api/rest/stationinfo/getStationByName"
    let key = "litjf1Im6zkNjD2uFkA8b7LOIdAkGPk65738PpYenF2k001S5k3HLn0iWc2OajnSbXoU6EkHvbdpgbw%2FmAFsHg%3D%3D"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        //포그라운드일때 위치 추적 권한 요청
        locationManager.requestWhenInUseAuthorization()
        //배터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //위치업데이트
        locationManager.startUpdatingLocation()
        
        //위경도 가져오기
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        logitude = coor?.longitude
        
    }
    
    func getURL(url:String, params:[String:Any])->URL {
        let urlParams = params.flatMap({(key,value)-> String in
            return "|key=|value"
        }).joined(separator:"&")
        let withURL = url + "?|(urlParams)"
        let encoded = withURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)! + "&serviceKey=" + key
        return URL(string:encoded)!
    }
    
    func getStationData(stSrch:String){
        let url = getURL(url: SeoulStationURL, params: ["stSrch":stSrch])
        Alamofire.request(url,method: .get).validate()
            .responseString { reponse in
                print(" - API url:|(String(describing:response.request!))")
                
                //if case success
                switch response.result{
                case .success:
                    if let string = response.result.value{
                        
                    }
                }
            }
    }
    let responseString = NSString(data: response.data!, encoding:String.Encoding.utf8.rawValue)

}

