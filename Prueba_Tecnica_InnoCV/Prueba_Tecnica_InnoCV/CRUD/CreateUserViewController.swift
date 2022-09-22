//
//  CreateUserViewController.swift
//  Prueba_Tecnica_InnoCV
//
//  Created by Jose M on 22/9/22.
//

import UIKit
import Alamofire

class CreateUserViewController: UIViewController {

    @IBOutlet weak var BirthDatePicker: UIDatePicker!
    @IBOutlet weak var NameTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func CreateuserBtn(_ sender: Any) {
        
        print()
        
        if !NameTextField.text!.isEmpty{
            self.createUser(date: BirthDatePicker.date.ISO8601Format(), name: NameTextField.text!)
        }
        
        else{
            let alert = UIAlertController(title: "¡Error!", message: "¡No puedes dejar el campo usuario vacio!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
            
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        }
        
        
        
    }

    func createUser(date: String, name:String){
        
        let urlString = "https://hello-world.innocv.com/api/user"
        guard let url = URL(string: urlString) else {return}
        
        let user:[String:Any] = [
            "name":name,
            "birthdate":date,
            "id":0
        ]
        
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
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
                let alert = UIAlertController(title: "¡Usario Creado!", message: "¡Usuario Creado con Exito!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                    self.NameTextField.text = ""
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
