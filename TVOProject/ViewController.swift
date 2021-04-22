//
//  ViewController.swift
//  TVOProject
//
//  Created by Ngavt on 4/15/21.
//

import UIKit
import Moya

extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.ngavt.tvo.KeyboardCustomTVO")!
}

class ViewController: BaseVC, NSFilePresenter {
    @IBOutlet weak var tf: UITextField!
    let group = DispatchGroup()
    
    var presentedItemURL: URL?
    var presentedItemOperationQueue: OperationQueue = OperationQueue.main
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAllApi()
        // Do any additional setup after loading the view.
        UserDefaults.group.set("Doom222", forKey: "customKeyboardAct")
        
        let file = "keyboard.txt"
        let dir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.ngavt.tvo.KeyboardCustomTVO")!
        presentedItemURL = dir.appendingPathComponent(file)
        
        
        //NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        //mergeImage()
    }
    
    @objc func keyboardDidHide() {
        callAllApi()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // register for presentedItemDidChange work
        NSFileCoordinator.addFilePresenter(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // unregister - required !!
        NSFileCoordinator.removeFilePresenter(self)
    }
    
    func presentedItemDidChange() { // posted on changed existed file only
        callAllApi()
    }
    
    func callAllApi(){
        tf.resignFirstResponder()
        DispatchQueue.main.async {
            self.showLoading()
        }
        callStatisticDataApi()
        callObservingPairsApi()
        group.notify(queue: .main){
            self.hideLoading()
        }
    }
    
    func callStatisticDataApi(){
        group.enter()
        var options = NetworkOptions()
        options.parentVC = self
        options.showOutputLog = false
        options.showLoading = false
        options.autoShowErrorAlert = false
        var input: [String: Any] = [:]
        input["start_id"] = -1
        input["end_id"] = -1
        ExampleEndpoint.get_statistic_data(params: input).sendRequest(
            parsingModelType: StatisticDataModel.self, options: options, success: { (resp) in
                //let lstFilter = resp.orders?.filter({$0.status != 1})
                //
                self.group.leave()
            }, failure: { _ in
                //
                self.group.leave()
            })
    }
    
    func callObservingPairsApi() {
        group.enter()
        var options = NetworkOptions()
        options.parentVC = self
        options.showOutputLog = false
        options.showLoading = false
        options.autoShowErrorAlert = false
        ExampleEndpoint.get_observing_pairs.sendRequest(
            parsingModelType: ObservingPairsModel.self, options: options, success: { (resp) in
                //let lstFilter = resp.orders?.filter({$0.status != 1})
                //
                self.group.leave()
            }, failure: { _ in
                //
                self.group.leave()
            })
    }
    
    func mergeImage(){
        let imgStrLst = ["image2", "image3"]
        var uiImageLst = [UIImageView]()
        for imgStr in imgStrLst {
            if let uiImg = UIImage(named: imgStr) {
                uiImageLst.append(UIImageView(image: uiImg))
            }
            
        }
        var width: CGFloat = 0.0
        var height: CGFloat = 0.0

    
        for imgView in uiImageLst {
            width += imgView.frame.size.width
            height += imgView.frame.size.height
            
        }
        //let mergeView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
//        for imgView in uiImageLst {
//            mergeView.addSubview(imgView)
//        }
        
        //BEGIN THE GRAPHICS CONTEXT W.R.T THE VIEW'S BOUNDS
        let size = CGSize(width: width, height: height)
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        //RENDER THE VIEW
        //mergeView.layer.render(in: UIGraphicsGetCurrentContext()!)
        uiImageLst[0].draw(CGRect(x: 0, y: 0, width: size.width/2, height: size.height))
        uiImageLst[1].draw(CGRect(x: size.width/2, y: 0, width: size.width, height: size.height))
//        uiImageLst[2].draw(CGRect(x: 0, y: uiImageLst[0].frame.size.height + uiImageLst[1].frame.size.height, width: uiImageLst[2].frame.size.width, height: uiImageLst[2].frame.size.height))
        //GENERATE THE IMAGE
        let img = UIGraphicsGetImageFromCurrentImageContext()
        //END THE GRAPHICS CONTEXT
        UIGraphicsEndImageContext()
        // VOILA! THE BASE 64 STRING
        let _ = img?.jpegData(compressionQuality: 0)?.base64EncodedString() ?? ""
        
    }

    func capture(_ theView: UIView) -> UIImage? {
        var rect = theView.frame
        if (theView is UIScrollView) {
            rect.size = (theView as! UIScrollView).contentSize
        }
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()!
        theView.layer.render(in: context)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
    
    func compose(withHeader header: UIImage, content: UIImage, footer: UIImage) -> UIImage? {
        let size = CGSize(width: content.size.width, height: header.size.height + content.size.height + footer.size.height)
        UIGraphicsBeginImageContext(size)
        header.draw(in: CGRect(x: 0, y: 0, width: header.size.width, height: header.size.height))
        content.draw(in: CGRect(x: 0, y: header.size.height, width: content.size.width, height: content.size.height))
        footer.draw(in: CGRect(x: 0, y: header.size.height + content.size.height, width: footer.size.width, height: footer.size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

