//
//  AddDataViewController.swift
//  TestingFirebase
//
//  Created by Angadjot singh on 20/11/19.
//  Copyright © 2019 Angadjot singh. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseDatabase

class AddDataViewController: UIViewController {

    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    
    var db:Firestore?
    var uid = ""
    var ref: DatabaseReference!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    

    
    @IBAction func addData(_ sender: UIButton) {
        
        let nameText = name.text
        let ageText = age.text
        let phoneText = phone.text
        
        let para = ["name":nameText,"age":ageText,"phone":phoneText]
        
        db = Firestore.firestore()
        db?.collection("Data").document(uid).setData(para as [String : Any]){
            err in
            if let err = err {
                print("Error writing document: \(err.localizedDescription)")
            } else {
                print("Document successfully written!")
            }
        }
        
        self.ref.child("users").child(uid).setValue(para)
        
        
        
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
