
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        checkCurrentCurrency()
        
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
        return true
    }
    
    func checkCurrentCurrency() {
        let currentCurrencyName = "currentCurrencyName"
        let currentCurrencyCoef = "currentCurrencyCoef"
        
        let defaults = UserDefaults.standard
        if
            let _ = defaults.string(forKey: currentCurrencyName),
            let _ = defaults.string(forKey: currentCurrencyCoef) {
            
            CurrencyStorage.shared.currentCurrency = Currency(name: defaults.string(forKey: currentCurrencyName)!, coef: defaults.double(forKey: currentCurrencyCoef))
        } else {
            CurrencyStorage.shared.currentCurrency = Currency(name: "USD", coef: 1.0)
        }
    }
    

}

