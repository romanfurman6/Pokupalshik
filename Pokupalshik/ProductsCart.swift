

import Foundation

class ProductsCart {
    private var productsList: [Product] = []
    
    func add(product: Product) {
        productsList.append(product)
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
