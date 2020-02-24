import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setDefaultWidgetAppearance()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.rootViewController = UINavigationController(rootViewController: MainViewController())
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

extension AppDelegate {    
    func setDefaultWidgetAppearance() {
        Settings.initDefaults(Config())
    }
}

class Config: SettingsConfig {
    var selectedColor: String { "eeeeee" }
    var primaryColor: String { "ff0000" }
}

///////////////////////////////////////////////////////////////////////
