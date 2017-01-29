

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
        
        
        //This way whenever the products gets loaded we get a notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.SKProductsDidLoadFromStore), name: NSNotification.Name.init("SKProductsHaveLoaded"), object: nil)
        
        //Let's call the SKProductsDidLoadFromStore anyway when the viewDidload in case the products are loaded before we get here
        
        self.SKProductsDidLoadFromStore()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
           }
    
    
    func SKProductsDidLoadFromStore(){
        
       //Now we want to update the tableview after we have our products
        
        //We should update it inside a Dispatch closure on the main thread
        
        DispatchQueue.main.async {
        
            self.indicator.stopAnimating()
            self.tableView.isHidden = false
    
            
            self.tableView.reloadData()
        }
        
    }
    
    
    
    //Selector from cell button (Unlock button)
    
    
    func didTapCellButton(sender:CustomButton){
        
        let index = sender.index
        
        
        
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
        
        //Let's feed our tableView with number of loaded products
        return StoreManager.shared.productsFromStore.count
        
        
    }
    
    //Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let product = StoreManager.shared.productsFromStore[indexPath.row]
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        cell.productName.text = product.localizedTitle
        cell.productDescription.text = product.localizedDescription
        
        cell.productStatus.index = indexPath
        cell.productStatus.addTarget(self, action: #selector(self.didTapCellButton(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
        
    }
    
    
    
    
}

