//
//  File.swift
//  MediaMagicMachineTest
//
//  Created by Ashwini Mukade on 29/02/20.
//  Copyright © 2020 Ashwini Mukade. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func webServiceCallWithResponse(strUrl:String, completion: @escaping (_ result: Any) -> Void) {
        let webUrl = strUrl
        let url = URL(string: webUrl)!
        var request = URLRequest(url: url)
        request.timeoutInterval = 20
        request.httpMethod = "GET"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        var dict = NSDictionary()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("error // 55=\(String(describing: error))")
                self.PresentAlertView(message: "Plese check your internet connection")
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
            }else{
             let responseString = String(data: data, encoding: .utf8)
                do {
                    if try JSONSerialization.jsonObject(with: data, options: .mutableContainers) is NSArray {
                        let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSArray
                        print("i am of typer array     ",array)
                        completion(array)
                    }else{
                        dict = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! NSDictionary
                        completion(dict)
                        print("i am of typer dict    ",dict)
                    }
                } catch (_) {
                    print(error)
             }
            }
        }
        task.resume()
    }

    func PresentAlertView(message : String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

