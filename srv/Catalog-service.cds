using { com.dhl as dhl } from '../db/schema.cds';

service CatalogService{
entity Products as projection on dhl.Products; 
entity Suppliers as projection on dhl.Suppliers; 
entity  Currency as projection on dhl.Currency; 
entity DimensionUnits as projection on dhl.DimensionUnits; 
entity SalesData as projection on dhl.SalesData; 
entity Reviews as projection on dhl.ProductReview; 
// entity Car as projection on dhl.Car; 
//entity Suppliers_01 as projection on dhl.Suppliers_01; 
//entity Suppliers_02 as projection on dhl.Suppliers_02; 
}
