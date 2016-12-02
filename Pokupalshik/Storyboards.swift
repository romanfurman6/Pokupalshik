// Generated using SwiftGen, by O.Halligon — https://github.com/AliSoftware/SwiftGen

import Foundation
import UIKit

protocol StoryboardSceneType {
  static var storyboardName: String { get }
}

extension StoryboardSceneType {
  static func storyboard() -> UIStoryboard {
    return UIStoryboard(name: self.storyboardName, bundle: nil)
  }

  static func initialViewController() -> UIViewController {
    guard let vc = storyboard().instantiateInitialViewController() else {
      fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
    }
    return vc
  }
}

extension StoryboardSceneType where Self: RawRepresentable, Self.RawValue == String {
  func viewController() -> UIViewController {
    return Self.storyboard().instantiateViewController(withIdentifier: self.rawValue)
  }
  static func viewController(identifier: Self) -> UIViewController {
    return identifier.viewController()
  }
}

protocol StoryboardSegueType: RawRepresentable { }

extension UIViewController {
  func performSegue<S: StoryboardSegueType>(segue: S, sender: AnyObject? = nil) where S.RawValue == String {
    performSegue(withIdentifier: segue.rawValue, sender: sender)
  }
}

// swiftlint:disable file_length
// swiftlint:disable type_body_length

struct StoryboardScene {
  enum LaunchScreen: StoryboardSceneType {
    static let storyboardName = "LaunchScreen"
  }
  enum Main: String, StoryboardSceneType {
    static let storyboardName = "Main"

    static func initialViewController() -> HistoryTableViewController {
      guard let vc = storyboard().instantiateInitialViewController() as? HistoryTableViewController else {
        fatalError("Failed to instantiate initialViewController for \(self.storyboardName)")
      }
      return vc
    }

    case CartViewControllerScene = "CartViewController"
    static func instantiateCartViewController() -> CartViewController {
      guard let vc = StoryboardScene.Main.CartViewControllerScene.viewController() as? CartViewController
      else {
        fatalError("ViewController 'CartViewController' is not of the expected class CartViewController.")
      }
      return vc
    }

    case CurrencyTableViewControllerScene = "CurrencyTableViewController"
    static func instantiateCurrencyTableViewController() -> CurrencyTableViewController {
      guard let vc = StoryboardScene.Main.CurrencyTableViewControllerScene.viewController() as? CurrencyTableViewController
      else {
        fatalError("ViewController 'CurrencyTableViewController' is not of the expected class CurrencyTableViewController.")
      }
      return vc
    }

    case HistoryTableViewControllerScene = "HistoryTableViewController"
    static func instantiateHistoryTableViewController() -> HistoryTableViewController {
      guard let vc = StoryboardScene.Main.HistoryTableViewControllerScene.viewController() as? HistoryTableViewController
      else {
        fatalError("ViewController 'HistoryTableViewController' is not of the expected class HistoryTableViewController.")
      }
      return vc
    }

    case ProductsCollectionViewControllerScene = "ProductsCollectionViewController"
    static func instantiateProductsCollectionViewController() -> ProductsCollectionViewController {
      guard let vc = StoryboardScene.Main.ProductsCollectionViewControllerScene.viewController() as? ProductsCollectionViewController
      else {
        fatalError("ViewController 'ProductsCollectionViewController' is not of the expected class ProductsCollectionViewController.")
      }
      return vc
    }
  }
}

struct StoryboardSegue {
}
