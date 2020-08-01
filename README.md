# WineShop example: Order Management Using Blockchain

## Users/Contracts -

 - Customer
 - Store
 - Shipping
 
 ## Main Functionalities -
 
 ### Customer:
 
 - Can add item to cart.
 - Can checkout/pay.
 - Can delete item from cart. 
 
 ### Shop:
 
 - Can add a wine bottle into the shop.
 - Can provide wine details to customers.
 - Can provide a cutomer order's delivery date.
 - Remove an item from the shop.
 
 ### Shipping:
 
 - Can update status.
 
 ## Running the project -

Clone the repository, and go inside the project folder:

 - `npm install truffle`
 - `npm install @truffle/hdwallet-provider`
 - Install Ganache application from: https://www.trufflesuite.com/ganache 
 - Create an Ethereum workspace in Ganache.
 - Link the project's truffle.js to the workspace.
 - Modify network properties in truffle.js based on the Ganache workspace.
 - Compile and migrate contracts to the Ganache network:
               `truffle compile`
               `truffle migrate`
 - Open up Truffle console and create transactions from there.
 
 ## Additional Documentation -
 
 - Truffle documentation: https://www.trufflesuite.com/docs/truffle/overview
 - Ganache documentation: https://www.trufflesuite.com/docs/ganache/overview
  
