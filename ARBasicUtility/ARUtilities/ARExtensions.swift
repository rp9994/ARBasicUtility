//
//  Extensions.swift
//  ARBasic
//
//  Created by Ronak Adeshara on 17/11/18.
//  Copyright © 2018 Ronak Adeshara. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
import KRProgressHUD
import KRActivityIndicatorView
import SDWebImage

private var maxLengths = [UITextField: Int]()

extension String{
    func toDate(_ strFormat:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = strFormat
        return dateFormatter.date(from: self)!
    }
    
    func isNumber() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "0123456789")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func isCountryCode() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "+0123456789")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func isMobileNumber() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "0123456789")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func isPhoneNumber() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "+ ")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    
    func isPostCode() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "-0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil {
            return false
        }
        return true
    }
    func isAlphaNumeric() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 ")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil
        {
            return false
        }
        return true
    }
    
    func isAlphabet() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz ")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil
        {
            return false
        }
        return true
    }
    func isAlphaNumericWithSpecialChar() -> Bool{
        let characterSet = CharacterSet.init(charactersIn: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz` !@#/$%^&*()_+|}{;:><")
        
        if self.rangeOfCharacter(from: characterSet.inverted) != nil
        {
            return false
        }
        return true
    }
}

extension UIAlertController{
    func setUI(_ backgroundColor:UIColor,tintColor:UIColor){
        let subview = (self.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.layer.cornerRadius = 1
        subview.backgroundColor = backgroundColor
        self.view.tintColor = tintColor
        subview.layer.cornerRadius = 10.0
    }
}

extension UIViewController{
    func showProgress(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            KRProgressHUD.show()
        }
    }
    
    func hideProgress(){
        KRProgressHUD.dismiss()
    }
    func showNavigation(){
        self.navigationController?.navigationBar.isHidden = false
    }
    func hideNavigation(){
        self.navigationController?.navigationBar.isHidden = true
    }
    func popScreen(animated:Bool){
        self.navigationController?.popViewController(animated: animated)
    }
    func dismissScreen(animated:Bool){
        self.dismiss(animated: animated, completion: nil)
    }
    func performSegue(_ identifier:String){
        self.performSegue(withIdentifier: identifier, sender: nil)
    }
    func popOff(){
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension UIImage{
    public var hasContent: Bool {
        return cgImage != nil || ciImage != nil
    }
}
extension Double {
    mutating func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Darwin.round(self * divisor) / divisor
    }
}

extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

extension UIView{
    
    func applyGradient(withColours colours: [UIColor], locations: [NSNumber]? = nil) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    @IBInspectable var borderColor:UIColor? {
        set {
            layer.borderColor = newValue!.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var borderWidth:CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    
    func setShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.40
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 2.0
    }
    
    func setShadowWithColor(_ color:UIColor,opacity:Float){
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 4.0
    }
    
    func makeRounded(){
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = true
    }
    
    @IBInspectable var shadow:Bool {
        set {
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
                layer.shadowRadius = 2.0
                layer.shadowOpacity = 0.3
                layer.masksToBounds = false
            }
        }
        get {
            if layer.shadowColor != nil {
                return true
            }
            else {
                return false
            }
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
    
    public func shake()
    {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.10
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 5, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x+5 ,y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }

}



extension UINavigationBar {
    
    func setGradientBackground(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation) {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
//        self.layer.insertSublayer(gradient, at: 0)
        setBackgroundImage(gradient.createGradientImage(), for: UIBarMetrics.default)
    }
}

extension Notification.Name {
    static let autoLogout = Notification.Name(
        rawValue: "autoLogout")
    static let refreshData = Notification.Name(
        rawValue: "refreshData")
    static let loginRefresh = Notification.Name(
        rawValue: "loginRefresh")
    static let openSchedulePlan = Notification.Name(
        rawValue: "openSchedulePlan")
}
extension CAGradientLayer {
    
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        for color in colors {
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 0, y: 1)
    }
    
    func createGradientImage() -> UIImage? {
        
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
    
}
extension Date {
    func currentTimeZoneDate() -> String {
        let dtf = DateFormatter()
        dtf.timeZone = TimeZone.current
        dtf.dateFormat = "MMMM dd,yyyy HH:mm:ss"
        
        return dtf.string(from: self)
    }
}

extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIImageView
{
    func downloadImage(urlString:String){
        let url = URL(string: urlString)
        self.sd_setIndicatorStyle(UIActivityIndicatorView.Style.gray)
        self.sd_setShowActivityIndicatorView(true)
        self.sd_setImage(with: url, completed: nil)
    }
    func addBlurEffect()
    {
        self.backgroundColor = UIColor.white
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.7
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    func applyBlurEffect() -> UIImage{
        let imageToBlur = CIImage(image: self.image!)
        let blurfilter = CIFilter(name: "CIGaussianBlur")
        blurfilter?.setValue(imageToBlur, forKey: "inputImage")
        let resultImage = blurfilter?.value(forKey: "outputImage") as! CIImage
        let blurredImage = UIImage(ciImage: resultImage)
        return blurredImage
    }
}

extension UITextField
{
    public func isEmpty()->Int
    {
        if self.text!.trimmingCharacters(in: CharacterSet.whitespaces) != ""
        {
            return 0
        }
        self.layer.borderColor = UIColor.red.withAlphaComponent(0.5).cgColor
        self.placeHolderColor = UIColor.red.withAlphaComponent(0.5)
        self.shake()
        return 1
    }
        
    func isValidEmail() -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text)
    }
    
    public func isEmail() -> Int
    {
        let regex = try? NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$", options: .caseInsensitive)
        
        let bool = regex?.firstMatch(in: self.text!.trimmingCharacters(in: CharacterSet.whitespaces), options: [], range: NSMakeRange(0, self.text!.trimmingCharacters(in: .whitespaces).count)) != nil
        
        if bool == true
        {
            return 0
        }
        else
        {
            self.shake()
            return 1
        }
    }
    
    public func isValidPassword() -> Int
    {
    
        if !(self.text!.count < 8)
        {
            return 0
        }
        else
        {
            self.shake()
            return 1
        }
    }
    
    @IBInspectable var maxLength: Int
        {
        
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            
            addTarget(self, action: #selector(limitLength), for: .editingChanged)
        }
    }
    
    @objc func limitLength(textField:UITextField){
        guard let prospectiveText = textField.text , prospectiveText.characters.count > maxLength
            
            else
        {
            return
        }
        
        let selection = selectedTextRange
        
        let index = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        
        text = prospectiveText.substring(to: index)
        
        selectedTextRange = selection
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    
    func useUnderline() {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}

extension UIImage{
    
    func applyBlurEffect() -> UIImage{
        let imageToBlur = CIImage(image: self)!
        
        let blurfilter = CIFilter(name: "CIGaussianBlur")!
        blurfilter.setValue(35, forKey: kCIInputRadiusKey)
        blurfilter.setValue(imageToBlur, forKey: "inputImage")
        
        let resultImage = blurfilter.value(forKey: "outputImage") as! CIImage
        let croppedImage: CIImage = resultImage.cropped(to: CGRect(x:0, y:0, width:imageToBlur.extent.size.width, height:imageToBlur.extent.size.height))
        let context = CIContext(options: nil)
        let blurredImage = UIImage(cgImage:context.createCGImage(croppedImage, from: croppedImage.extent)!)
        
        return blurredImage
    }
    
    func removeBlurEffect() -> UIImage{
        let imageToBlur = CIImage(image: self)!
        
        let blurfilter = CIFilter(name: "CIGaussianBlur")!
        blurfilter.setValue(0, forKey: kCIInputRadiusKey)
        blurfilter.setValue(imageToBlur, forKey: "inputImage")
        
        let resultImage = blurfilter.value(forKey: "outputImage") as! CIImage
        let croppedImage: CIImage = resultImage.cropped(to: CGRect(x:0, y:0, width:imageToBlur.extent.size.width, height:imageToBlur.extent.size.height))
        let context = CIContext(options: nil)
        let blurredImage = UIImage(cgImage:context.createCGImage(croppedImage, from: croppedImage.extent)!)
        
        return blurredImage
    }
}
extension UIButton{
    
    func useUnderline(color:UIColor) {
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = color.cgColor
        border.frame = CGRect(origin: CGPoint(x: 0,y :self.frame.size.height - borderWidth), size: CGSize(width: self.frame.size.width, height: self.frame.size.height))
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UIColor {
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
}
@IBDesignable
class TextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0
    
    // placeholder position
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    
    
}

enum InputFieldType {
    case none
    case alphabet
    case number
}



typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint : CGPoint {
        return points.startPoint
    }
    
    var endPoint : CGPoint {
        return points.endPoint
    }
    
    var points : GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
            }
        }
    }
}
