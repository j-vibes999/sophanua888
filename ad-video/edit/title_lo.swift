import AppKit
import CoreText
let fontDir = CommandLine.arguments[1], out = CommandLine.arguments[2]
for f in try! FileManager.default.contentsOfDirectory(atPath: fontDir) where f.hasSuffix(".ttf") {
  let url = URL(fileURLWithPath: fontDir + "/" + f) as CFURL
  CTFontManagerRegisterFontsForURL(url, .process, nil)
  if let d = (CTFontManagerCreateFontDescriptorsFromURL(url) as? [CTFontDescriptor])?.first,
     let n = CTFontDescriptorCopyAttribute(d, kCTFontNameAttribute) { print("font", n) }
}
let W = 720, H = 1280
let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: W, pixelsHigh: H, bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .deviceRGB, bytesPerRow: 0, bitsPerPixel: 0)!
let ctx = NSGraphicsContext(bitmapImageRep: rep)!
NSGraphicsContext.saveGraphicsState(); NSGraphicsContext.current = ctx
NSColor.clear.setFill(); NSRect(x: 0, y: 0, width: W, height: H).fill()
let p = NSMutableParagraphStyle(); p.alignment = .center
let sh = NSShadow(); sh.shadowColor = NSColor.black.withAlphaComponent(0.85); sh.shadowBlurRadius = 18; sh.shadowOffset = NSSize(width: 0, height: -3)
func draw(_ s: String, _ font: String, _ size: CGFloat, _ color: NSColor, _ yTop: CGFloat, _ h: CGFloat, kern: CGFloat = 0) {
  guard let f = NSFont(name: font, size: size) else { print("MISSING", font); return }
  let a: [NSAttributedString.Key: Any] = [.font: f, .foregroundColor: color, .paragraphStyle: p, .shadow: sh, .kern: kern]
  (s as NSString).draw(in: NSRect(x: 20, y: CGFloat(H) - yTop - h, width: CGFloat(W - 40), height: h), withAttributes: a)
}
let gold = NSColor(red: 1.0, green: 0.84, blue: 0.35, alpha: 1)
draw("ນ້ຳປາແດກປຸງລົດ", "NotoSansLaoLooped-Bold", 40, .white, 30, 80)
draw("ໂສພານົວ", "NotoSansLaoLooped-Black", 112, gold, 92, 190)
draw("SOPHANUA  ·  350 ມລ.", "NotoSansLao-Medium", 30, NSColor(white: 0.92, alpha: 1), 268, 60, kern: 3)
ctx.flushGraphics(); NSGraphicsContext.restoreGraphicsState()
try! rep.representation(using: .png, properties: [:])!.write(to: URL(fileURLWithPath: out))
