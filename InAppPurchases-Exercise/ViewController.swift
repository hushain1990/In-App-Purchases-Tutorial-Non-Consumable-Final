

import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Hide all lines
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: CGPoint(), size: CGSize.init(width: UIScreen.main.bounds.size.width, height: 0.0001)))
        
        
        //First thing we need to show the product which we loaded from iTunes connect in order for us to buy it
        
        //In the previous video we used post notification whenever the products are done loading from the server
        
        //Let's add an observer so we get notifed whenever the products get loaded
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.SKProductsDidLoadFromiTunes), name: NSNotification.Name.init("SKProductsHaveLoaded"), object: nil)
        
        
        
        //We need also to call the function anyway when the view did load in case the products got loaded before our oberver is added
        
        SKProductsDidLoadFromiTunes()
    }
    
    
    func SKProductsDidLoadFromiTunes(){
        
        
        //Now we need to update the table since we have the products ready
        
        //We need to use the main thread when updating the UI
        
        DispatchQueue.main.async {
            
            self.indicator.stopAnimating()
            self.tableView.isHidden = false
            
            self.tableView.reloadData()
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    
    
    //Selector from cell button (Unlock button)
    
    
    func didTapCellButton(sender:CustomButton){
        
        let index = sender.index
        
        let product = StoreManager.shared.productsFromStore[index!.row]
        
        StoreManager.shared.buy(product: product)
        
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    // Cell Height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 165
        
    }
    
    //Number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
    //Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //Let's feed our table with the number of products
        return StoreManager.shared.productsFromStore.count
        
        
    }
    
    //Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let product  = StoreManager.shared.productsFromStore[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        cell.productName.text = product.localizedTitle
        cell.productDescription.text = product.localizedDescription
        
        
        //You should always use NumberFormatter for the price in order to show the correct price currency
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = product.priceLocale
        
        
        cell.productPrice.text = formatter.string(from: product.price)
        
        cell.productStatus.index = indexPath
        cell.productStatus.addTarget(self, action: #selector(self.didTapCellButton(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
        
    }
    
    
    
    
}

