import Foundation


extension Process {
  static func runDownloadScript(url: URL, completion: ((Bool) -> ())? = nil) {
    if Defaults.shared.downloadScriptEnabled, let downloadScriptPath = Defaults.shared.downloadScriptPath {
      let script = Process()
      script.launchPath = downloadScriptPath.path
      script.arguments = [url.absoluteString]
      script.terminationHandler = { process in
        DispatchQueue.main.async {
          let success = process.terminationStatus == 0
          completion?(success)
          
          if !success {
            NSLog("Script termination status: \(process.terminationStatus)")
          }
        }
      }
      script.launch()
    }
  }
}
