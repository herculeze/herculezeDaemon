## Account Types

- 0 : Customer

- 1 : Driver

## Account Status Codes

- -1 : Customer, email not verified

- 0 : Customer, email verified

- 1 : Driver, application pending

- 2 : Driver, application approved, no jobs completed
  
- 3 : Driver, active

- 4 : Driver, account locked

- 5 : Driver, application approved, no jobs completed, account locked

- 6 : Customer, email not verified, account locked

- 7 : Customer, email verified, account locked

## Order Status Codes

- 0 : Auction

- 1 : Auction Completed, Payment Pending

- 2 : Payment Received

- 3 : Driver en route to pickup 

- 4 : Driver arrived at pickup

- 5 : Delivery in progress

- 6 : Driver arrived at destination

- 7 : Completed

- 8 : Cancelled

## URL Status Codes

- EMAILERROR : Email already in use

- PASSERROR : Password Incorrect

- PASSMATCHERROR : Passwords do not match (password + password\_ver)

- FIELDERROR : Required field left blank
