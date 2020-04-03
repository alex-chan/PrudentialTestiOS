//
//  ViewController.swift
//  Climber
//
//  Created by AlexChan on 2020/3/30.
//  Copyright © 2020 Alex. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Toast

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var emailBottomLine: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordBottomLine: UIView!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private let SBID_SHOW_MAIN = "SBID_SHOW_MAIN"
    private var offsetted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
        setupUI()
    }
    
    func attributeString(_ textField: UITextField?) -> NSAttributedString {
        return NSAttributedString(string: textField?.placeholder ?? "",
                                  attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray,
                                                         NSAttributedString.Key.font: textField?.font])
    }
    
    func setupUI() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        let image = UIImage(named: "Component BG")
        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = image
        self.view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
        
        emailTextField.attributedPlaceholder = attributeString(emailTextField);
        passwordTextField.attributedPlaceholder = attributeString(passwordTextField);
        
    }
    func configureBindings() {
        viewModel = LoginViewModel()
        
        emailTextField.rx.text.orEmpty
//            .debug()
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .map{ $0.count <= 0 }
            .bind(to: usernameLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .map{ $0.count <= 0 }
            .bind(to: passwordLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.emailIsValid, viewModel.passwordValid)
            .asObservable()
//            .filter { $0 && $1 }
            .map { $0 && $1 }
            .bind(to: loginButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .bind(onNext: viewModel.submit)
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver()
//            .drive(indicator.rx.animating)
        .debug()
            .map { !$0 }
            .drive(indicator.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.isLoading.asDriver()
            .drive(indicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.isLoginSucceed
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (succeed) in
                if succeed {
                    self.performSegue(withIdentifier: self.SBID_SHOW_MAIN, sender: nil)
                }
            }).disposed(by: disposeBag)
        
        viewModel.loginFailMsg
            .filter { $0 != nil }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [unowned self] (msg) in
                self.view.makeToast(msg, duration: 2.0, position: CSToastPositionCenter)
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe(onNext: {  [unowned self] _ in
                self.emailBottomLine.backgroundColor = UIColor.white
            })
            .disposed(by: disposeBag)
        
        emailTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe(onNext: {  [unowned self] _ in
                self.emailBottomLine.backgroundColor = UIColor.gray
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidBegin)
            .asObservable()
            .subscribe(onNext: {  [unowned self] _ in
                self.passwordBottomLine.backgroundColor = UIColor.white
            })
            .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingDidEnd)
            .asObservable()
            .subscribe(onNext: {  [unowned self] _ in
                self.passwordBottomLine.backgroundColor = UIColor.gray
            })
            .disposed(by: disposeBag)


    }
}
    
extension LoginViewController: UITextFieldDelegate {
    
    
    
    func animateTextField(textField: UITextField, up: Bool) {
        if up && offsetted {
            return
        }
        offsetted = up
        
       let movementDistance:CGFloat = -280
       let movementDuration: Double = 0.3

       var movement:CGFloat = 0
       if up {
           movement = movementDistance
       }else {
           movement = -movementDistance
       }
       UIView.beginAnimations("animateTextField", context: nil)
       UIView.setAnimationBeginsFromCurrentState(true)
       UIView.setAnimationDuration(movementDuration)
       self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
       UIView.commitAnimations()
   }


    func textFieldDidBeginEditing(_ textField: UITextField){
        self.animateTextField(textField: textField, up:true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.animateTextField(textField: textField, up:false)
    }
}

