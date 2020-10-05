//
//  RegistrViewController.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 05.10.2020.
//

import UIKit
import RealmSwift

class RegistrViewController: UIViewController {

    var currentUser: MUser!
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // сохранение пользователя
    func savePlace() {
        let newUser = MUser(login: loginTextField.text!, password: passwordTextField.text!)
        
        if currentUser != nil {
            try! realm.write {
                currentUser?.login = newUser.login
                currentUser?.password = newUser.password
            }
        } else {
            StorageManager.saveObject(newUser)
        }
    }
    
    // показать alert controller
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func registrButtonTapped(_ sender: UIButton) {
        savePlace()
        showAlert(title: "Успешно!", message: "Пользователь \(loginTextField.text!) успешно зарегистрирован!")
    }
    

}
