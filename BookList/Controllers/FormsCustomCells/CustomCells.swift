//  CustomCells.swift
//  Eureka ( https://github.com/xmartlabs/Eureka )
//
//  Copyright (c) 2016 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import Foundation
import UIKit
import MapKit
import Eureka
import Cosmos

//MARK: RatingCell

public class RatingCell : Cell<Double>, CellType {
  
  @IBOutlet weak var cosmosView: CosmosView!
  
  open override func setup() {
    height = { 60 }
//    row.title = nil
    super.setup()
    selectionStyle = .none
    
    cosmosView.didFinishTouchingCosmos = { rating in
      self.row.value = rating
      self.row.updateCell() // Re-draws the cell which calls 'update' bellow
    }
    
  }

    open override func update() {
//        row.title = nil
        super.update()
//        let value = row.value
      row.value = cosmosView.rating
    }

}

//MARK: RatingRow

public final class RatingRow: Row<RatingCell>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
        cellProvider = CellProvider<RatingCell>(nibName: "RatingCell")
    }
}


//MARK: ImageAndTextCell

open class ImageAndTextCell : Cell<String>, CellType, UITextViewDelegate {
  
  @IBOutlet weak var icon: UIImageView!
  @IBOutlet weak var textview: UITextView!
  var imageUrl: String?
  var controller: UIViewController?
  
  open override func setup() {

    row.title = nil
    super.setup()
    selectionStyle = .none
    
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    icon.isUserInteractionEnabled = true
    icon.addGestureRecognizer(tapGestureRecognizer)
  }
  
  open override func update() {
      row.title = nil
      super.update()
      
    guard let textValue = textview.text else {
      row.value = nil
      return
    }
    guard !textValue.isEmpty else {
      row.value = nil
      return
    }
    
    row.value = textValue
  }
  
  public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    if(text == "\n") {
      textView.resignFirstResponder()
      return false
    }
    return true
  }
  
  public func textViewDidChange(_ textView: UITextView) {
    guard let textValue = textview.text else {
      row.value = nil
      return
    }
    guard !textValue.isEmpty else {
      row.value = nil
      return
    }
    
    row.value = textValue
    row.updateCell() // Re-draws the cell which calls 'update' bellow
  }
  
  @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
  {
//    let tappedImage = tapGestureRecognizer.view as! UIImageView
    
    print("Editar Imagen")
    
    if let controller = controller {
      controller.performSegue(withIdentifier: "SearchImageSegue", sender: nil)
    }
  }
    
}

//MARK: ImageAndTextRow

public final class ImageAndTextRow: Row<ImageAndTextCell>, RowType {

    required public init(tag: String?) {
        super.init(tag: tag)
        //displayValueFor = nil
        cellProvider = CellProvider<ImageAndTextCell>(nibName: "ImageAndTextCell")
    }
}
