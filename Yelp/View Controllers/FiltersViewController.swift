//
//  FilterViewController.swift
//  Yelp
//
//  Created by Truong Vo Duy Thuc on 10/22/16.
//  Copyright © 2016 CoderSchool. All rights reserved.
//

import UIKit


@objc protocol FiltersViewControllerDelegate {
    @objc optional func filtersViewController(filtersViewController: FiltersViewController, didChangeValue filters: [String:AnyObject])
}

class FiltersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate:FiltersViewControllerDelegate?
    var categories: [[String: String]]! = [["name" : "Afghan", "code": "afghani"],
                                           ["name" : "African", "code": "african"],
                                           ["name" : "American, New", "code": "newamerican"],
                                           ["name" : "American, Traditional", "code": "tradamerican"],
                                           ["name" : "Arabian", "code": "arabian"],
                                           ["name" : "Argentine", "code": "argentine"],
                                           ["name" : "Armenian", "code": "armenian"],
                                           ["name" : "Asian Fusion", "code": "asianfusion"],
                                           ["name" : "Asturian", "code": "asturian"],
                                           ["name" : "Australian", "code": "australian"],
                                           ["name" : "Austrian", "code": "austrian"],
                                           ["name" : "Baguettes", "code": "baguettes"],
                                           ["name" : "Bangladeshi", "code": "bangladeshi"],
                                           ["name" : "Barbeque", "code": "bbq"],
                                           ["name" : "Basque", "code": "basque"],
                                           ["name" : "Bavarian", "code": "bavarian"],
                                           ["name" : "Beer Garden", "code": "beergarden"],
                                           ["name" : "Beer Hall", "code": "beerhall"],
                                           ["name" : "Beisl", "code": "beisl"],
                                           ["name" : "Belgian", "code": "belgian"],
                                           ["name" : "Bistros", "code": "bistros"],
                                           ["name" : "Black Sea", "code": "blacksea"],
                                           ["name" : "Brasseries", "code": "brasseries"],
                                           ["name" : "Brazilian", "code": "brazilian"],
                                           ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                                           ["name" : "British", "code": "british"],
                                           ["name" : "Buffets", "code": "buffets"],
                                           ["name" : "Bulgarian", "code": "bulgarian"],
                                           ["name" : "Burgers", "code": "burgers"],
                                           ["name" : "Burmese", "code": "burmese"],
                                           ["name" : "Cafes", "code": "cafes"],
                                           ["name" : "Cafeteria", "code": "cafeteria"],
                                           ["name" : "Cajun/Creole", "code": "cajun"],
                                           ["name" : "Cambodian", "code": "cambodian"],
                                           ["name" : "Canadian", "code": "New)"],
                                           ["name" : "Canteen", "code": "canteen"],
                                           ["name" : "Caribbean", "code": "caribbean"],
                                           ["name" : "Catalan", "code": "catalan"],
                                           ["name" : "Chech", "code": "chech"],
                                           ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                                           ["name" : "Chicken Shop", "code": "chickenshop"],
                                           ["name" : "Chicken Wings", "code": "chicken_wings"],
                                           ["name" : "Chilean", "code": "chilean"],
                                           ["name" : "Chinese", "code": "chinese"],
                                           ["name" : "Comfort Food", "code": "comfortfood"],
                                           ["name" : "Corsican", "code": "corsican"],
                                           ["name" : "Creperies", "code": "creperies"],
                                           ["name" : "Cuban", "code": "cuban"],
                                           ["name" : "Curry Sausage", "code": "currysausage"],
                                           ["name" : "Cypriot", "code": "cypriot"],
                                           ["name" : "Czech", "code": "czech"],
                                           ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                                           ["name" : "Danish", "code": "danish"],
                                           ["name" : "Delis", "code": "delis"],
                                           ["name" : "Diners", "code": "diners"],
                                           ["name" : "Dumplings", "code": "dumplings"],
                                           ["name" : "Eastern European", "code": "eastern_european"],
                                           ["name" : "Ethiopian", "code": "ethiopian"],
                                           ["name" : "Fast Food", "code": "hotdogs"],
                                           ["name" : "Filipino", "code": "filipino"],
                                           ["name" : "Fish & Chips", "code": "fishnchips"],
                                           ["name" : "Fondue", "code": "fondue"],
                                           ["name" : "Food Court", "code": "food_court"],
                                           ["name" : "Food Stands", "code": "foodstands"],
                                           ["name" : "French", "code": "french"],
                                           ["name" : "French Southwest", "code": "sud_ouest"],
                                           ["name" : "Galician", "code": "galician"],
                                           ["name" : "Gastropubs", "code": "gastropubs"],
                                           ["name" : "Georgian", "code": "georgian"],
                                           ["name" : "German", "code": "german"],
                                           ["name" : "Giblets", "code": "giblets"],
                                           ["name" : "Gluten-Free", "code": "gluten_free"],
                                           ["name" : "Greek", "code": "greek"],
                                           ["name" : "Halal", "code": "halal"],
                                           ["name" : "Hawaiian", "code": "hawaiian"],
                                           ["name" : "Heuriger", "code": "heuriger"],
                                           ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                                           ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                                           ["name" : "Hot Dogs", "code": "hotdog"],
                                           ["name" : "Hot Pot", "code": "hotpot"],
                                           ["name" : "Hungarian", "code": "hungarian"],
                                           ["name" : "Iberian", "code": "iberian"],
                                           ["name" : "Indian", "code": "indpak"],
                                           ["name" : "Indonesian", "code": "indonesian"],
                                           ["name" : "International", "code": "international"],
                                           ["name" : "Irish", "code": "irish"],
                                           ["name" : "Island Pub", "code": "island_pub"],
                                           ["name" : "Israeli", "code": "israeli"],
                                           ["name" : "Italian", "code": "italian"],
                                           ["name" : "Japanese", "code": "japanese"],
                                           ["name" : "Jewish", "code": "jewish"],
                                           ["name" : "Kebab", "code": "kebab"],
                                           ["name" : "Korean", "code": "korean"],
                                           ["name" : "Kosher", "code": "kosher"],
                                           ["name" : "Kurdish", "code": "kurdish"],
                                           ["name" : "Laos", "code": "laos"],
                                           ["name" : "Laotian", "code": "laotian"],
                                           ["name" : "Latin American", "code": "latin"],
                                           ["name" : "Live/Raw Food", "code": "raw_food"],
                                           ["name" : "Lyonnais", "code": "lyonnais"],
                                           ["name" : "Malaysian", "code": "malaysian"],
                                           ["name" : "Meatballs", "code": "meatballs"],
                                           ["name" : "Mediterranean", "code": "mediterranean"],
                                           ["name" : "Mexican", "code": "mexican"],
                                           ["name" : "Middle Eastern", "code": "mideastern"],
                                           ["name" : "Milk Bars", "code": "milkbars"],
                                           ["name" : "Modern Australian", "code": "modern_australian"],
                                           ["name" : "Modern European", "code": "modern_european"],
                                           ["name" : "Mongolian", "code": "mongolian"],
                                           ["name" : "Moroccan", "code": "moroccan"],
                                           ["name" : "New Zealand", "code": "newzealand"],
                                           ["name" : "Night Food", "code": "nightfood"],
                                           ["name" : "Norcinerie", "code": "norcinerie"],
                                           ["name" : "Open Sandwiches", "code": "opensandwiches"],
                                           ["name" : "Oriental", "code": "oriental"],
                                           ["name" : "Pakistani", "code": "pakistani"],
                                           ["name" : "Parent Cafes", "code": "eltern_cafes"],
                                           ["name" : "Parma", "code": "parma"],
                                           ["name" : "Persian/Iranian", "code": "persian"],
                                           ["name" : "Peruvian", "code": "peruvian"],
                                           ["name" : "Pita", "code": "pita"],
                                           ["name" : "Pizza", "code": "pizza"],
                                           ["name" : "Polish", "code": "polish"],
                                           ["name" : "Portuguese", "code": "portuguese"],
                                           ["name" : "Potatoes", "code": "potatoes"],
                                           ["name" : "Poutineries", "code": "poutineries"],
                                           ["name" : "Pub Food", "code": "pubfood"],
                                           ["name" : "Rice", "code": "riceshop"],
                                           ["name" : "Romanian", "code": "romanian"],
                                           ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                                           ["name" : "Rumanian", "code": "rumanian"],
                                           ["name" : "Russian", "code": "russian"],
                                           ["name" : "Salad", "code": "salad"],
                                           ["name" : "Sandwiches", "code": "sandwiches"],
                                           ["name" : "Scandinavian", "code": "scandinavian"],
                                           ["name" : "Scottish", "code": "scottish"],
                                           ["name" : "Seafood", "code": "seafood"],
                                           ["name" : "Serbo Croatian", "code": "serbocroatian"],
                                           ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                                           ["name" : "Singaporean", "code": "singaporean"],
                                           ["name" : "Slovakian", "code": "slovakian"],
                                           ["name" : "Soul Food", "code": "soulfood"],
                                           ["name" : "Soup", "code": "soup"],
                                           ["name" : "Southern", "code": "southern"],
                                           ["name" : "Spanish", "code": "spanish"],
                                           ["name" : "Steakhouses", "code": "steak"],
                                           ["name" : "Sushi Bars", "code": "sushi"],
                                           ["name" : "Swabian", "code": "swabian"],
                                           ["name" : "Swedish", "code": "swedish"],
                                           ["name" : "Swiss Food", "code": "swissfood"],
                                           ["name" : "Tabernas", "code": "tabernas"],
                                           ["name" : "Taiwanese", "code": "taiwanese"],
                                           ["name" : "Tapas Bars", "code": "tapas"],
                                           ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                                           ["name" : "Tex-Mex", "code": "tex-mex"],
                                           ["name" : "Thai", "code": "thai"],
                                           ["name" : "Traditional Norwegian", "code": "norwegian"],
                                           ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                                           ["name" : "Trattorie", "code": "trattorie"],
                                           ["name" : "Turkish", "code": "turkish"],
                                           ["name" : "Ukrainian", "code": "ukrainian"],
                                           ["name" : "Uzbek", "code": "uzbek"],
                                           ["name" : "Vegan", "code": "vegan"],
                                           ["name" : "Vegetarian", "code": "vegetarian"],
                                           ["name" : "Venison", "code": "venison"],
                                           ["name" : "Vietnamese", "code": "vietnamese"],
                                           ["name" : "Wok", "code": "wok"],
                                           ["name" : "Wraps", "code": "wraps"],
                                           ["name" : "Yugoslav", "code": "yugoslav"]]
    var filters = [String : AnyObject]()
    var switchStates = [Int:Bool]()
    
    var radiusArr: [Float?]!
    var sortArr: [String]! = ["Best Match", "Distance", "Rating"]
    var isExpandDistance = false
    var isExpandSortBy = false
    var isExpandCategory = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initControl()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initControl() {
        tableView.delegate = self
        tableView.dataSource = self
        
        radiusArr = [nil, 0.5, 1, 2.5, 30, 50]
    }
    
    @IBAction func cancelSearch(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion:  nil)
    }
    
    @IBAction func search(_ sender: UIBarButtonItem) {
        dismiss(animated: true) { 
            var categoriesSelected = [String]()
            for (row, isSelected) in self.switchStates {
                if isSelected {
                    categoriesSelected.append(self.categories[row]["code"]!)
                }
            }
            if categoriesSelected.count > 0 {
                self.filters["categories"] = categoriesSelected as AnyObject?
            } else {
                self.filters["categories"] = nil
            }
            
            self.delegate?.filtersViewController!(filtersViewController: self, didChangeValue: self.filters)
        }
    }
  
}

extension FiltersViewController: UITableViewDataSource, UITableViewDelegate, SwitchCellDelegate, ComboBoxCellDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return radiusArr.count
        case 2: return 3
        case 3: return categories.count + 1
        case 4: return 1
        default: return 0
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0: // Deal
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.delegate = self
            cell.switchBtn.isOn = filters["deal"] as? Bool ?? false
            
            return cell
        case 1: //distance
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboBoxCell") as! ComboBoxCell
            cell.delegate = self
            
            if indexPath.row == 0 {
                cell.nameLabel.text = "Auto"
            } else {
                if radiusArr[indexPath.row] == 1 {
                    cell.nameLabel.text =  String(format: "%g", radiusArr[indexPath.row]!) + " mile"
                } else {
                    cell.nameLabel.text =  String(format: "%g", radiusArr[indexPath.row]!) + " miles"
                }
            }
            
            let radiusValue = filters["radius"] as! Float?
            if !isExpandDistance {
                cell.imgView.image = UIImage(named: "arrow")
                if radiusValue == radiusArr[indexPath.row] {
                    cell.nameLabel.isHidden = false
                    cell.imgView.isHidden = false
                }
                else {
                    cell.nameLabel.isHidden = true
                    cell.imgView.isHidden = true
                }
            } else {
                cell.nameLabel.isHidden = false
                cell.imgView.isHidden = false
                if radiusValue == radiusArr[indexPath.row] {
                    cell.imgView.image = UIImage(named: "tick")
                } else {
                    cell.imgView.image = UIImage(named: "circle")
                    
                }
            }
            //separator fullwidth
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            return cell
        case 2: // sort
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComboBoxCell") as! ComboBoxCell
            cell.delegate = self

            cell.nameLabel.text = self.sortArr[indexPath.row]
            var sortVal = filters["sort"] as! Int?
            if sortVal == nil {
                sortVal = 0
            }
            if !isExpandSortBy {
                cell.imgView.image = UIImage(named: "arrow")
                if sortVal == indexPath.row {
                    cell.nameLabel.isHidden = false
                    cell.imgView.isHidden = false
                }
                else {
                    cell.nameLabel.isHidden = true
                    cell.imgView.isHidden = true
                }
            } else {
                cell.nameLabel.isHidden = false
                cell.imgView.isHidden = false
                if sortVal == indexPath.row {
                    cell.imgView.image = UIImage(named: "tick")
                } else {
                    cell.imgView.image = UIImage(named: "circle")
                    
                }
            }
            
            //separator fullwidth
            cell.layoutMargins = UIEdgeInsets.zero
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            return cell
        case 3: //category
            let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as! SwitchCell
            cell.delegate = self
            if indexPath.row != categories.count {
                cell.nameLabel.text = categories[indexPath.row]["name"]
                cell.switchBtn.isOn = switchStates[indexPath.row] ?? false
                
                //separator fullwidth
                cell.layoutMargins = UIEdgeInsets.zero
                cell.preservesSuperviewLayoutMargins = false
                cell.separatorInset = UIEdgeInsets.zero
                
                if !isExpandCategory && indexPath.row > 2 {
                    cell.nameLabel.isHidden = true
                    cell.switchBtn.isHidden = true
                } else {
                    cell.nameLabel.isHidden = false
                    cell.switchBtn.isHidden = false
                }
                return cell
            } else {
                let cell = UITableViewCell()
                cell.textLabel?.text = "See All"
                cell.textLabel?.textColor = UIColor.darkGray
                cell.textLabel?.textAlignment = .center
                return cell
            }
        default:
            let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 30))
        headerView.backgroundColor = UIColor(red: 245/255, green: 240/255, blue: 234/255, alpha: 1.0)
        
        let titleLabel = UILabel(frame: CGRect(x: 10, y: 5, width: 320, height: 30))
        titleLabel.textColor = UIColor(red: 180/255, green: 40/255, blue: 37/255, alpha: 1.0)
        
        switch section {
        case 0:
            titleLabel.text = "Deal"
        case 1:
            titleLabel.text = "Distance"
        case 2:
            titleLabel.text = "Sort By"
        case 3:
            titleLabel.text = "Category"
        default:
            return nil
        }
        
        headerView.addSubview(titleLabel)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            if !isExpandDistance {
                let radiusVal = filters["radius"] as! Float?
                if radiusVal != radiusArr[indexPath.row] {
                    return 0
                }
            }
        case 2:
            if !isExpandSortBy {
                var sortVal = 0
                if(filters["sort"] != nil) {
                    sortVal = filters["sort"] as! Int
                } else {
                    sortVal = 0
                }
                if sortVal != indexPath.row {
                    return 0
                }
            }
        case 3:
            if isExpandCategory {
                if indexPath.row > 2 && indexPath.row != categories.count {
                    return 0
                }
            }
        default:
            break
        }
        
        return 40

    }
    func switchCell(switchCell: SwitchCell, didChangeValue value: Bool) {
        let indexPath = tableView.indexPath(for: switchCell)
        if indexPath?.section == 0 {
            self.filters["deal"] = value as AnyObject?
        } else {
            switchStates[(indexPath?.row)!] = value
        }
        print(self.filters)
    }
    
    func ComboBoxCell(comboBoxCell: ComboBoxCell, didSelectValue value: UIImage) {
        print("comboBox select \(value)")
        let indexPath = tableView.indexPath(for: comboBoxCell)
        if indexPath != nil {
            if indexPath!.section == 1 {
                // Distance
                if value == UIImage(named: "circle") {
                    filters["radius"] = radiusArr![(indexPath?.row)!] as AnyObject?
                }
                isExpandDistance = !isExpandDistance
                tableView.reloadSections(NSIndexSet(index: 1) as IndexSet, with: UITableViewRowAnimation.automatic)
            } else if indexPath!.section == 2 {
                // Sort
                isExpandSortBy = !isExpandSortBy
                if value == UIImage(named: "circle") {
                    filters["sort"] = indexPath?.row as AnyObject?
                }
                tableView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.automatic)
            } else if indexPath!.section == 3 {
                
            }
        }
    }
}

