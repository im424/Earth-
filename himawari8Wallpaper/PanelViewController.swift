//
//  ViewController.swift
//  himawari8Wallpaper
//
//  Created by ToKin-Hang on 27/12/2015.
//  Copyright © 2015 to kin hang. All rights reserved.
//

import Cocoa
import ServiceManagement

class PanelViewController: NSViewController {

    
    @IBOutlet weak var imageTimeLabal: NSTextField!
    @IBOutlet weak var perviewImage: NSImageCell!
    @IBOutlet weak var startButton: NSButton!
    var isRunning = false
    let wallpaperManger = Wallpaper()
    var timer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startService()
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBOutlet weak var test: NSTextField!

    @IBAction func loginItemDidPressed(sender: NSButton) {
    
        let helperURL = NSBundle.mainBundle().bundleURL.URLByAppendingPathComponent("Contents/Resources/Contents/Library/LoginItems/himawari8Wallpaper Helper.app")
       let status = LSRegisterURL(helperURL, false)
        if status != 0 {
            print("Fail to set login item \(status)")
        }
            
        if !SMLoginItemSetEnabled("com.tokinhang.himawari8Wallpaper-Helper", sender.state == 1){
            print("Fail to set login item")
        }
    }
    @IBAction func startButtonDidPress(sender: NSButton) {
        if isRunning {
            startButton.title = "Start"
            timer.invalidate()
            isRunning = false
        }else{
            startService()
            timer = NSTimer.scheduledTimerWithTimeInterval(15*60, target: self, selector: "startService", userInfo: nil, repeats: true)
        }
    }
    
    @IBAction func QuitButtonDidPressed(sender: AnyObject) {
        NSApp.terminate(nil)
    }
    func startService(){
        startButton.title = "Stop"
        isRunning = true
        wallpaperManger.getImage(){
            image in
            self.perviewImage.image = self.wallpaperManger.image
            self.wallpaperManger.setWallpaper(image)
            if self.wallpaperManger.time != nil {
                self.imageTimeLabal.stringValue = self.wallpaperManger.time!
            }
        }
    }
    

}

