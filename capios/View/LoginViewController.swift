//
//  LoginViewController.swift
//  capios
//
//  Created by PUCPR on 12/06/19.
//  Copyright © 2019 Adriano. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Valet

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var usernameLabel: UILabel! {
        didSet {
            usernameLabel.accessibilityTraits = UIAccessibilityTraitStaticText
            usernameLabel.accessibilityLabel = R.string.main.loginUsernameLabel_accessibilityLabel()
        }
    }
    
    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.accessibilityTraits = UIAccessibilityTraitStaticText
            passwordLabel.accessibilityLabel = R.string.main.loginPasswordLabel_accessibilityLabel()
        }
    }
    
    @IBOutlet weak var usernameTxtField: UITextField! {
        didSet {
            usernameTxtField.accessibilityLabel = R.string.main.usernameTxtFiled_accessibilityLabel()
            usernameTxtField.accessibilityHint = R.string.main.usernameTxtFiled_accessibilityHint()
        }
    }
    @IBOutlet weak var passwordTxtField: UITextField! {
        didSet {
            passwordTxtField.accessibilityLabel = R.string.main.passwordTxtField_accessibilityLabel()
            passwordTxtField.accessibilityHint = R.string.main.passwordTxtField_accessibilityHint()
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.accessibilityTraits = UIAccessibilityTraitButton
            loginButton.accessibilityLabel = R.string.main.loginButton_accessibilityLabel()
            loginButton.accessibilityHint = R.string.main.loginButton_accessibilityHint()
            //loginButton.titleLabel?.adjustsFontForContentSizeCategory = true
        }
    }
    
    let disposeBag : DisposeBag = DisposeBag()
    
    var fieldsAreValid: Variable<Bool> = Variable<Bool>(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Observable.combineLatest(usernameTxtField.rx.text,
                                 passwordTxtField.rx.text) {
                                    username, password -> Bool in
                                    //Esse bloco de código será chamado, sempre que houver uma alteração nos valores 'text', dos textfields, usernameTxtField e passwordTxtField
                                    //Nesse if é verificado se o campo 'text' dos textFields é válido, ou seja, 'not nil'
                                    if let _username = username,
                                        let _password = password {
                                        //Se os valores não forem nulos, então nós verificamos se os campos estão respeitando as regras de criação de conta que foi estipulada
                                        return _username.count >= 6 && _password.count >= 6
                                    }
        return false
        }.bind(to: loginButton.rx.isEnabled).disposed(by: disposeBag)
        
        
        loginButton.rx.tap.subscribe(onNext: {
            [weak self] in
            guard let `self` = self else { return }
            guard let valetIdentifier = Identifier(nonEmpty: "Database") else { return }
            let valet: Valet = Valet.valet(with: valetIdentifier,
                                           accessibility: .whenUnlocked)
            
            if let username = valet.string(forKey: R.string.main.valetUsername()),
            let password = valet.string(forKey: R.string.main.valetPassword()),
            let _usernameTextField = self.usernameTxtField.text,
            let _passwordTextField = self.passwordTxtField.text {
                if username == _usernameTextField && password == _passwordTextField {
                    print("sucessso")
                    if let vc = R.storyboard.trainingExercises.menuViewController() {
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }else {
                    print("fail")
                    let alert = UIAlertController(title: R.string.main.alertTitleMenuVcErro(), message: R.string.main.alertMessageMenuVcErro(), preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: R.string.main.alertTitleButtonMenuVcErro(), style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }
            }
        }).disposed(by: disposeBag)
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
