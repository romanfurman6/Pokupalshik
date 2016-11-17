

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
    
    func deleteAll(product: Product) {
        productsList = productsList.filter { $0 != product }
    }
    func deleteAt(product: Product) { //check it!
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
