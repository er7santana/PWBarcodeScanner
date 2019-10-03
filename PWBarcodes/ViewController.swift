//
//  ViewController.swift
//  PWBarcodes
//
//  Created by Eliezer Rodrigo on 02/10/19.
//  Copyright © 2019 Shaft Corporation. All rights reserved.
//

import UIKit
import BarcodeScanner

class ViewController: UIViewController {

    
    @IBOutlet weak var scannedValueLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - IBActions
    
    @IBAction func scanButtonTapped(_ sender: Any) {
        let viewController = makeBarcodeScannerViewController()
        viewController.title = "Barcode Scanner"
        present(viewController, animated: true, completion: nil)
        
        
//        let viewController = makeBarcodeScannerViewController()
//        viewController.title = "Barcode Scanner"
//        navigationController?.pushViewController(viewController, animated: true)
    }
    
    //MARK: - Show ScannerView
    
    private func makeBarcodeScannerViewController() -> BarcodeScannerViewController {
      let viewController = BarcodeScannerViewController()
      viewController.codeDelegate = self
      viewController.errorDelegate = self
      viewController.dismissalDelegate = self
      return viewController
    }
    
}

// MARK: - BarcodeScannerCodeDelegate
extension ViewController: BarcodeScannerCodeDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didCaptureCode code: String, type: String) {
    
    scannedValueLabel.text = code
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
        
        controller.resetWithError(message: "Product not found")
        controller.dismiss(animated: true, completion: nil)
    }
  }
}

// MARK: - BarcodeScannerErrorDelegate
extension ViewController: BarcodeScannerErrorDelegate {
  func scanner(_ controller: BarcodeScannerViewController, didReceiveError error: Error) {
    print(error)
  }
}

// MARK: - BarcodeScannerDismissalDelegate
extension ViewController: BarcodeScannerDismissalDelegate {
  func scannerDidDismiss(_ controller: BarcodeScannerViewController) {
    controller.dismiss(animated: true, completion: nil)
  }
}

