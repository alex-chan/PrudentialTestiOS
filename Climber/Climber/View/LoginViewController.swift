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
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private let disposeBag = DisposeBag()
    
    private let SBID_SHOW_MAIN = "SBID_SHOW_MAIN"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBindings()
    }
    
    func configureBindings() {
        
        viewModel = LoginViewModel()
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
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
        
//        indicator.rx.
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
            
            
    }
    

}

