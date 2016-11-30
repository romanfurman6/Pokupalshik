
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let tabBarController = UITabBarController()
        window?.rootViewController = tabBarController
        
        appCoordinator = AppCoordinator(window: window!, tabBarController: tabBarController)
        appCoordinator.start()
        
        checkDatabase()

        return true
    }
    
    func checkDatabase() {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let documentsDatabaseURL = documentsURL.appendingPathComponent("PokupalshikDB.db")
        
        if !FileManager.default.fileExists(atPath: documentsDatabaseURL.path) {
            do {
                let databasePath = Bundle.main.path(forResource: "PokupalshikDB", ofType: "db")!
                try FileManager.default.copyItem(atPath: databasePath, toPath: documentsDatabaseURL.path)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    }
}

