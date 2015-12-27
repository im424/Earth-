//
//  Wallpaper.swift
//  himawari8Wallpaper
//
//  Created by ToKin-Hang on 27/12/2015.
//  Copyright © 2015 to kin hang. All rights reserved.
//

import Foundation
import Cocoa

class Wallpaper {
    let jsonURL = "http://himawari8.nict.go.jp/img/D531106/latest.json"
    var image: NSImage?
    let workspace = NSWorkspace.sharedWorkspace()
    let screen = NSScreen.mainScreen()
    var time: String?
    
    
    
    func setWallpaper(url: String){
        do{
            try  workspace.setDesktopImageURL(NSURL(fileURLWithPath: "/tmp/himawari8_earth.png") , forScreen: screen!, options: ["NSWorkspaceDesktopImageScalingKey":"2"]) //NSImageScaling.ScaleNone
            
        }catch _{
            print("Fail to set")
        }
    }
    
    private func saveImageToTemp(){
        let imgRep = NSBitmapImageRep(data: self.image!.TIFFRepresentation! )
        let imgData = (imgRep?.representationUsingType(.NSPNGFileType, properties: [NSImageCompressionFactor: [1.0] ]))!
        imgData.writeToFile("/tmp/himawari8_earth.png", atomically: true)
    }
    
  
    func getImage(callback: String -> Void){
       
        getImageURL(){
            (imageURL, error) -> Void in
        
            if error != nil {
                print("ERROR \(error?.localizedCapitalizedString)")
            }else{
                self.image = NSURL(string: imageURL).flatMap{NSData(contentsOfURL: $0)}.flatMap{NSImage(data: $0)}
                self.saveImageToTemp()
                callback(imageURL)
             }
        }
    }

    
    
    private func getImageURL(callback: (String, String?) -> Void ){
        
        getHttp(jsonURL){
            (data, error) -> Void in
         
            if error != nil {
                callback("", error)
            }else{
                
                if let json =  self.parseJson(data!){
                    var data = json["date"] as! String
                    self.time = "at \(data) UTC"
                    data = data.stringByReplacingOccurrencesOfString(" ", withString: "/")
                    data = data.stringByReplacingOccurrencesOfString("-", withString: "/")
                    data = data.stringByReplacingOccurrencesOfString(":", withString: "")
                    callback("http://himawari8-dl.nict.go.jp/himawari8/img/D531106/thumbnail/550/\(data)_0_0.png" ,nil)
                }
                
            }
        }
    }
    

    private func getHttp(url: String, callback: (NSData?, String?) -> Void ) {
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){
            
            data,response,error in
            if error != nil {
                callback(nil, error?.localizedDescription)
            }else{
                callback(data ,nil )
            }
            
        }
        task.resume()
    }
    
    
    private func parseJson(json:NSData) -> NSDictionary? {
       // let data = json.dataUsingEncoding(NSUTF8StringEncoding)
        let jsonObj: AnyObject?
        
        do{
            jsonObj = try NSJSONSerialization.JSONObjectWithData(json, options: .AllowFragments)
        }catch _ {
            print("JSON PARSING ERROR")
            jsonObj = nil
        }
        return jsonObj as! NSDictionary?
    }
    
}