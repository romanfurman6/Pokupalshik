import UIKit
import MIBadgeButton_Swift


class ProductsCollectionViewController: UICollectionViewController {
    
    var productList = [Product]()
    var count = 0
    var cart = ProductsCart()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        badgeCounter()
    }

    let cartBarButton: MIBadgeButton = MIBadgeButton(frame: CGRect(x: 0, y: 0, width: 35, height: 35))

    func createCartButtonWithBadge() {
        cartBarButton.setImage(UIImage(named: "Cart"), for: .normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cartBarButton)
        cartBarButton.addTarget(self,
                                action: #selector(handleCartTap),
                                for: .touchUpInside)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createCartButtonWithBadge()
        
        collectionView?.backgroundColor = UIColor(red: 235.0/255.0, green: 235.0/255.0, blue: 235.0/255.0, alpha: 1)
        
        productList = Product.service.fetchObjects()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let product = productList[indexPath.row]
        
        cell.image.image = UIImage(named: "\(product.name)")
        cell.nameLabel.text = product.name
        cell.priceLabel.text = String(product.price)
        
        cell.layer.cornerRadius = 10
        
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3
        cell.layer.shadowOpacity = 0.20
        cell.layer.masksToBounds = false
        
        
        return cell
    }
    func badgeCounter() {
        if cart.countOfProduct == 0 {
            cartBarButton.badgeString = nil
        } else {
            cartBarButton.badgeString = "\(cart.countOfProduct)"
        }
        
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let product = productList[indexPath.row]
        cart.add(product: product)
        badgeCounter()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cartSegue" {
            let cartVC = segue.destination as! CartViewController
            cartVC.productsCart = cart
            cartVC.purchasesHistory = nil
        }
    }
    
    func handleCartTap() {
        performSegue(withIdentifier: "cartSegue", sender: nil)
    }
}

