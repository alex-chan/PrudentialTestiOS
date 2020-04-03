//
//  LoginViewModel.swift
//  Climber
//
//  Created by AlexChan on 2020/4/2.
//  Copyright © 2020 Alex. All rights reserved.
//

import Foundation

import RxSwift
import RxCocoa
import RxRelay
import Moya
import Moya_ObjectMapper

class LoginViewModel {
    
    let email = BehaviorRelay<String?>(value: nil)
    let password = BehaviorRelay<String?>(value: nil)
    
    let isLoading = BehaviorRelay<Bool>(value: false)
    let isLoginSucceed = BehaviorRelay<Bool>(value: false)
    let loginFailMsg = BehaviorRelay<String?>(value: nil)
    
    let user = BehaviorRelay<User?>(value: nil)
    
    
//    private let provider = MoyaProvider<UserService>()
    private let provider = MoyaProvider<UserService>(stubClosure: MoyaProvider<UserService>.immediatelyStub)
    
    private let disposeBag = DisposeBag()

    lazy private(set) var emailIsValid: Observable<Bool> = self.email
        .asObservable()
        .map { email in
            guard let email = email else { return false }
            let EMAIL_REG = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let regex = try! NSRegularExpression(pattern: EMAIL_REG)
            let matches = regex.matches(in: email, options: [], range: NSRange(location: 0, length: email.count))
            return matches.count == 1
    }
    
    lazy private(set) var passwordValid: Observable<Bool> = self.password
        .asObservable()
        .filter { $0 != nil  }
        .map { $0!.count >= 6 }

    func submit() {
        isLoading.accept(true)
        
        provider.rx.request(.login(email: email.value ?? "", password: password.value ?? ""))
            .delay(3.0, scheduler: MainScheduler.instance)
            .mapObject(User.self)
            .debug()
            .subscribe { [weak self] event -> Void in
                self?.isLoading.accept(false)
                switch event {
                
                    case .success(let user):
//                      self.repos = repos
                        self?.user.accept(user)
                        self?.isLoginSucceed.accept(true)
//                        print(user)
                    case .error(let error):
                        self?.isLoginSucceed.accept(false)
                        self?.loginFailMsg.accept(error.localizedDescription)
                        print("error")
                        print(error)
            }
        }.disposed(by:disposeBag)
    }
}
