
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
    
    func createRelations() { //   :D
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabBarController = UITabBarController()
        let navigationController1 = UINavigationController()
        let navigationController2 = UINavigationController()
        let navigationControllers = [navigationController1,navigationController2]
        
        let historyTableVC = storyboard.instantiateViewController(withIdentifier: "HistoryTableViewController") as! HistoryTableViewController
        let productsCollectionVC = storyboard.instantiateViewController(withIdentifier: "ProductsCollectionViewController") as! ProductsCollectionViewController
        
        navigationController1.viewControllers = [historyTableVC]
        navigationController2.viewControllers = [productsCollectionVC]
        
        navigationController1.tabBarItem = UITabBarItem(title: "History", image: nil, tag: 1)
        navigationController2.tabBarItem = UITabBarItem(title: "Products", image: nil, tag: 2)
        
        tabBarController.viewControllers = navigationControllers
        
        self.window?.rootViewController = tabBarController
        
        self.window?.makeKeyAndVisible()
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

