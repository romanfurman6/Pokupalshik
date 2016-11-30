

import UIKit

protocol ProductCollectionViewCellDelegate {
    func touchBegan(cell: ProductCollectionViewCell, event: UIEvent)
    func touchCancelled(cell: ProductCollectionViewCell, event: UIEvent)
    func touchEnded(cell: ProductCollectionViewCell, event: UIEvent)
}

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var currencyNameLabel: UILabel!
    
    var delegate: ProductCollectionViewCellDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: -1, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
        if let cellDelegate = self.delegate {
            cellDelegate.touchBegan(cell: self, event: event!)
        }

    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: -1, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        if let cellDelegate = self.delegate {
            cellDelegate.touchCancelled(cell: self, event: event!)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0, animations: { () -> Void in
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
        if let cellDelegate = self.delegate {
            cellDelegate.touchEnded(cell: self, event: event!)
        }
    }
}
