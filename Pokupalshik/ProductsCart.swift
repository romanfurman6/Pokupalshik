

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
        var totalPrice = 0.0
        for i in productsList {
            totalPrice += i.price
        }
        return totalPrice
    }
    
    
    
    func totalPriceOf(product: Product) -> Double{
        var price = 0.0
        
        var product = products.filter { $0.0 == product }
        if product.count != 0 {
            price = product[0].0.price * Double(product[0].1)
        }
        
        return price
    }
    
    
    func deleteAll(product: Product) {
        productsList = productsList.filter { $0 != product }
    }
    
    func delete(product: Product) {
        for i in 0..<productsList.count {
            if productsList[i] == product {
                productsList.remove(at: i)
                break
            }
        }
    }
    
    func duplicate(product: Product) {
        for i in 0..<productsList.count {
            if productsList[i] == product {
                productsList.append(productsList[i])
                break
            }
        }
    }
    
    
    
    var products: [(Product, Int)] {
        
        
        var result = [(Product,Int)]()
        
        for i in productsList {
            var z = 0
            if result.isEmpty {
                result.append((i,0))
            }
            for (index,value) in result.enumerated() {
                if value.0 == i {
                    result[index].1 += 1
                    z = 1
                }
            }
            if z == 0 {
                result.append((i,1))
            }
        }
        return result
        
        
    }
}
