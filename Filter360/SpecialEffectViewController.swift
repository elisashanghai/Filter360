//
//  SpecialEffectViewController.swift
//  Filter360
//
//  Created by Yang Song on 7/22/16.
//  Copyright © 2016 Yang Song. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics

class SpecialEffectViewController: UIViewController {
  
    let aUIImage = UIImage(named: "colorful.png")!
    let aUIImageBackground = UIImage(named: "starrynight.jpg")!
    let  aUIImageBackgroundLight = UIImage(named: "graydis.png")!
    let context = CIContext(options: nil)
    var displayedImage: UIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func TappedReset(sender: AnyObject) {
        imageView.image = UIImage(named: "colorful.png")!
    }

    @IBAction func TappedHold(sender: AnyObject) {
        displayedImage = imageView.image
    }
    
    
    
    
    @IBAction func TappedZoomBlur(sender: AnyObject) {
//        inputCenter Default value: [150 150]
//        inputAmount Default value: 20.00
        
        let specialEffect = CIFilter(name: "CIZoomBlur")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    @IBAction func TappedMotionBlur(sender: AnyObject) {
//        inputRadius Default value: 20.00
//        inputAngle Default value: 0.00
        let specialEffect = CIFilter(name: "CIMotionBlur")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage

    }
    @IBAction func TappedLineOverlayButton(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CILineOverlay")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    
    }
    
    @IBAction func TappedColorClamp(sender: AnyObject) {
//        inputMinComponents Default value: [0 0 0 0] Identity: [0 0 0 0]
//        inputMaxComponents Default value: [1 1 1 1] Identity: [1 1 1 1]
        
        let specialEffect = CIFilter(name: "CIColorClamp")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(CIVector(x: 0.4, y: 0, z: 0.4, w: 0), forKey: "inputMinComponents")
        specialEffect!.setValue(CIVector(x: 0.8, y: 1, z: 0.8, w: 1), forKey: "inputMaxComponents")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    
    @IBAction func TappedColorPolynomial(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CIColorPolynomial")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        let r: [CGFloat] = [0.0, 0.0, 0.0, 0.4]
        let g: [CGFloat] = [0.0, 0.0, 0.5, 0.8]
        let b: [CGFloat] = [0.0, 0.0, 0.5, 0.1]
        let a: [CGFloat] = [0.0, 1.0, 1.0, 1.0]
        
        specialEffect!.setValue(CIVector(values: r, count: r.count), forKey: "inputRedCoefficients")
        specialEffect!.setValue(CIVector(values: g, count: g.count), forKey: "inputGreenCoefficients")
        specialEffect!.setValue(CIVector(values: b, count: b.count), forKey: "inputBlueCoefficients")
        specialEffect!.setValue(CIVector(values: a, count: a.count), forKey: "inputAlphaCoefficients")
        
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    @IBAction func TappedHueAdjust(sender: AnyObject) {
//        inputAngle Default value: 0.00
        
        let specialEffect = CIFilter(name: "CIHueAdjust")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(0.8, forKey: "inputAngle")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    @IBAction func TappedTemperatureAndTint(sender: AnyObject) {
//        inputNeutral Default value: [6500, 0]
//        inputTargetNeutral Default value: [6500, 0]
        
        let specialEffect = CIFilter(name: "CITemperatureAndTint")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(CIVector(x: 6500, y: 500), forKey: "inputNeutral")
        specialEffect!.setValue(CIVector(x: 1000, y: 630), forKey: "inputTargetNeutral")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    

    @IBAction func TappedToneCurve(sender: AnyObject) {
//        inputPoint0 Default value: [0, 0]
//        inputPoint1 Default value: [0.25, 0.25]
//        inputPoint2 Default value: [0.5, 0.5]
//        inputPoint3 Default value: [0.75, 0.75]
//        inputPoint4 Default value: [1, 1]
        
        let specialEffect = CIFilter(name: "CIToneCurve")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        specialEffect!.setValue(CIVector(x: 0.27, y: 0.26), forKey: "inputPoint1")
        specialEffect!.setValue(CIVector(x: 0.5, y: 0.8), forKey: "inputPoint2")
        specialEffect!.setValue(CIVector(x: 0.7, y: 9.0), forKey: "inputPoint3")
        specialEffect!.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    @IBAction func TappedVibrance(sender: AnyObject) {
        
        let specialEffect = CIFilter(name: "CIVibrance")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(0.9, forKey: "inputAmount")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    @IBAction func TappedColorCrossPolynomial(sender: AnyObject) {
        //    inputRedCoefficientsDefault value: [1 0 0 0 0 0 0 0 0 0] Identity: [1 0 0 0 0 0 0 0 0 0]
        //    inputGreenCoefficients Default value: [0 1 0 0 0 0 0 0 0 0] Identity: [0 1 0 0 0 0 0 0 0 0]
        //    inputBlueCoefficients Default value: [0 0 1 0 0 0 0 0 0 0] Identity: [0 0 1 0 0 0 0 0 0 0]
        let specialEffect = CIFilter(name: "CIColorCrossPolynomial")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        
        let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        specialEffect!.setValue(CIVector(values: r, count: r.count), forKey: "inputRedCoefficients")
        specialEffect!.setValue(CIVector(values: g, count: g.count), forKey: "inputGreenCoefficients")
        specialEffect!.setValue(CIVector(values: b, count: b.count), forKey: "inputBlueCoefficients")

        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    

    
    
    
    @IBAction func TappedPhotoEffectChrome(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CIPhotoEffectChrome")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    
    @IBAction func TappedDifferenceBlendMode(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CIDifferenceBlendMode")
        let aUIImageBackgroundNew = self.ResizeImage(aUIImageBackground, targetSize: aUIImage.size)
        let aCIImage = CIImage(image: aUIImage)
        let aCIImageBackground = CIImage(image: aUIImageBackgroundNew)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(aCIImageBackground, forKey: kCIInputBackgroundImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    @IBAction func TappedHardLightBlendMode(sender: AnyObject) {
            let specialEffect = CIFilter(name: "CIHardLightBlendMode")
            let aUIImageBackgroundNew = self.ResizeImage(aUIImageBackground, targetSize: aUIImage.size)
            let aCIImage = CIImage(image: aUIImage)
            let aCIImageBackground = CIImage(image: aUIImageBackgroundNew)
            specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
            specialEffect!.setValue(aCIImageBackground, forKey: kCIInputBackgroundImageKey)
            let outputImage = specialEffect?.outputImage
            let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
            let newUIImage = UIImage(CGImage: cgimg)
            imageView.image = newUIImage
    }
    
    @IBAction func TappedLuminosityBlend(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CILuminosityBlendMode")
        let aUIImageBackgroundNew = self.ResizeImage(aUIImageBackgroundLight, targetSize: aUIImage.size)
        let aCIImage = CIImage(image: aUIImage)
        let aCIImageBackground = CIImage(image: aUIImageBackgroundNew)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(aCIImageBackground, forKey: kCIInputBackgroundImageKey)
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage

    }

    
    

    @IBAction func TappedDisplacementDistortion(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CIDisplacementDistortion")
        let aUIImageBackgroundNew = self.ResizeImage(aUIImageBackgroundLight, targetSize: aUIImage.size)
        let aCIImage = CIImage(image: aUIImage)
        let aCIImageBackground = CIImage(image: aUIImageBackgroundNew)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        specialEffect!.setValue(aCIImageBackground, forKey: kCIInputBackgroundImageKey)
        specialEffect!.setValue(30.0, forKey: "inputScale")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    
    @IBAction func TappedSharpenLuminance(sender: AnyObject) {
//        inputSharpness Default value: 0.40
        
        let specialEffect = CIFilter(name: "CISharpenLuminance")
        
        let aCIImage = CIImage(image: aUIImage)
        
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        
        specialEffect!.setValue(0.8, forKey: "inputSharpness")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }

    
    
    @IBAction func TappedBloom(sender: AnyObject) {
//        inputRadius Default value: 10.00
//        inputIntensity Default value: 0.5
        
        let specialEffect = CIFilter(name: "CIBloom")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        
        specialEffect!.setValue(1.5, forKey: "inputIntensity")
        specialEffect!.setValue(aUIImage.size.width / 200, forKey: "inputRadius")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    
    
    @IBAction func TappedCIEdges(sender: AnyObject) {
        let specialEffect = CIFilter(name: "CIEdges")
        let aCIImage = CIImage(image: aUIImage)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        
        specialEffect!.setValue(1.5, forKey: "inputIntensity")
        let outputImage = specialEffect?.outputImage
        let cgimg = context.createCGImage(outputImage!, fromRect: outputImage!.extent)
        let newUIImage = UIImage(CGImage: cgimg)
        imageView.image = newUIImage
    }
    
    func ResizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / image.size.width
//        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
//        } else {
//            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
//        }
        
        newSize = CGSizeMake(targetSize.width, targetSize.height)
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
