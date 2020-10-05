//
//  AuthViewController.swift
//  RouteTracker
//
//  Created by Станислав Лемешаев on 04.10.2020.
//

import UIKit
import RealmSwift

class AuthViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var users: Results<MUser>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        users = realm.objects(MUser.self)
    }
    
    // показать alert controller
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        for user in users {
            if user.login == loginTextField.text! && user.password == passwordTextField.text! {
                // тут перебрасываем на новый контроллер
            } else {
                // тут контроллер об ошибке
            }
        }
    }
    
    @IBAction func registrationButtonTapped(_ sender: UIButton) {
        // 
    }
    
    

}
