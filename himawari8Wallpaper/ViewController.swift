//
//  ViewController.swift
//  himawari8Wallpaper
//
//  Created by ToKin-Hang on 27/12/2015.
//  Copyright © 2015 to kin hang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    
    @IBOutlet weak var imageTimeLabal: NSTextField!
    @IBOutlet weak var perviewImage: NSImageCell!
    @IBOutlet weak var startButton: NSButton!
    var isRunning = false
    let wallpaperManger = Wallpaper()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonDidPress(sender: NSButton) {
        if isRunning {
            startButton.title = "Stop Running"
        }else{
            startButton.title = "Start Running"
            
            
            wallpaperManger.getImage(){
                image in
                self.perviewImage.image = self.wallpaperManger.image
                self.wallpaperManger.setWallpaper(image)
                if self.wallpaperManger.time != nil {
                    self.imageTimeLabal.stringValue = self.wallpaperManger.time!
                }
            }
           
            
        }
        
        isRunning = !isRunning
    }
    
    

}

