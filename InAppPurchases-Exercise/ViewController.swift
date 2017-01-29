

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
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.indicator.stopAnimating()
        self.tableView.isHidden = false
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
        
        return 3
        
        
    }
    
    //Cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductTableViewCell
        
        cell.productName.text = "Cras mattis consectetur purus sit amet fermentum."
        cell.productDescription.text = "Maecenas faucibus mollis interdum. Sed posuere consectetur est at lobortis. Integer posuere erat a ante venenatis dapibus posuere velit aliquet."
        
        cell.productStatus.index = indexPath
        cell.productStatus.addTarget(self, action: #selector(self.didTapCellButton(sender:)), for: UIControlEvents.touchUpInside)
        
        return cell
        
        
    }
    
    
    
    
}

