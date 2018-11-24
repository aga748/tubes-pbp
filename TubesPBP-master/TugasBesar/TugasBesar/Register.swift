//
//  Register.swift
//  TugasBesar
//
//  Created by lab_pk_30 on 23/11/18.
//  Copyright © 2018 lab_pk_25. All rights reserved.
//

import UIKit
import Alamofire

class Register: UIViewController {

    @IBOutlet var txtNama: UITextField!
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    let URL_JSON = "https://aga-api.arthadede.com/user/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnRegister(_ sender: Any) {
        let nama = txtNama.text!
        let username = txtUsername.text!
        let email = txtEmail.text!
        let password = txtPassword.text!
        let confirmpass = txtConfirmPassword.text!
        let parameters: Parameters = [
            "name": txtNama.text!,
            "username": txtUsername.text!,
            "email": txtEmail.text!,
            "password": txtPassword.text!,
            "balance": 100000
        ]
        
        if ((email.isEmpty) || (username.isEmpty) || (nama.isEmpty) || (password.isEmpty))
        {
            displayMyAlertMessage(userMessage: "Data tidak boleh ada yang kosong");
            return;
        }
        if( password != confirmpass)
        {
            displayMyAlertMessage(userMessage: "Confirm Password harus sama dengan password");
            return;
        }
        else
        {
            Alamofire.request(URL_JSON, method: .post, parameters: parameters).responseString
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        
                        //response when success uhuy!!
                        //Display Alert Message
                        let myAlert = UIAlertController(title:"Alert", message:"Register Berhasil !", preferredStyle: UIAlertController.Style.alert);
                        let okAction = UIAlertAction(title: "Ok",style : UIAlertAction.Style.default){ action in self.dismiss(animated: true,completion : nil)
                        }
                        myAlert.addAction(okAction);
                        
                        self.dismiss(animated: true, completion: nil)
                        //converting it as NSDictionary (ii buat nampilin di label kalo mau pake ini)
                        //let jsonData = result as! NSDictionary
                        
                        //displaying the message in label
                        // self.labelMessage.text = jsonData.value(forKey: "message") as! String?
                    }
            }
           // performSegue(withIdentifier: "loginVC", sender: Any?.self)
        }
    }
    

    
    func displayMyAlertMessage(userMessage: String)
    {
        var myAlert = UIAlertController(title:"Alert",message:userMessage,preferredStyle : UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"Ok",style:UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)

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
