

import Foundation

class ProductsCart {
    
    private var productsList: [Product] = []
    
    func clearCart() {
        productsList.removeAll()
    }
    
    func add(product: Product) {
        productsList.append(product)
    }
    
    var countOfProduct: Int {
        return productsList.count
    }

    var totalProductsPrice: Double {
       return productsList.map { $0.price }.reduce(0.0, +)
    }
    
    func totalPriceOf(product: Product) -> Double {
        var price = 0.0
        var product = products.filter { $0.0 == product }
        if !product.isEmpty {
            price = product[0].0.price * Double(product[0].1)
        }
        return price
    }
    
    func deleteAll(product: Product) {
        productsList = productsList.filter { $0 != product }
    }
    
    func getCountOf(product: Product) -> Int {
        return products.filter({ $0.0 == product })[0].1
    }
    
    func delete(product: Product) {
        var reverceArr = Array(productsList.reversed())
        guard let indexOfProduct = reverceArr.index(of: product) else {
            return
        }
        reverceArr.remove(at: indexOfProduct)
        productsList = Array(reverceArr.reversed())
    }
    
    func duplicate(product: Product) {
        guard let indexOfProduct = productsList.index(of: product) else {
            return
        }
        productsList.append(productsList[indexOfProduct])
    }
    
    var products: [(Product, Int)] {
        return productsList.frequencyTuple()
    }
}
