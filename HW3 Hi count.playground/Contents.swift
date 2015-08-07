//: Playground - noun: a place where people can play

import UIKit

var hi = "hi every hi other hi word hi is hi hi"
var split = hi.componentsSeparatedByString(" ")
var count = 0

for i in split{
  if i == "hi" {
   count++
  }
}