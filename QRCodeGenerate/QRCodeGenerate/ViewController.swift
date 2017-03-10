//
//  ViewController.swift
//  QRCodeGenerate
//
//  Created by DW02 on 3/10/2560 BE.
//  Copyright © 2560 DW02. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var tfInput: UITextField!
    
    @IBOutlet weak var btGenerate: UIButton!
    
    @IBOutlet weak var imvQRCode: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tfInput.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    // MARK: - Action
    
    @IBAction func tapOnGenerateQRCode(_ sender: UIButton) {
        
        let imageQR:CIImage = self.generateQRCodeWith(String: self.tfInput.text!, Size: CGSize(width: 300, height: 300))
        
        self.imvQRCode.image = UIImage(ciImage: imageQR)
        
    }
    
    
    func generateQRCodeWith(String text:String, Size size:CGSize)->CIImage {
        
    
        
        let data = text.data(using: .utf8, allowLossyConversion: false)
        
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        filter?.setValue("Q", forKey: "inputCorrectionLevel")
        
        let qrCodeImage:CIImage! = filter?.outputImage
        
    
        let scaleX = size.width / qrCodeImage.extent.size.width
        let scaleY = size.height / qrCodeImage.extent.size.height
        
        let transformedImage = qrCodeImage.applying(CGAffineTransform(scaleX: scaleX, y: scaleY))
        
        
        return transformedImage
        
    }
    
}

extension ViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        
        
        let imageQR:CIImage = self.generateQRCodeWith(String: self.tfInput.text!, Size: CGSize(width: 300, height: 300))
        
        self.imvQRCode.image = UIImage(ciImage: imageQR)
        
        
        
        return true
    }
    
    
}

