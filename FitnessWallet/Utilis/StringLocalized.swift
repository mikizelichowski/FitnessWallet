//
//  StringLocalized.swift
//  FitnessWallet
//
//  Created by Mikolaj Zelichowski on 06/01/2021.
//

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name

enum Localized {
    internal enum LoginView {
        internal enum TextTitle {
            internal static let dontHaveAccount = Localized.tr("Localizable", "Don't have an account?")
            internal static let forgotPassword = Localized.tr("Localizable", "Forgot your password?")
            internal static let hintPasswordTitle = Localized.tr("Localizable", "Password needs min 8 sign")
            internal static let emailTitle = Localized.tr("Localizable", "Email")
            internal static let passwordTitle = Localized.tr("Localizable", "Password")
        }
        
        internal enum Button {
            internal static let signIn = Localized.tr("Localizable", "Sign In")
            internal static let getPassword = Localized.tr("Localizable", "Get help signing in.")
            internal static let loginButtonTitle = Localized.tr("Localizable", "Log In")
        }
        
        internal enum Placeholder {
            internal static let emailPlaceholder = Localized.tr("Localizable", "Email")
            internal static let passwordPlaceholder = Localized.tr("Localizable", "Password")
        }
    }
    
    internal enum RegisterView {
        internal enum TextTitle {
            internal static let fullnameTitle = Localized.tr("Localizable", "Fullname")
            internal static let usernameTitle = Localized.tr("Localizable", "Username")
            internal static let hintPasswordTitle = Localized.tr("Localizable", "Password needs min 8 sign")
            internal static let emailTitle = Localized.tr("Localizable", "Email")
            internal static let passwordTitle = Localized.tr("Localizable", "Password")
            internal static let alreadyHaveAnAccount = Localized.tr("Localizable", "Already have an account?")
        }
        
        internal enum Placeholder {
            internal static let emailPlaceholder = Localized.tr("Localizable", "Email")
            internal static let passwordPlaceholder = Localized.tr("Localizable", "Password")
            internal static let usernamePlaceholder = Localized.tr("Localizable", "Username")
            internal static let fullnamePlaceholder = Localized.tr("Localizable", "Fullename")
        }
        
        internal enum Button {
            internal static let registerButton = Localized.tr("Localizable", "Sign Up")
        }
    }
    
    internal enum ResetView {
        internal enum Button {
            internal static let title = Localized.tr("Localizable", "Confirm")
        }
    }
    
    internal enum FeedView {
        internal enum Title {
            internal static let title = Localized.tr("Localizable", "Feed")
        }
        
        internal enum Button {
            internal static let logout = Localized.tr("Localizable", "Logout")
        }
        
        internal enum Alert {
            internal static let logoutMessage = Localized.tr("Localizable", "Are You sure want to log out? ")
            internal static let cancel = Localized.tr("Localizable", "Cancel")
            internal static let logOut = Localized.tr("Localizable", "Log Out")
        }
    }
    
    internal enum ProfileView {
        internal enum Titel {
            internal static let title = Localized.tr("Localizable", "Profile")
        }
        
        internal enum Identifier {
            internal static let title = Localized.tr("Localizable", "ProfileHeader")
        }
        
        internal enum ProfileHeader {
            internal enum Title {
                internal static let post = Localized.tr("Localizable", "post")
                internal static let following = Localized.tr("Localizable", "following")
                internal static let followers = Localized.tr("Localizable", "followers")
            }
            
            internal enum Button {
                internal static let edit = Localized.tr("Localizable", "Edit Profile")
            }
        }
    }
    
    internal enum SearchView {
        internal enum Title {
            internal static let search = Localized.tr("Localizable", "Search")
        }
    }
    
    internal enum UploadPost {
        internal enum Title {
            internal static let navigation = Localized.tr("Localizable", "Upload Post")
            internal static let shareItem = Localized.tr("Localizable", "Share")
        }
        internal enum Placeholder {
            internal static let caption = Localized.tr("Localizable", "Enter caption..")
        }
    }
    
    internal enum CommentView {
        internal enum Title {
            internal static let navigation = Localized.tr("Localizable", "Comments")
        }
        internal enum Placeholder {
            internal static let comment = Localized.tr("Localizable", "Enter comment..")
        }
        internal enum Button {
            internal static let post = Localized.tr("Localizable", "Post")
        }
    }
    
    internal enum AddClientView {
        internal enum Title {
            internal static let username = Localized.tr("Localizable", "Name")
            internal static let surname = Localized.tr("Localizable", "Surname")
            internal static let weight = Localized.tr("Localizable", "Weight")
            internal static let height = Localized.tr("Localizable", "Height")
        }
        
        internal enum Placeholder {
            internal static let username = Localized.tr("Localizable", "name")
            internal static let surname = Localized.tr("Localizable", "surname")
            internal static let weight = Localized.tr("Localizable", "weight")
            internal static let height = Localized.tr("Localizable", "height")
        }
        
        internal enum Button {
            internal static let titleNewCustomer = Localized.tr("Localizable", "Add new customer")
        }
    }
    
    internal enum Alert {
        internal enum AlertMessage {
            internal static let title = Localized.tr("Localizable", "Ok")
            internal static let addNewCustomer = Localized.tr("Localizable", "Successfully create a new customer")
            internal static let registerAlert = Localized.tr("Localizable", "Successfully registered user")
        }
    }
}

// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension Localized {
    private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        // swiftlint:disable:next nslocalizedstring_key
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
