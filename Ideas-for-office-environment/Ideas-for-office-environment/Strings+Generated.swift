// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Email
  internal static let email = S.tr("Localizable", "email", fallback: "Email")
  /// Пользователь c таким email уже существует
  internal static let emailNotValid = S.tr("Localizable", "emailNotValid", fallback: "Пользователь c таким email уже существует")
  /// Email не может быть пустым
  internal static let emptyEmail = S.tr("Localizable", "emptyEmail", fallback: "Email не может быть пустым")
  /// Должность не может быть пустой
  internal static let emptyJob = S.tr("Localizable", "emptyJob", fallback: "Должность не может быть пустой")
  /// Имя не может быть пустым
  internal static let emptyName = S.tr("Localizable", "emptyName", fallback: "Имя не может быть пустым")
  /// Пароль не может быть пустым
  internal static let emptyPassword = S.tr("Localizable", "emptyPassword", fallback: "Пароль не может быть пустым")
  /// Фамилия не может быть пустой
  internal static let emptySurname = S.tr("Localizable", "emptySurname", fallback: "Фамилия не может быть пустой")
  /// Вход
  internal static let entry = S.tr("Localizable", "entry", fallback: "Вход")
  /// envelope
  internal static let envelope = S.tr("Localizable", "envelope", fallback: "envelope")
  /// eye
  internal static let eye = S.tr("Localizable", "eye", fallback: "eye")
  /// Есть аккаунт?
  internal static let haveAccount = S.tr("Localizable", "haveAccount", fallback: "Есть аккаунт?")
  /// lock
  internal static let lock = S.tr("Localizable", "lock", fallback: "lock")
  /// Нет аккаунта?
  internal static let notHaveAccount = S.tr("Localizable", "notHaveAccount", fallback: "Нет аккаунта?")
  /// OK
  internal static let ok = S.tr("Localizable", "OK", fallback: "OK")
  /// Пароль
  internal static let password = S.tr("Localizable", "password", fallback: "Пароль")
  /// Регистрация
  internal static let registration = S.tr("Localizable", "registration", fallback: "Регистрация")
  /// Повторите пароль
  internal static let repeatPassword = S.tr("Localizable", "repeatPassword", fallback: "Повторите пароль")
  /// Localizable.strings
  ///   Ideas-for-office-environment
  /// 
  ///   Created by Elina Karapetian on 02.03.2024.
  internal static let signin = S.tr("Localizable", "signin", fallback: "Войти")
  /// Зарегистрироваться
  internal static let signup = S.tr("Localizable", "signup", fallback: "Зарегистрироваться")
  /// Пароли не совпадают
  internal static let wrongPassword = S.tr("Localizable", "wrongPassword", fallback: "Пароли не совпадают")
  /// Неправильный логин или пароль
  internal static let wrongUser = S.tr("Localizable", "wrongUser", fallback: "Неправильный логин или пароль")
  internal enum Eye {
    /// eye.slash
    internal static let slash = S.tr("Localizable", "eye.slash", fallback: "eye.slash")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
