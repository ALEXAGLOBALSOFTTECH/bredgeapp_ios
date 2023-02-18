//
//  Validators.swift
//  ChargeGrid
//
//  Created by wework on 15/01/22.
//

import Foundation

class ValidationError: Error {
    var message: String
    var code: Int
    
    init(_ message: String,_ code: Int = 200) {
        self.message = message
        self.code = code
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}

enum ValidatorType {
    case email
    case password
    case username
    case mobileNumber
    case projectIdentifier
    case requiredField(field: String)
    case age
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
            case .email: return EmailValidator()
            case .password: return PasswordValidator()
            case .username: return UserNameValidator()
            case .mobileNumber: return MobileNumberValidator()
            case .projectIdentifier: return ProjectIdentifierValidator()
            case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
            case .age: return AgeValidator()
        }
    }
}

//"J3-123A" i.e
struct ProjectIdentifierValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: "^[A-Z]{1}[0-9]{1}[-]{1}[0-9]{3}[A-Z]$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid Project Identifier Format")
            }
        } catch {
            throw ValidationError("Invalid Project Identifier Format")
        }
        return value
    }
}


class AgeValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 0 else {throw ValidationError("Age is required")}
        guard let age = Int(value) else {throw ValidationError("Age must be a number!")}
        guard value.count < 3 else {throw ValidationError("Invalid age number!")}
        guard age >= 18 else {throw ValidationError("You have to be over 18 years old to user our app :)")}
        return value
    }
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct UserNameValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value.count > 3 else {
            throw ValidationError("Username must contain more than three characters",400 )
        }
        guard value.count < 30 else {
            throw ValidationError("Username shoudn't conain more than 18 characters",400 )
        }
        
        do {
            if try NSRegularExpression(pattern: "^[a-zA-Z0-9 ]{1,18}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid username, username should not contain whitespaces, numbers or special characters",400)
            }
        } catch {
            throw ValidationError("Invalid username, username should not contain whitespaces,  or special characters",400)
        }
        return value
    }
}

//^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{10,} strog Password
struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required",411)}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters",410) }
      //pre  ^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$
        do {//"(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{8,}"
            if try NSRegularExpression(pattern: "(?=[^a-z]*[a-z])(?=[^0-9]*[0-9])[a-zA-Z0-9!@#$%^&*]{6,}",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character",412)
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character",413)
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {throw ValidationError("Please enter email Address",401)}

        
        do {

            if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Invalid email Address",401)
            }
        } catch {
            throw ValidationError("Invalid email Address",401)
        }
        return value
    }
}


struct MobileNumberValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        
        guard !value.isEmpty else {throw ValidationError("Please enter mobile number",402)}

        guard value.count == 10 else {
            throw ValidationError("Invalid mobile number",402)
        }
        
//        do {
//            if try NSRegularExpression(pattern: "^[0-9]$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
//                throw ValidationError("Invalid mobile number",401)
//            }
//        } catch {
//            throw ValidationError("Invalid mobile number",401)
//        }
        return value
    }
}
