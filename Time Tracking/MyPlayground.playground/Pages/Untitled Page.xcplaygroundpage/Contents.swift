import UIKit

var str = "Hello, playground"

var firstCheckin: Date = Date().addingTimeInterval(TimeInterval.init(-2090))
var dateNow: Date = Date()

var interval = firstCheckin.distance(to: dateNow)
var teste = Int(interval)

var adskmd = (teste / 60) % 60
var dalsd = teste / 60 / 60
var sad = String(adskmd)

func hoursInterval(from: Date, to: Date) -> String {
    let _interval: Int = Int(from.distance(to: to))
    let hours: Int = (_interval / 60) % 60
    let hh: String = hours < 10 ? "0\(String(hours))" : String(hours)
    let min: Int = _interval / 60 / 60
    let mm = min < 10 ? "0\(String(min))" : String(min)
    return { "\(hh):\(mm)" }()
}

hoursInterval(from: firstCheckin, to: dateNow)

let date1 = Date()
let date2 = Date().advanced(by: -200000)

date1.distance(to: date2)

date2.timeIntervalSince1970 - date1.timeIntervalSince1970

