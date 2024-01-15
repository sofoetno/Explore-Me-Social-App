//
//  PasswordValidationStatus.swift
//  FinalProject
//
//  Created by Sofo Machurishvili on 15.01.24.
//

struct PasswordValidationStatus {
    
    // MARK: - Properties
    var containsNumber: Bool = false
    var containsSymbol: Bool = false
    var containsUppercase: Bool = false
    var containsLowercase: Bool = false
    var passwordLength: Bool = false
    var isPasswordValid: Bool {
        containsNumber && containsSymbol && containsUppercase && containsLowercase && passwordLength
    }

}
