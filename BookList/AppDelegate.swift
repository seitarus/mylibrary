/// Copyright (c) 2018 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import CoreData
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    MagicalRecord.setupCoreDataStack(withStoreNamed: "Library")
        
    //------------------------------------------
    // Prepopulate Beer
    
    // This prevents the default data from getting loaded more than once.
    let preloadKey = UserDefaults.standard.string(forKey: "MR_HasPreFilledBooks")
    
    //--------------------
    if let _ = preloadKey {
      // Defaults have already been loaded.
      
      // OPTION 2: UNCOMMENT THIS LINE TO FORCE PREPOPULATING BEERS EVEN IF THEY HAVE ALREADY BEEN LOADED ONCE BEFORE.
      //populateBeers()
      
    } else {
      // Defaults have NOT been loaded.
      
      // OPTION 1: UNCOMMENT THIS LINE TO PREPOPULATE BEERS ONLY ONCE.
      populateBooks()
    }
    //------------------------------------------
    
    Populator.updateImages()
    
    return true
  }

  func applicationWillTerminate(_ application: UIApplication) {
    
    MagicalRecord.save { (localContext) in
      print("Saving in Core Data");
    } completion: { (sucess, error) in
      
      if let error = error {
        print("ERROR: ", error);
      }
      
    }
  }
  
  //#####################################################################
  // MARK: - Prepopulate Data
  
  private func populateBooks() {
    
    Populator.populate()
    
    // Set User Default to Prevent Subsequent Preloads on startup.
    UserDefaults.standard.set("ok", forKey: "MR_HasPreFilledBooks")
    UserDefaults.standard.synchronize()
  }
}
