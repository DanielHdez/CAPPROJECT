using { com.dhl as dhl } from '../db/schema.cds';

service CustomerService{
entity CustomerSrv as projection on dhl.Customer; 
}
