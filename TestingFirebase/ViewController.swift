//
//  ViewController.swift
//  TestingFirebase
//
//  Created by Angadjot singh on 20/11/19.
//  Copyright © 2019 Angadjot singh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth



class ViewController: UIViewController {

    
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var uid = ""
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    @IBAction func login(_ sender: UIButton) {
        
       let emailText = self.email.text
       let passwordText = self.password.text
        
      Auth.auth().createUser(withEmail: emailText!
        , password: passwordText!) { (auth, err) in
            
            guard let user = auth?.user, err == nil else {
                print(err!.localizedDescription)
                return
            }
            
            print("email is",user.email!,user.uid)
            
            self.uid = user.uid
            self.defaults.set(self.uid, forKey: "uid")
            
            self.performSegue(withIdentifier: "addData", sender: nil)
            
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addData"{
            let x = segue.destination as? AddDataViewController
            x?.uid = self.uid
        }
        
    }
    
    
    
    
}

