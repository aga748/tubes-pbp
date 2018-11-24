//
//  Login.swift
//  TugasBesar
//
//  Created by lab_pk_30 on 23/11/18.
//  Copyright © 2018 lab_pk_25. All rights reserved.
//

import UIKit
import Alamofire

class Login: UIViewController {

    let userAdmin = "masterApp"
    let passAdmin = "masterApp"
    let URL_JSON = "https://aga-api.arthadede.com/login/"
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!


    
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnLogin(_ sender: Any) {
        let username = txtUsername.text!
        let password = txtPassword.text!
        let parameters: Parameters = [
            "username": txtUsername.text!,
            "password": txtPassword.text!,
            ]
        if((username.isEmpty) || (password.isEmpty))
        {
            displayMyAlertMessage(userMessage: "Data tidak boleh kosong!");
            return;
        }
        else if((username == "masterApp") && (password == "masterApp"))
        {
            performSegue(withIdentifier: "listAdminVC", sender: Any?.self)
        }
        else
        {
            Alamofire.request(URL_JSON, method: .post, parameters: parameters).responseJSON
                {
                    response in
                    //printing response
                    print(response)
                    
                    //getting the json value from the server
                    if let result = response.result.value {
                        let jsonData = result as! NSDictionary
                        print(jsonData)
                        //if there is no error
                        if((jsonData.value(forKey: "response") as! Bool) == true){
                            
                            //getting the user from response
                            //let user = jsonData.value(forKey: "SUCCESS") as! NSDictionary
                            
                            //getting user values
                            //key dari json nya diambil nilainya ditaro di variabel
                            let userName = jsonData.value(forKey: "username") as! String
                            let userEmail = jsonData.value(forKey: "email") as! String
            
                            
                            
                            //saving user values to userdefault
                            //for keynya itu ngarah ke data di swift sessionnya beda sama key json yg diatas
                            UserDefaults.standard.setValue(userName, forKey: "username")
                            UserDefaults.standard.setValue(userEmail, forKey: "email")
                            
                            
                            //let test = UserDefaults.standard.value(forKey: "user_name") as! String
                            //print(test)
                            //UserDefaults.standard.synchronize()
                            
                            //switching the screen
                            UserDefaults.standard.set(true, forKey: "isLoggedIn")
                            let myAlert = UIAlertController(title:"Alert", message:"Login Berhasil !", preferredStyle: UIAlertController.Style.alert);
                            let okAction = UIAlertAction(title: "Ok",style : UIAlertAction.Style.default){ action in self.dismiss(animated: true,completion : nil)
                            }
                            myAlert.addAction(okAction);
                            
                            self.dismiss(animated: true, completion: nil)
                        }else{
                            //error message in case of invalid credential
                            self.displayMyAlertMessage(userMessage: "Koneksi Buruk");
                            return;
                        }
                    }
            }
        }
        
    }
    @IBAction func btnSignUp(_ sender: Any) {
        performSegue(withIdentifier: "signUpVC", sender: Any?.self)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func displayMyAlertMessage(userMessage:String){
        var myAlert = UIAlertController(title:"Alert",message:userMessage,preferredStyle : UIAlertController.Style.alert);
        let okAction = UIAlertAction(title:"Ok",style:UIAlertAction.Style.default, handler:nil);
        
        myAlert.addAction(okAction)
        present(myAlert, animated: true, completion: nil)
    }

}
