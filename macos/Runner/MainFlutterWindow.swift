import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterView/Controller = FlutterView/Controller.init()
    let windowFrame = self.frame
    self.contentView/Controller = flutterView/Controller
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterView/Controller)

    super.awakeFromNib()
  }
}
