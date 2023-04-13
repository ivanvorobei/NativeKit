#if canImport(UIKit)
import UIKit

extension UIImage {
    
    static var iconFontSize: Int { 16 }
    static var backgroundFontSize: Int { 32 }
    static var backgroundSystemName: String { "app.fill" }
    
    @available(iOS 13, tvOS 13, *)
    public static func generateSettingIcon(_ systemName: String, backgroundColor: UIColor) -> UIImage? {
        
        let iconConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat(iconFontSize), weight: .regular)
        let iconImage = UIImage(systemName: systemName, withConfiguration: iconConfiguration)?.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        #warning("bg area symol has border, must drop it")
        let backgroundConfiguration = UIImage.SymbolConfiguration(pointSize: CGFloat(backgroundFontSize), weight: .regular)
        let backgroundImage = UIImage(systemName: backgroundSystemName, withConfiguration: backgroundConfiguration)!.withTintColor(backgroundColor, renderingMode: .alwaysOriginal)
        
        let size = backgroundImage.size
        UIGraphicsBeginImageContextWithOptions(size, false, .zero)
        
        backgroundImage.draw(in: CGRect(origin: .zero, size: size))
        
        if let iconImage = iconImage {
            let iconSize = iconImage.size
            iconImage.draw(in: CGRect(
                origin: .init(
                    x: (size.width - iconSize.width) / 2,
                    y: (size.height - iconSize.height) / 2
                ),
                size: iconSize
            ))
        }
        
        let settingsImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return settingsImage
    }
}
#endif
