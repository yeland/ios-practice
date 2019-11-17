import UIKit

protocol Promotion {
  var barcodes: [String] { get }
}

struct Item {
  let barcode: String
  let name: String
  let unit: String
  let price: Float
}

struct PurchasedItem {
  let item: Item
  let quantity: Int
  
  func getPrice() -> Float {
    let promotionItems = loadPromotions()[0].barcodes
    if promotionItems.contains(item.barcode) {
      return Float(quantity / 3 * 2 + quantity % 3) * item.price
    }
    return Float(quantity) * item.price
  }
  
  func getSingleReceipt() -> String {
    let formattedPrice = String(format: "%.2f", item.price)
    return "名称：\(item.name)，数量：\(quantity)\(item.unit)，单价：\(formattedPrice)(元)，小计：\(getPrice())(元)"
  }
}

struct BuyTwoGetOneFreePromotion: Promotion {
  var barcodes: [String]
}

func loadAllItems() -> [Item] {
  return [
    Item(
      barcode: "ITEM000000",
      name: "可口可乐",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000001",
      name: "雪碧",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000002",
      name: "苹果",
      unit: "斤",
      price: 5.50
    ),
    Item(
      barcode: "ITEM000003",
      name: "荔枝",
      unit: "斤",
      price: 15.00
    ),
    Item(
      barcode: "ITEM000004",
      name: "电池",
      unit: "个",
      price: 2.00
    ),
    Item(
      barcode: "ITEM000005",
      name: "方便面",
      unit: "袋",
      price: 4.50
    )
  ]
}

func loadPromotions() -> [Promotion] {
  return [
    BuyTwoGetOneFreePromotion(barcodes: ["ITEM000000", "ITEM000001", "ITEM000005"])

  ]
}
    
func getReceipt() -> String {
  let purchasrdBarcodesAndNumbers = getItemQuantity()
  let purchasedItems = getPurchasedItems(purchasrdBarcodesAndNumbers)
  let itemsString = getItemReceipt(purchasedItems)
  let footer = getTotal(purchasedItems)
  return """
  ***<没钱赚商店>收据***
  \(itemsString)
  ----------------------
  \(footer)
  **********************
  """
}

func getItemReceipt(_ purchasedItems: [PurchasedItem]) -> String {
  return purchasedItems.sorted(by: {
    if $0.item.barcode > $1.item.barcode {
      return false
    }
    return true
    }).map{ $0.getSingleReceipt() }.joined(separator: "\n")
}

func getItemQuantity() -> [String: Int] {
  var purchasedBarcodesAndNumbers = [String: Int]()
  for barcode in purchasedBarcodes {
    let barcodeSplit = barcode.split(separator: "-")
    let quantity = purchasedBarcodesAndNumbers[String(barcodeSplit[0])] ?? 0
    if barcodeSplit.count == 1 {
      purchasedBarcodesAndNumbers[String(barcodeSplit[0])] = quantity + 1
    } else {
      purchasedBarcodesAndNumbers[String(barcodeSplit[0])] = quantity + (String(barcodeSplit[1]) as NSString).integerValue
    }
  }
  return purchasedBarcodesAndNumbers
}

func getPurchasedItems(_ barcodesAndNumbers: [String: Int]) -> [PurchasedItem] {
  let items = loadAllItems()
  var purchasedItems = [PurchasedItem]()
  for (barcode, quantity) in barcodesAndNumbers {
    let item = items.filter({ $0.barcode == barcode }).first ?? items[0]
    purchasedItems.append(PurchasedItem(item: item, quantity: quantity))
  }
  return purchasedItems
}

func getTotal(_ purchasedItems: [PurchasedItem]) -> String {
  let total = purchasedItems.reduce(0, { $0 + $1.getPrice() })
  let savedPrice = purchasedItems.reduce(0, { $0 + Float($1.quantity) * $1.item.price }) - total
  return """
  总计：\(String(format: "%.2f", total))(元)
  节省：\(String(format: "%.2f", savedPrice))(元)
  """
}


let purchasedBarcodes = [
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000003-2",
  "ITEM000005",
  "ITEM000005",
  "ITEM000005"
]

let expectedReceipt = """
***<没钱赚商店>收据***
名称：雪碧，数量：5瓶，单价：3.00(元)，小计：12.0(元)
名称：荔枝，数量：2斤，单价：15.00(元)，小计：30.0(元)
名称：方便面，数量：3袋，单价：4.50(元)，小计：9.0(元)
----------------------
总计：51.00(元)
节省：7.50(元)
**********************
"""
let receipt = getReceipt()
print(receipt)
print("\n结果：" + (receipt == expectedReceipt ? "正确✔️" : "错误❌"))

