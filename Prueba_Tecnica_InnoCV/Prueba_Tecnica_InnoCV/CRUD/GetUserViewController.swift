//
//  GetUserViewController.swift
//  Prueba_Tecnica_InnoCV
//
//  Created by Jose M on 22/9/22.
//

import UIKit
import Alamofire

class GetUserViewController: UIViewController {
    
    @IBOutlet weak var UserIDTextField: UITextField!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func SearchBtn(_ sender: Any) {
        
        if !UserIDTextField.text!.isEmpty{
            getUserById(Id: UserIDTextField.text!)
        }
    }
    
    func getUserById(Id:String){
        
        let urlString = "https://hello-world.innocv.com/api/user/\(Id)"
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let alamoRequest = AF.request(request as URLRequestConvertible)
        alamoRequest.validate(statusCode: 200..<300)
        alamoRequest.responseString { response in
            
            guard let datos = response.data else {
                let alert = UIAlertController(title: "Error", message: "¡No hay datos de ese usuario!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            do{
                let responseData = try JSONSerialization.jsonObject(with: datos, options: .fragmentsAllowed) as! [String:Any]
                
                if responseData.isEmpty{
                    
                }
                
                else{
                    self.UserNameLabel.text = responseData["name"] as! String
                    self.DateLabel.text = responseData["birthdate"] as! String
                }
                
                
                
                
                
            }
            catch{
                print("Error: \(error)")
            }
 
            
        }
        
    }
}
