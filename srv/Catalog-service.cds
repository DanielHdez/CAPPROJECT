using { com.dhl as dhl } from '../db/schema.cds';

service CatalogService{
entity Products as projection on dhl.Products; 
entity Suppliers as projection on dhl.Suppliers; 
// entity Car as projection on dhl.Car; 
//entity Suppliers_01 as projection on dhl.Suppliers_01; 
//entity Suppliers_02 as projection on dhl.Suppliers_02; 
}
