//
//  DeleteUserViewController.swift
//  Prueba_Tecnica_InnoCV
//
//  Created by Jose M on 22/9/22.
//

import UIKit
import Alamofire

class DeleteUserViewController: UIViewController {

    @IBOutlet weak var UserIdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func DeleteBtn(_ sender: Any) {
        
        if UserIdTextField.state.isEmpty{
            self.deleteUser(Id: UserIdTextField.text!)
        }
    }
    
    
    func deleteUser(Id:String){
        
        
        let urlString = "https://hello-world.innocv.com/api/user/\(Id)"
        guard let url = URL(string: urlString) else {return}
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
 
        let alamoRequest = AF.request(request as URLRequestConvertible)
        alamoRequest.validate(statusCode: 200..<300)
        alamoRequest.responseString { response in
          
            print(response.response?.statusCode)

            if response.response?.statusCode == 200{
                let alert = UIAlertController(title: "¡Usario Borrado!", message: "¡Usuario Borrado con Exito!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .default, handler: {_ in
                   
                })
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            else{
                let alert = UIAlertController(title: "Error", message: "¡Ha ocurrido un error al borrar el usuario!", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "Aceptar", style: .destructive, handler: nil)
                
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
            }
            
        }
        
    }
    
    

}
