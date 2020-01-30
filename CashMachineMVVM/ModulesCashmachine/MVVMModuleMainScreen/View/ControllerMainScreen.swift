//
//  ViewController.swift
//  Viper
//
//  Created by Serg on 13/04/2019.
//  Copyright © 2019 Serg. All rights reserved.
//

import UIKit

class ControllerMainScreen: UIViewController {
    
    private var viewModel: MainScreenViewModelProtocol
    
    var registeredDigits: Observable<RegisteredDigits> = Observable<RegisteredDigits>(observable: RegisteredDigits(name: "", code: "", priceCurrency: "", priceValue: 0, tax: TaxMode(rawValue: 0.1) ?? TaxMode(rawValue: 100)!))
    
    var scunnedDigits: Observable<ScunnedDigits> = Observable<ScunnedDigits>(observable: ScunnedDigits(code: "", quantity: 0))
    
    private weak var scroll: UIScrollView!
    
    private var arrayConstraints = [NSLayoutConstraint]()
   
    private weak var taxModeSegment: UISegmentedControl!
    
    private weak var name: UITextField!
    private weak var codeRegist: UITextField!
    private weak var currency: UITextField!
    private weak var value: UITextField!
    private weak var codeScan: UITextField!
    private weak var quantity: UITextField!
    
    private weak var labelName: UILabel!
    private weak var labelCodeRegist: UILabel!
    private weak var labelCurrencyUnit: UILabel!
    private weak var labelValue: UILabel!
    private weak var labelTaxMode: UILabel!
    private weak var labelCodeScan: UILabel!
    private weak var labelQuantity: UILabel!
    
    private weak var register: UIButton!
    private weak var scan: UIButton!
    private weak var pay: UIButton!
    
    private weak var widthReg: NSLayoutConstraint!
    private weak var widthCom: NSLayoutConstraint!
    
    private weak var tableViewButton: UIButton!
    
    private weak var tableView: UITableView!
    
    private weak var bill: UITextView!
    
    init(viewModel: MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        dataBindingWithViewModel()
    }
    
    //MARK: init for IB
    required init?(coder aDecoder: NSCoder) {
        print(#function)
        self.viewModel = DependenceProvider.resolve()
        super.init(coder: aDecoder)
        dataBindingWithViewModel()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print(#function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()  // Liskov
        print(#function)
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layout()

        viewModel.state.bind { [unowned self] vmState in
            switch vmState {
            case .initial: print("Initial state")
            case .printBill: self.displayBill()
            case .errorHappend: self.displayError()
            case .chosenShowableItems: self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(#function)
        if view.traitCollection.horizontalSizeClass == .regular {
            self.widthReg.constant = 300
        } else {
            self.widthReg.constant = 150
        }
    }
    
    private func clearRegistableText() {
        name.text = ""
        codeRegist.text = ""
        currency.text = ""
        value.text = ""
    }
    
    private func cleanScanText() {
        codeScan.text = ""
        quantity.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //navigationController?.setToolbarHidden(true, animated: true)
    }
}

extension ControllerMainScreen {
    
    override var navigationItem: UINavigationItem {
        let navItem = UINavigationItem(title: "ControllerMainScreen")
        let editBarButton = self.editButtonItem
        //let editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editBarAction(sender:)))
        editBarButton.target = self
        editBarButton.action = #selector(editBarAction(sender:))
        navItem.rightBarButtonItem = editBarButton
        return navItem
    }
    
    func dataBindingWithViewModel() {
        self.registeredDigits.bind { [unowned self] item in
            // a verify, (whithout it) otherwise viewModel performs registerItem with empty values
            if item.code == "" {
                return
            }
            self.viewModel.registerItem(name: item.name, code: item.code, priceCurrency: item.priceCurrency, priceValue: item.priceValue, tax: item.tax)
        }
        self.scunnedDigits.bind { [unowned self] item in
            if item.code == "" {
                return
            }
            self.viewModel.scanItem(code: item.code, quantity: item.quantity)
        }
        
    }
}


extension ControllerMainScreen {
    private func layout() {
        
        let scrollView = CustomScr(frame: CGRect.zero) {
            self.view.endEditing(true)
        }
       
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        let topScroll = scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let leftScroll = scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let rightScroll = scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let bottomScroll = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        arrayConstraints.append(contentsOf: [topScroll, leftScroll, rightScroll, bottomScroll])
        scroll = scrollView
        
        let fieldName = AdjustingField()
        
        fieldName.placeholder = "Name"
        fieldName.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldName)
        let topFieldName = fieldName.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10)
        let leftFieldName = fieldName.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10)
        let widthFieldName = fieldName.widthAnchor.constraint(equalToConstant: 150)
        let heightFieldName = fieldName.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topFieldName, leftFieldName, widthFieldName, heightFieldName])
        name = fieldName
        
        let fieldCodeRegist = AdjustingField()
        fieldCodeRegist.placeholder = "Registration code"
        fieldCodeRegist.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldCodeRegist)
        let topCodeRegist = fieldCodeRegist.topAnchor.constraint(equalTo: fieldName.bottomAnchor, constant: 10)
        let centerXCodeRegist = fieldCodeRegist.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthCodeRegist = fieldCodeRegist.widthAnchor.constraint(equalToConstant: 150)
        let heightFieldCodeRegist = fieldCodeRegist.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topCodeRegist, centerXCodeRegist, widthCodeRegist, heightFieldCodeRegist])
        codeRegist = fieldCodeRegist
        
        let fieldCurrency = AdjustingField()
        fieldCurrency.placeholder = "Currency"
        fieldCurrency.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldCurrency)
        
        let topCurrency = fieldCurrency.topAnchor.constraint(equalTo: fieldCodeRegist.bottomAnchor, constant: 10)
        let centerXCurrency = fieldCurrency.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthCurrency = fieldCurrency.widthAnchor.constraint(equalToConstant: 150)
        self.widthReg = widthCurrency
        
        let heightFieldCurrency = fieldCurrency.heightAnchor.constraint(equalToConstant: 40)
       
        
        arrayConstraints.append(contentsOf: [topCurrency, centerXCurrency, widthCurrency, heightFieldCurrency])
        currency = fieldCurrency
        
        let fieldValue = AdjustingField()
        fieldValue.placeholder = "Value"
        fieldValue.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldValue)
        let topValue = fieldValue.topAnchor.constraint(equalTo: fieldCurrency.bottomAnchor, constant: 10)
        let centerXValue = fieldValue.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthValue = fieldValue.widthAnchor.constraint(equalToConstant: 150)
        let heightFieldValue = fieldValue.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topValue, centerXValue, widthValue, heightFieldValue])
        value = fieldValue
        
        let segmentTax = UISegmentedControl()
        segmentTax.layer.borderWidth = 1
        segmentTax.layer.cornerRadius = 5
        segmentTax.insertSegment(withTitle: "0.1", at: 0, animated: true)
        segmentTax.insertSegment(withTitle: "100", at: 1, animated: true)
        segmentTax.selectedSegmentIndex = 0
        segmentTax.setEnabled(true, forSegmentAt: 0)
        segmentTax.tintColor = .white
        segmentTax.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(segmentTax)
        let topTaxMode = segmentTax.topAnchor.constraint(equalTo: fieldValue.bottomAnchor, constant: 10)
        let centerXTaxMode = segmentTax.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthTaxMode = segmentTax.widthAnchor.constraint(equalToConstant: 150)
        let heightFieldTaxMode = segmentTax.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topTaxMode, centerXTaxMode, widthTaxMode, heightFieldTaxMode])
        taxModeSegment = segmentTax
        
        let fieldCodeScan = AdjustingField()
        fieldCodeScan.placeholder = "Scannable code"
        fieldCodeScan.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldCodeScan)
        let topCodeScan = fieldCodeScan.topAnchor.constraint(equalTo: segmentTax.bottomAnchor, constant: 10)
        let centerXCodeScan = fieldCodeScan.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthCodeScan = fieldCodeScan.widthAnchor.constraint(equalToConstant: 150)
        let heightCodeScan = fieldCodeScan.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topCodeScan, centerXCodeScan, widthCodeScan, heightCodeScan])
        codeScan = fieldCodeScan
        
        let fieldQuantity = AdjustingField()
        fieldQuantity.placeholder = "Quantity"
        fieldQuantity.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(fieldQuantity)
        
        let topQuantity = fieldQuantity.topAnchor.constraint(equalTo: fieldCodeScan.bottomAnchor, constant: 10)
        let centerXQuantity = fieldQuantity.centerXAnchor.constraint(equalTo: fieldName.centerXAnchor)
        let widthQuantity = fieldQuantity.widthAnchor.constraint(greaterThanOrEqualToConstant: 150)
        let heightQuantity = fieldQuantity.heightAnchor.constraint(equalToConstant: 40)
        arrayConstraints.append(contentsOf: [topQuantity, centerXQuantity, widthQuantity, heightQuantity])
        quantity = fieldQuantity
        
        let itemName = AdjustingLabel()
        itemName.text = "Name"
        itemName.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemName)
        let topName = itemName.topAnchor.constraint(equalTo: fieldName.topAnchor)
        let leftName = itemName.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 10)
        arrayConstraints.append(contentsOf: [topName, leftName])
        labelName = itemName
        
        let itemCodeRegist = AdjustingLabel()
        itemCodeRegist.text = "Registered code"
        itemCodeRegist.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemCodeRegist)
        let topCodeRegister = itemCodeRegist.topAnchor.constraint(equalTo: fieldCodeRegist.topAnchor)
        let leadingCodeRegister = itemCodeRegist.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [leadingCodeRegister, topCodeRegister])
        labelCodeRegist = itemCodeRegist
        
        let itemCurrencyUnit = AdjustingLabel()
        itemCurrencyUnit.text = "Currency"
        itemCurrencyUnit.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemCurrencyUnit)
        let topCurrencyUnit = itemCurrencyUnit.topAnchor.constraint(equalTo: fieldCurrency.topAnchor)
        let leadingCurrencyUnit = itemCurrencyUnit.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [topCurrencyUnit, leadingCurrencyUnit])
        labelCurrencyUnit = itemCurrencyUnit
        
        let itemValue = AdjustingLabel()
        itemValue.text = "Value"
        itemValue.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemValue)
        let topItemValue = itemValue.topAnchor.constraint(equalTo: fieldValue.topAnchor)
        let leadingItemValue = itemValue.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [topItemValue, leadingItemValue])
        labelValue = itemValue
        
        let itemTaxMode = AdjustingLabel()
        itemTaxMode.text = "Tax mode"
        itemTaxMode.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemTaxMode)
        let topItemTaxMode = itemTaxMode.topAnchor.constraint(equalTo: segmentTax.topAnchor)
        let leadingItemTaxMode = itemTaxMode.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [topItemTaxMode, leadingItemTaxMode])
        labelTaxMode = itemTaxMode
        
        let itemCodeScan = AdjustingLabel()
        itemCodeScan.text = "Scannable code"
        itemCodeScan.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemCodeScan)
        let topItemCodeScan = itemCodeScan.topAnchor.constraint(equalTo: fieldCodeScan.topAnchor)
        let leadingItemCodeScan = itemCodeScan.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [topItemCodeScan, leadingItemCodeScan])
        labelCodeScan = itemCodeScan
        
        let itemQuantity = AdjustingLabel()
        itemQuantity.text = "Quantity"
        itemQuantity.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemQuantity)
        let topItemQuantity = itemQuantity.topAnchor.constraint(equalTo: fieldQuantity.topAnchor)
        let leadingItemQuantity = itemQuantity.leadingAnchor.constraint(equalTo: itemName.leadingAnchor)
        arrayConstraints.append(contentsOf: [topItemQuantity, leadingItemQuantity])
        labelQuantity = itemQuantity
        
        
        let buttonRegist = RoundedButton()
        buttonRegist.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonRegist)
        buttonRegist.setTitle("Register", for: .normal)
        let widthRegist = buttonRegist.widthAnchor.constraint(equalToConstant: 80)
        let topRegist = buttonRegist.topAnchor.constraint(equalTo: itemQuantity.bottomAnchor, constant: 30)
        let rightRegist = buttonRegist.trailingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: -20)
        arrayConstraints.append(contentsOf: [widthRegist, topRegist, rightRegist])
        register = buttonRegist
        register.addTarget(self, action: #selector(buttonRegistAction), for: .touchUpInside)
        
        
        let buttonScan = RoundedButton()
        buttonScan.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonScan)
        buttonScan.setTitle("Scan", for: .normal)
        let widthScan = buttonScan.widthAnchor.constraint(equalToConstant: 80)
        let topScan = buttonScan.topAnchor.constraint(equalTo: buttonRegist.topAnchor)
        let leftScan = buttonScan.leadingAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 20)
        arrayConstraints.append(contentsOf: [widthScan, topScan, leftScan])
        scan = buttonScan
        scan.addTarget(self, action: #selector(buttonScanAction), for: .touchUpInside)
        
        
        let buttonPay = RoundedButton()
        buttonPay.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(buttonPay)
        buttonPay.setTitle("Pay", for: .normal)
        let topPay = buttonPay.topAnchor.constraint(equalTo: scan.bottomAnchor, constant: 50)
        let widthPay = buttonPay.widthAnchor.constraint(equalToConstant: 80)
        let centerXPay = buttonPay.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        arrayConstraints.append(contentsOf: [topPay, widthPay, centerXPay])
        pay = buttonPay
        pay.addTarget(self, action: #selector(buttonPayAction), for: .touchUpInside)
        
        let table = UITableView()
        table.layer.borderWidth = 1
        table.layer.cornerRadius = 5
        table.register(GoodsTableViewCell.self, forCellReuseIdentifier: "GoodsTableViewCell")
        table.dataSource = self
        table.delegate = self
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)
        let topTable = table.topAnchor.constraint(equalTo: buttonPay.bottomAnchor, constant: 30)
        let leadingTable = table.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingTable = table.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let heightTable = table.heightAnchor.constraint(equalToConstant: 400)
        
        tableView = table
        
        arrayConstraints.append(contentsOf: [topTable, leadingTable, trailingTable, heightTable])
        
        let itemTextView = UITextView()
        itemTextView.backgroundColor = .white
        itemTextView.textAlignment = .left
        
        itemTextView.font = UIFont.init(name: "Arial", size: 28) ?? .systemFont(ofSize: 20)
        itemTextView.textColor = UIColor.black
        itemTextView.layer.borderWidth = 1
        itemTextView.layer.cornerRadius = 5
        itemTextView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        itemTextView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(itemTextView)
        let topTextView = itemTextView.topAnchor.constraint(equalTo: table.bottomAnchor, constant: 30)
        let leadingTextView = itemTextView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailingTextView = itemTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let heightTextView = itemTextView.heightAnchor.constraint(equalToConstant: 400)
        let bottonTextView = itemTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        arrayConstraints.append(contentsOf: [topTextView, leadingTextView, trailingTextView, heightTextView, bottonTextView])
        bill = itemTextView
        
        NSLayoutConstraint.activate(arrayConstraints)
    }
}


extension ControllerMainScreen {
    @objc private func buttonRegistAction() {
        
        if name.text! == "" {
            bill.text = "Пустое поле name"
            return
        }
        
        if codeRegist.text! == "" {
            bill.text = "Пустое поле code"
            return
        }
        
        if currency.text! == "" {
            bill.text = "Пустое поле currency"
            return
        }
        
        guard let name = name.text else {
            return
        }
        guard let code = codeRegist.text else {
            return
        }
        guard let currency = currency.text else {
            return
        }
        
        guard let value = Double(value.text!) else {
            bill.text = "В поле value введите число"
            return
        }
        
        switch taxModeSegment.selectedSegmentIndex {
        case 0:
            bill.text = ""
            registeredDigits.observable = RegisteredDigits(name: name, code: code, priceCurrency: currency, priceValue: value, tax: .NDS)
            clearRegistableText()
        case 1:
            bill.text = ""
            registeredDigits.observable = RegisteredDigits(name: name, code: code, priceCurrency: currency, priceValue: value, tax: .Excise)
            clearRegistableText()
        default:
            bill.text = "Выберите режим налогообложения (0.1 для НДС или 100 для акциза)"
        }
        
    }

    @objc private func buttonScanAction() {
        if codeScan.text! == "" {
            bill.text = "Пустое поле code"
            return
        }
        
        guard let code = codeScan.text else {
            return
        }
        guard let quantity = Double(quantity.text!) else {
            bill.text = "В поле quantity введите число"
            return
        }
        bill.text = ""
        scunnedDigits.observable = ScunnedDigits(code: code, quantity: quantity)
            cleanScanText()
    }
    
    @objc private func buttonPayAction() {
        viewModel.pay()
    }
    
    @objc private func editBarAction(sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
        sender.title = (self.tableView.isEditing ? "Done" : "Edit")
    }
}

extension ControllerMainScreen {
    func displayBill() {
        bill.text = viewModel.readyBill
    }
    
    func displayError() {
        let errorMessage = viewModel.errorHappened
        let alert = UIAlertController(title: "Wrong format", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

extension ControllerMainScreen: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows() 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GoodsTableViewCell", for: indexPath) as? GoodsTableViewCell
        
        guard let tableViewCell = cell else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.removeScannedItems(at: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        if viewModel.numberOfRows() == 1 { return }
        viewModel.moveRow(at: sourceIndexPath.row, to: destinationIndexPath.row)
    }
}
