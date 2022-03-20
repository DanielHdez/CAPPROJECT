using { com.dhl as dhl } from '../db/schema.cds';

// service CatalogService{
// entity Products as projection on dhl.materials.Products; 
// entity Suppliers as projection on dhl.sales.Suppliers; 
// entity  Currency as projection on dhl.materials.Currencies; 
// entity DimensionUnits as projection on dhl.materials.DimensionUnits; 
// entity SalesData as projection on dhl.sales.SalesData; 
// entity Reviews as projection on dhl.materials.ProductReview; 
// entity Car as projection on dhl.Car; 
//entity Suppliers_01 as projection on dhl.Suppliers_01; 
//entity Suppliers_02 as projection on dhl.Suppliers_02; 

define service CatalogService {

    entity Products          as
        select from dhl.reports.Products {
            ID,
            Name          as ProductName     @mandatory,
            Description                      @mandatory,
            ImageUrl,
            ReleaseDate,
            DiscontinuedDate,
            Price                            @mandatory,
            Height,
            Width,
            Depth,
            Quantity                         @(
                mandatory,
                assert.range : [
                    0.00,
                    20.00
                ]
            ),
            UnitOfMeasure as ToUnitOfMeasure @mandatory,
            Currency      as ToCurrency      @mandatory,
            Currency.ID   as CurrencyId,
            Category      as ToCategory      @mandatory,
            Category.ID   as CategoryId,
            Category.Name as Category        @readonly,
            DimensionUnit as ToDimensionUnit,
            SalesData,
            Supplier,
            Reviews,
            Rating,
            StockAvailability,
            ToStockAvailibilty
        };

    @readonly
    entity Supplier          as
        select from dhl.sales.Suppliers {
            ID,
            Name,
            Email,
            Phone,
            Fax,
            Product as ToProduct
        };

    entity Reviews           as
        select from dhl.materials.ProductReview {
            ID,
            Name,
            Rating,
            Comment,
            createdAt,
            Product as ToProduct
        };

    @readonly
    entity SalesData         as
        select from dhl.sales.SalesData {
            ID,
            DeliveryDate,
            Revenue,
            Currency.ID               as CurrencyKey,
            DeliveryMonth.ID          as DeliveryMonthId,
            DeliveryMonth.Description as DeliveryMonth,
            Product                   as ToProduct
        };

    @readonly
    entity StockAvailability as
        select from dhl.materials.StockAvailability{
            ID,
            Description,
            Product as ToProduct
        };

    @readonly
    entity VH_Categories     as
        select from dhl.materials.Categories {
            ID   as Code,
            Name as Text
        };

    @readonly
    entity VH_Currencies     as
        select from dhl.materials.Currencies {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_UnitOfMeasure  as
        select from dhl.materials.UnitOfMeasures {
            ID          as Code,
            Description as Text
        };

    @readonly
    entity VH_DimensionUnits as
        select
            ID          as Code,
            Description as Text
        from dhl.materials.DimensionUnits;
}

define service MyService {

    entity SuppliersProduct as
        select from dhl.materials.Products[Name = 'Bread'
    ]{
        * ,
        Name,
        Description,
        Supplier.Address
    }
    where
        Supplier.Address.PostalCode = 98074;

    entity SupliersToSales  as
        select
            Supplier.Email,
            Category.Name,
            SalesData.Currency.ID,
            SalesData.Currency.Description
        from dhl.materials.Products;

    entity EntityInfix      as
        select Supplier[Name = 'Exotic Liquids'].Phone from dhl.materials.Products
        where
            Products.Name = 'Bread';

    entity EntityJoin       as
        select Phone from dhl.materials.Products
        left join dhl.sales.Suppliers as supp
            on(
                supp.ID = Products.Supplier.ID
            )
            and supp.Name = 'Exotic Liquids'
        where
            Products.Name = 'Bread';
}

define service Reports {
    entity AverageRating as projection on dhl.reports.AverageRating;

    entity EntityCasting as
        select
            cast(
                Price as      Integer
            )     as Price,
            Price as Price2 : Integer
        from dhl.materials.Products;

    entity EntityExists  as
        select from dhl.materials.Products {
            Name
        }
        where
            exists Supplier[Name = 'Exotic Liquids'];
};



