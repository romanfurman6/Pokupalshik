import UIKit
import MIBadgeButton_Swift
import RxSwift


class ProductsCollectionViewController: UICollectionViewController {
    
    var cartBarButton: MIBadgeButton = MIBadgeButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
    var itemsPerRow: CGFloat = 2
    let didTapCart = PublishSubject<Void>()
    let disposeBag = DisposeBag()
    let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    var productList = [Product]()
    var cart: ProductsCart!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBadgeCounter()
        checkDeviceOrientation()
        collectionView?.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Products"
        createCartButtonWithBadge()
        createClearCartButton()
        
        collectionView?.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        productList = Product.service.fetchObjects()
    }
    
    func checkDeviceOrientation() {
        if UIDevice.current.orientation.isPortrait {
            itemsPerRow = 2
            cartBarButton.transform = CGAffineTransform(scaleX: 1, y: 1)
        } else if UIDevice.current.orientation.isLandscape {
            itemsPerRow = 3
            cartBarButton.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        checkDeviceOrientation()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductCollectionViewCell
        cell.delegate = self
        let product = productList[indexPath.row]
        
        cell.image.image = UIImage(named: "\(product.name)")
        cell.nameLabel.text = product.name
        
        cell.currencyNameLabel.text = CurrencyStorage.shared.currentCurrency.name
        cell.priceLabel.text = String(((product.price) * Double((CurrencyStorage.shared.currentCurrency.coef))).roundTo(places: 2))
        
        cell.layer.cornerRadius = 10
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.20
        cell.layer.masksToBounds = false
        
        return cell
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}

extension ProductsCollectionViewController {
    
    func createClearCartButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearCart))
    }
    
    func clearCart() {
        cart.clearCart()
        updateBadgeCounter()
    }
    
    func createCartButtonWithBadge() {
        cartBarButton.setImage(UIImage(named: "Cart"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBarButton)
        
        cartBarButton.addTarget(self,
                                action: #selector(handleCartTap),
                                for: .touchUpInside)
    }
    
    func updateBadgeCounter() {
        if cart.countOfProduct == 0 {
            cartBarButton.badgeString = nil
        } else {
            cartBarButton.badgeString = "\(cart.countOfProduct)"
        }
    }
    
    func handleCartTap() {
        didTapCart.onNext(())
    }
}

extension ProductsCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

extension ProductsCollectionViewController: ProductCollectionViewCellDelegate {
    
    func touchBegan(cell: ProductCollectionViewCell, event: UIEvent) {}
    func touchEnded(cell: ProductCollectionViewCell, event: UIEvent) {
        let indexPath = collectionView?.indexPath(for: cell)
        let product = productList[(indexPath?.row)!]
        cart.add(product: product)
        updateBadgeCounter()
    }
    func touchCancelled(cell: ProductCollectionViewCell, event: UIEvent) {}
}

