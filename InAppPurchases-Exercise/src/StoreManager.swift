//
//  StoreManager.swift
//  InAppPurchases-Exercise
//
//  Created by Jad Habal on 2017-01-28.
//  Copyright © 2017 Jadhabal. All rights reserved.
//

import Foundation
import StoreKit


class StoreManager: NSObject {

    
    //Let's cearte a shared object so we can access our methods from anywhere in the app
    //Also this class should extend NSObject so we can make it as the delegate for our StoreKit
    
    /** This is a shared object of the StoreManager and you should only access their methods throgh the shared object */
    
    static var shared:StoreManager = {
       return StoreManager()
    }()
    
    
    
    //Let's create an array that will hold all our SKProducts receieved from the store after the request
    
    var productsFromStore = [SKProduct]()
    
    
    
    //Let's create an array to hold our productsID
    
    let purchasableProductsIds = ["super_credits_1000"] //For now we only have one product
    
    
    
    //Let's create our first call method 
    
    func setup(){
        
        //In order to display the products for the user, the first thing we need to is to request our SKProduct from the store so we can show the product in our app and make it available for the user to purchase.
        
        
    }
    
    
    //Create a function load our products when the app launches and prepare them for us
    // 1- Request products by product id from the store
    func requestProducts(ids:Set<String>){
        
        //Before we make any payment we need to check if the user can make payments
        
        if SKPaymentQueue.canMakePayments(){
            
            //Create the request which we will send to Store
            //Note that we can request more than one preoduct at once
            let request = SKProductsRequest(productIdentifiers: ids)
            
            //Now we need to become the delegate for the Request so we can get responses
            request.delegate = self
            request.start()
            
            
        }else{
            
            print("User can't make payments from this account")
        }
        
    }
    
}


//Now in order to receive the calls you need to implement the delegate methods of SKProductsRequestDelegate

extension StoreManager:SKProductsRequestDelegate{
    
    
    //This method will be called when ever the request finished processing on the Store
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
        //In the response there are the products SKProduct we requested in the request
        
        let products = response.products 
        
        if products.count > 0{
        
            //Loop through each product
            for product in products{
                
                //And add it to our array for later use
                self.productsFromStore.append(product)
            }
            
            
        }else{
            
            print("Products now found")
        }
        
        
        
        //We can also check to see if we have sent wrong products ids
        
        let invalidProductsIDs = response.invalidProductIdentifiers
        
        for id in invalidProductsIDs{
            
            print("Wrong product id: ",id)
        }
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        
        print("error requesting products from the store",error.localizedDescription)
        
    }
    
    
}






























//Let's impelement StoreKit delegate methods

extension StoreManager:SKPaymentTransactionObserver{
    
    
    //This method will be called whenever there is update from the store about the product transaction
    //Even after resatrting the app and open it again you will still get this method called if there is a pending transaction
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
    
        //As you can see there are transactions array that we need to loop through and check for the transactions status
        
        for transaction in transactions{
            
            
            switch transaction.transactionState {
            case .purchased:
                self.transactionCompleted(trnasaction: transaction)
            
            case .failed:
                break
                
                
            case .restored:
                
                break
            case .deferred,.purchasing:
                
                print("pending")
                
           
            }
            
        }
        
        
    }
    
    
    
    //Now let's create seperated method for each state so we can handle each state separately
    
    
    func transactionCompleted(trnasaction:SKPaymentTransaction){
        
        
    }
    
    func transactionFailed(trnasaction:SKPaymentTransaction){
        
        
    }
    
    func transactionRestored(trnasaction:SKPaymentTransaction){
        
        
    }
}





























