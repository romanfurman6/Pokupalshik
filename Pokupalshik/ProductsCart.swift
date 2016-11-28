

import Foundation

class ProductsCart {
    
    private var productsList: [Product] = [] {
        didSet {
            productsList = quickSort(arr: productsList)
        }
    }
    
    func clearCart() {
        productsList.removeAll()
    }
    var isEmpty: Bool {
        return productsList.isEmpty
    }
    
    func add(product: Product) {
        productsList.append(product)
    }
    
    var countOfProduct: Int {
        return productsList.count
    }

    var totalProductsPrice: Double {
       return (productsList.map { $0.price }.reduce(0.0, +)) * CurrencyStorage.shared.currentCurrency.coef
    }
    
    func totalPriceOf(product: Product) -> Double {
        var price = 0.0
        var product = products.filter { $0.0 == product }
        if !product.isEmpty {
            price = (product[0].0.price * Double(product[0].1)) * CurrencyStorage.shared.currentCurrency.coef
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
        guard let indexOfProduct = productsList.index(of: product) else {
            return
        }
        productsList.remove(at: indexOfProduct)

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

extension ProductsCart {
    
    func quickSort(arr: [Product]) -> [Product] {
        if arr.count > 1 {
            
            var less: [Product] = []
            var equal: [Product] = []
            var greater: [Product] = []
            
            let pivot = arr[0]
            for i in arr {
                if i.id < pivot.id {
                    less.append(i)
                } else if i.id == pivot.id {
                    equal.append(i)
                } else {
                    greater.append(i)
                }
            }
            return quickSort(arr: less) + equal + quickSort(arr: greater)
        } else {
            return arr
        }
    }
}
