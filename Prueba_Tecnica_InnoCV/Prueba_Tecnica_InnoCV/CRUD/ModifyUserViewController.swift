//
//  ModifyUserViewController.swift
//  Prueba_Tecnica_InnoCV
//
//  Created by Jose M on 22/9/22.
//

import UIKit
import Alamofire

class ModifyUserViewController: UIViewController {

    @IBOutlet weak var UserIdTextField: UITextField!
    @IBOutlet weak var BirthDatePicker: UIDatePicker!
    @IBOutlet weak var NameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ModifyBtn(_ sender: Any) {
        
        if !UserIdTextField.text!.isEmpty && !NameTextField.text!.isEmpty{
            UpdateUser(Id: UserIdTextField.text!, date: BirthDatePicker.date.ISO8601Format(), name: NameTextField.text!)
        }
        
        else{
            let alert = UIAlertController(title: "¡Error!", message: "¡No puede haber campos vacios!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                self.NameTextField.text = ""
            })
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }
    

    
    func UpdateUser(Id: String, date: String, name:String){
        
        let urlString = "https://hello-world.innocv.com/api/user"
        guard let url = URL(string: urlString) else {return}
        
        let user:[String:Any] = [
            "name":name,
            "birthdate":date,
            "id":Id
        ]
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let data = try! JSONSerialization.data(withJSONObject: user, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let json = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        if let json = json{
            print(json)
        }
        
        request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
        let alamoRequest = AF.request(request as URLRequestConvertible)
        alamoRequest.validate(statusCode: 200..<300)
        alamoRequest.responseString { response in
          
            print(response.response?.statusCode)

            if response.response?.statusCode == 200{
                let alert = UIAlertController(title: "¡Usario Modificado!", message: "¡Usuario Modificado con Exito!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                   
                })
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Error", message: "¡Ha ocurrido un error al crear el usuario!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
}
