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
    let defaults = UserDefaults.standard
    var dict = [String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        ref = Database.database().reference()
        self.uid = self.defaults.string(forKey: "uid")!
        print("uid is",self.uid)
        
        retrieveData()
    }
    

    func retrieveData(){
        db = Firestore.firestore()
        db?.collection("Data").document(self.uid).getDocument(completion: { (snap, err) in
            
            
            if snap?.data() == nil{
                print("data is nil")
            }else{
                self.dict = (snap?.data())!
                
                self.name.text = self.dict["name"] as? String
                self.age.text = self.dict["age"] as? String
                self.phone.text = self.dict["phone"] as? String
                
            }
        })
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
    
    
    @IBAction func update(_ sender: UIButton) {
        let nameText = name.text
        let ageText = age.text
        let phoneText = phone.text
        
        let para = ["name":nameText,"age":ageText,"phone":phoneText]
        db = Firestore.firestore()
        db?.collection("Data").document(self.uid).updateData(para as [String : Any]){
            err in
            if let err = err{
                 print("Error writing document: \(err.localizedDescription)")
            }else{
                print("Document successfully updated!")
            }
        }
        
    }
    
    
    @IBAction func deleteData(_ sender: UIButton) {

        db = Firestore.firestore()
        db?.collection("Data").document(self.uid).delete(completion: { (err) in
            if let err = err{
                print(err.localizedDescription)
            }else{
                print("sucessfully deleted")
            }
        })
    }
    
    
    @IBAction func logout(_ sender: UIButton) {
        
        do{
            try Auth.auth().signOut()
            self.defaults.set("", forKey: "uid")
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyBoard.instantiateViewController(withIdentifier: "Main")
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = root
        }catch let err{
            print("error signing out",err.localizedDescription)
            self.dismiss(animated: true, completion: nil)
        }

    
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
