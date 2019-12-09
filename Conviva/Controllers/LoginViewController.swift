//
//  LoginViewController.swift
//  Conviva
//
//  Created by Gabriel Ferreira on 25/11/19.
//  Copyright © 2019 Gabriel Ferreira. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailProfile: TextFieldView!
    @IBOutlet weak var passwordProfile: TextFieldView!
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var profile: Profile?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Setup.setupViewController(self)
        Setup.setupButton(self.signinButton, withText: "Entrar")
        Setup.setupDissmiss(self.view)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.emailProfile.textField.placeholder = "email"
        self.passwordProfile.textField.placeholder = "senha"
        
        self.passwordProfile.textField.isSecureTextEntry = true
            
    }
    
    func makeLoginRequest() {
        let email = emailProfile.textField.text!
        let password = passwordProfile.textField.text!
        let endpoind = "profiles/\(email)/\(password)"
        let getRequest = APIRequest(endpoint: endpoind)
        getRequest.getProfileResponse() { result in
            switch result {
            case .success(let profileData):
                print("Perfil logado: \(String(describing: profileData))")
                //Dispatch the call to update the label text to the main thread.
                //Reload must only be called on the main thread
                DispatchQueue.main.async{
                    self.profile = profileData
                    UserDefaults.standard.set(self.emailProfile.textField.text!, forKey: "Email")
                    UserDefaults.standard.set(profileData.id, forKey:"ID")
                    self.dismiss(animated: true)
                }
            case .failure(let error):
                print("Ocorreu um erro \(error)")
                //UIALERT
            }
        }
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "profileAdressSegue" {
            let navigation = segue.destination as! UINavigationController
            let destination = navigation.viewControllers.first as! MapViewController
            destination.isCalledIn = .createProfile
        }
    }
    
    func checkForEmptyTextField() -> Bool {
        var returnValue: Bool = true
        
        //Checando se todos os campos foram completados
        returnValue = textFieldEmpty(self.emailProfile) && returnValue
        returnValue = textFieldEmpty(self.passwordProfile) && returnValue
        
        return returnValue
    }
    
    func textFieldEmpty(_ textfieldView : TextFieldView) -> Bool{
        textfieldView.emptyTextndicator.isHidden = textfieldView.textField.text == "" ? false : true
        return textfieldView.emptyTextndicator.isHidden
    }

    
    @IBAction func login(_ sender: Any) {
        if checkForEmptyTextField() {
            makeLoginRequest()
        }
    }

    //MARK: Methods to manage keybaord
    @objc func keyboardDidShow(notification: NSNotification) {
        let info = notification.userInfo
        let keyBoardSize = info![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        scrollView.contentInset = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyBoardSize.height, right: 0.0)
    }

    @objc func keyboardDidHide(notification: NSNotification) {

        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
    }
}
