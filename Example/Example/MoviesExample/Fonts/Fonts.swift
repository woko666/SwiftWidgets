// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSFont
  internal typealias Font = NSFont
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIFont
  internal typealias Font = UIFont
#endif

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Fonts

// swiftlint:disable identifier_name line_length type_body_length
internal enum FontFamily {
  internal enum Lato {
    internal static let black = FontConvertible(name: "Lato-Black", family: "Lato", path: "Lato-Black.ttf")
    internal static let blackItalic = FontConvertible(name: "Lato-BlackItalic", family: "Lato", path: "Lato-BlackItalic.ttf")
    internal static let bold = FontConvertible(name: "Lato-Bold", family: "Lato", path: "Lato-Bold.ttf")
    internal static let boldItalic = FontConvertible(name: "Lato-BoldItalic", family: "Lato", path: "Lato-BoldItalic.ttf")
    internal static let hairline = FontConvertible(name: "Lato-Hairline", family: "Lato", path: "Lato-Thin.ttf")
    internal static let hairlineItalic = FontConvertible(name: "Lato-HairlineItalic", family: "Lato", path: "Lato-ThinItalic.ttf")
    internal static let italic = FontConvertible(name: "Lato-Italic", family: "Lato", path: "Lato-Italic.ttf")
    internal static let light = FontConvertible(name: "Lato-Light", family: "Lato", path: "Lato-Light.ttf")
    internal static let lightItalic = FontConvertible(name: "Lato-LightItalic", family: "Lato", path: "Lato-LightItalic.ttf")
    internal static let regular = FontConvertible(name: "Lato-Regular", family: "Lato", path: "Lato-Regular.ttf")
    internal static let all: [FontConvertible] = [black, blackItalic, bold, boldItalic, hairline, hairlineItalic, italic, light, lightItalic, regular]
  }
  internal static let allCustomFonts: [FontConvertible] = [Lato.all].flatMap { $0 }
  internal static func registerAllCustomFonts() {
    allCustomFonts.forEach { $0.register() }
  }
}
// swiftlint:enable identifier_name line_length type_body_length

// MARK: - Implementation Details

internal struct FontConvertible {
  internal let name: String
  internal let family: String
  internal let path: String

  internal func font(size: CGFloat) -> Font! {
    return Font(font: self, size: size)
  }

  internal func register() {
    // swiftlint:disable:next conditional_returns_on_newline
    guard let url = url else { return }
    CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
  }

  fileprivate var url: URL? {
    let bundle = Bundle(for: BundleToken.self)
    return bundle.url(forResource: path, withExtension: nil)
  }
}

internal extension Font {
  convenience init!(font: FontConvertible, size: CGFloat) {
    #if os(iOS) || os(tvOS) || os(watchOS)
    if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
      font.register()
    }
    #elseif os(OSX)
    if let url = font.url, CTFontManagerGetScopeForURL(url as CFURL) == .none {
      font.register()
    }
    #endif

    self.init(name: font.name, size: size)
  }
}

private final class BundleToken {}
