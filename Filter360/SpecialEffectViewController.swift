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
import ImageIO

class SpecialEffectViewController: UIViewController {
  
    let aUIImage = UIImage(named: "golden gate.png")!
    var aUIImageBackground = UIImage(named: "starrynight.jpg")!
    let aUIImageBackgroundLight = UIImage(named: "graydis.png")!
    let context = CIContext(options: nil)
    var imageToEdit: UIImage?
    var aCIImage: CIImage?
    var specialEffect: CIFilter?
    var outputCIImage: CIImage?
    var aCGImage: CGImage?
    var outputUIImage: UIImage?
    var aUIImageBackgroundNew: UIImage?
    var aCIImageBackground: CIImage?

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBAction func TappedReset(sender: AnyObject) {
        imageToEdit = aUIImage
        imageView.image = imageToEdit
    }

    @IBAction func TappedSaveButton(sender: AnyObject) {
        imageToEdit = ResizeImage(imageView.image!, targetSize: CGSize(width: 9616, height: 2313))
        print("\(CIImage(image: aUIImage)!.properties)")
        UIImageWriteToSavedPhotosAlbum(imageToEdit!, nil, nil, nil)
    }
    
    @IBAction func TappedHold(sender: AnyObject) {
        imageToEdit = imageView.image
    }
    
    func transformImage() {
        aCIImage = CIImage(image: imageToEdit!)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
    }
    func transformImageAndBackgroud() {
        aCIImage = CIImage(image: imageToEdit!)
        specialEffect!.setValue(aCIImage, forKey: kCIInputImageKey)
        aUIImageBackgroundNew = ResizeImage(aUIImageBackground, targetSize: imageToEdit!.size)
        aCIImageBackground = CIImage(image: aUIImageBackgroundNew!)
        specialEffect!.setValue(aCIImageBackground, forKey: kCIInputBackgroundImageKey)
    }
    
    func produceImage()  {
        outputCIImage = specialEffect!.outputImage
        aCGImage = context.createCGImage(outputCIImage!, fromRect: outputCIImage!.extent)
        outputUIImage = UIImage(CGImage: aCGImage!)
        imageView.image = outputUIImage
    }
    
    
    @IBAction func TappedZoomBlur(sender: AnyObject) {
//        inputCenter Default value: [150 150]
//        inputAmount Default value: 20.00
        
        specialEffect = CIFilter(name: "CIZoomBlur")
        transformImage()
        produceImage()
    }
    
    @IBAction func TappedMotionBlur(sender: AnyObject) {
//        inputRadius Default value: 20.00
//        inputAngle Default value: 0.00
        specialEffect = CIFilter(name: "CIMotionBlur")
        transformImage()
        produceImage()
    }
    
    @IBAction func TappedLineOverlayButton(sender: AnyObject) {
        specialEffect = CIFilter(name: "CILineOverlay")
        transformImage()
        produceImage()
    }
    
    @IBAction func TappedColorClamp(sender: AnyObject) {
//        inputMinComponents Default value: [0 0 0 0] Identity: [0 0 0 0]
//        inputMaxComponents Default value: [1 1 1 1] Identity: [1 1 1 1]
        
        specialEffect = CIFilter(name: "CIColorClamp")
        transformImage()
        specialEffect!.setValue(CIVector(x: 0.4, y: 0, z: 0.4, w: 0), forKey: "inputMinComponents")
        specialEffect!.setValue(CIVector(x: 0.8, y: 1, z: 0.8, w: 1), forKey: "inputMaxComponents")
        produceImage()
    }
    
    
    @IBAction func TappedColorPolynomial(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIColorPolynomial")
        transformImage()
        let r: [CGFloat] = [0.0, 0.0, 0.0, 0.4]
        let g: [CGFloat] = [0.0, 0.0, 0.5, 0.8]
        let b: [CGFloat] = [0.0, 0.0, 0.5, 0.1]
        let a: [CGFloat] = [0.0, 1.0, 1.0, 1.0]
        
        specialEffect!.setValue(CIVector(values: r, count: r.count), forKey: "inputRedCoefficients")
        specialEffect!.setValue(CIVector(values: g, count: g.count), forKey: "inputGreenCoefficients")
        specialEffect!.setValue(CIVector(values: b, count: b.count), forKey: "inputBlueCoefficients")
        specialEffect!.setValue(CIVector(values: a, count: a.count), forKey: "inputAlphaCoefficients")
        
        produceImage()
    }
    
    
    @IBAction func TappedHueAdjust(sender: AnyObject) {
//        inputAngle Default value: 0.00
        
        specialEffect = CIFilter(name: "CIHueAdjust")
        transformImage()
        specialEffect!.setValue(0.8, forKey: "inputAngle")
        produceImage()
    }
    
    
    @IBAction func TappedTemperatureAndTint(sender: AnyObject) {
//        inputNeutral Default value: [6500, 0]
//        inputTargetNeutral Default value: [6500, 0]
        
        specialEffect = CIFilter(name: "CITemperatureAndTint")
        transformImage()
        specialEffect!.setValue(CIVector(x: 6500, y: 500), forKey: "inputNeutral")
        specialEffect!.setValue(CIVector(x: 1000, y: 630), forKey: "inputTargetNeutral")
        produceImage()
    }
    
    
    

    @IBAction func TappedToneCurve(sender: AnyObject) {
//        inputPoint0 Default value: [0, 0]
//        inputPoint1 Default value: [0.25, 0.25]
//        inputPoint2 Default value: [0.5, 0.5]
//        inputPoint3 Default value: [0.75, 0.75]
//        inputPoint4 Default value: [1, 1]
        
        specialEffect = CIFilter(name: "CIToneCurve")
        transformImage()
        specialEffect!.setValue(CIVector(x: 0.0, y: 0.0), forKey: "inputPoint0")
        specialEffect!.setValue(CIVector(x: 0.27, y: 0.26), forKey: "inputPoint1")
        specialEffect!.setValue(CIVector(x: 0.5, y: 0.8), forKey: "inputPoint2")
        specialEffect!.setValue(CIVector(x: 0.7, y: 9.0), forKey: "inputPoint3")
        specialEffect!.setValue(CIVector(x: 1.0, y: 1.0), forKey: "inputPoint4")
        produceImage()
    }
    
    @IBAction func TappedVibrance(sender: AnyObject) {
        
        specialEffect = CIFilter(name: "CIVibrance")
        transformImage()
        specialEffect!.setValue(0.9, forKey: "inputAmount")
        produceImage()
    }
    
    @IBAction func TappedColorCrossPolynomial(sender: AnyObject) {
        //    inputRedCoefficientsDefault value: [1 0 0 0 0 0 0 0 0 0] Identity: [1 0 0 0 0 0 0 0 0 0]
        //    inputGreenCoefficients Default value: [0 1 0 0 0 0 0 0 0 0] Identity: [0 1 0 0 0 0 0 0 0 0]
        //    inputBlueCoefficients Default value: [0 0 1 0 0 0 0 0 0 0] Identity: [0 0 1 0 0 0 0 0 0 0]
        specialEffect = CIFilter(name: "CIColorCrossPolynomial")
        transformImage()
        let r: [CGFloat] = [0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let g: [CGFloat] = [0.0, 0.0, 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        let b: [CGFloat] = [1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
        
        specialEffect!.setValue(CIVector(values: r, count: r.count), forKey: "inputRedCoefficients")
        specialEffect!.setValue(CIVector(values: g, count: g.count), forKey: "inputGreenCoefficients")
        specialEffect!.setValue(CIVector(values: b, count: b.count), forKey: "inputBlueCoefficients")
        produceImage()
    }
    

    
    
    
    @IBAction func TappedPhotoEffectChrome(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIPhotoEffectChrome")
        transformImage()
        produceImage()
    }
    
    
    
    @IBAction func TappedDifferenceBlendMode(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIDifferenceBlendMode")
        transformImageAndBackgroud()
        produceImage()
    }
    
    @IBAction func TappedHardLightBlendMode(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIHardLightBlendMode")
        transformImageAndBackgroud()
        produceImage()
    }
    
    @IBAction func TappedLuminosityBlend(sender: AnyObject) {
        specialEffect = CIFilter(name: "CILuminosityBlendMode")
        transformImageAndBackgroud()
        produceImage()
    }

    
    

    @IBAction func TappedDisplacementDistortion(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIDisplacementDistortion")
        transformImageAndBackgroud()
        specialEffect!.setValue(30.0, forKey: "inputScale")
        produceImage()
    }
    
    
    
    @IBAction func TappedSharpenLuminance(sender: AnyObject) {
//        inputSharpness Default value: 0.40
        
        specialEffect = CIFilter(name: "CISharpenLuminance")
        transformImage()
        specialEffect!.setValue(0.8, forKey: "inputSharpness")
        produceImage()
    }

    
    
    @IBAction func TappedBloom(sender: AnyObject) {
//        inputRadius Default value: 10.00
//        inputIntensity Default value: 0.5
        
        specialEffect = CIFilter(name: "CIBloom")
        transformImage()
        specialEffect!.setValue(1.5, forKey: "inputIntensity")
        specialEffect!.setValue(aUIImage.size.width / 200, forKey: "inputRadius")
        produceImage()
    }
    
    
    
    @IBAction func TappedCIEdges(sender: AnyObject) {
        specialEffect = CIFilter(name: "CIEdges")
        transformImage()
        specialEffect!.setValue(1.5, forKey: "inputIntensity")
        produceImage()
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
        imageToEdit = aUIImage
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
