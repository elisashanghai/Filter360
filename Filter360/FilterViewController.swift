//
//  FilterViewController.swift
//  Filter360
//
//  Created by Yang Song on 7/13/16.
//  Copyright © 2016 Yang Song. All rights reserved.
//

import UIKit
import MobileCoreServices
import CoreImage
import CoreGraphics


//CIColorMatrix

class FilterViewController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var sliderSaturation: UISlider!
        
    @IBOutlet weak var sliderContrast: UISlider!
    
    @IBOutlet weak var sliderBrightness: UISlider!
    
    @IBOutlet weak var saturationDisplay: UILabel!
  
    @IBOutlet weak var brightnessDisplay: UILabel!
    
    @IBOutlet weak var contrastDisplay: UILabel!

    @IBOutlet weak var imageView: UIImageView!

    
   

    
    var newMedia: Bool?
    let aUIImage = UIImage(named: "golden gate.png")!
    let context = CIContext(options: nil)
    let colorCtrls = CIFilter(name: "CIColorControls")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saturationDisplay.text = "0%"
        brightnessDisplay.text = "0%"
        contrastDisplay.text = "0%"
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func saturationValueChanged(sender: UISlider) {
        let aCIImage = CIImage(image: aUIImage)
        colorCtrls!.setValue(aCIImage, forKey: kCIInputImageKey)
        colorCtrls!.setValue(NSNumber(float: sender.value), forKey: kCIInputSaturationKey)
        let outputImage = colorCtrls!.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
        let currentValue = Int(sender.value / (sender.maximumValue - sender.minimumValue) * 200.0 - 100.0)
        saturationDisplay.text = "\(currentValue)%"
    }
    
    @IBAction func brightnessValueChanged(sender: UISlider) {
        let aCIImage = CIImage(image: aUIImage)
        colorCtrls!.setValue(aCIImage, forKey: kCIInputImageKey)
        colorCtrls!.setValue(NSNumber(float: sender.value), forKey: kCIInputBrightnessKey)
        let outputImage = colorCtrls!.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage

        let currentValue = Int(sender.value / (sender.maximumValue - sender.minimumValue) * 200.0)
//        let currentValue = Int(sender.value)
        brightnessDisplay.text = "\(currentValue)%"
    }
    @IBAction func contrastValueChanged(sender: UISlider)
    {
        
        let aCIImage = CIImage(image: aUIImage)
        colorCtrls!.setValue(aCIImage, forKey: kCIInputImageKey)
        colorCtrls!.setValue(NSNumber(float: sender.value), forKey: kCIInputContrastKey)
        let outputImage = colorCtrls!.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage

        let currentValue = Int(sender.value / (sender.maximumValue - sender.minimumValue) * 200.0 - 100.0)
        contrastDisplay.text = "\(currentValue)%"
    }
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == kUTTypeImage as String {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(FilterViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType == kUTTypeMovie as String {
                // Code to support video here
            }
            
        }
    }

    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafePointer<Void>) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.Alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .Cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.presentViewController(alert, animated: true,
                                       completion: nil)
        }
    }
}