namespace com.dhl;

using {
    cuid,
    managed
} from '@sap/cds/common';

type name : String(50);

type Address {
    Street     : String;
    City       : String;
    State      : String(2);
    PostalCode : String(5);
    Country    : String(3);
};

type Dec : Decimal(16, 2);

context materials {

    entity Products : cuid, managed {
        // key ID               : UUID;
        // Name             : String default 'NoName';
        Name             : localized String not null;
        Description      : localized String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        // CreationDate     : DateTime default CURRENT_DATE;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        //       Supplier_ID      : UUID;
        Supplier     : Association to sales.Suppliers;
        UnitOfMeasure    : Association to UnitOfMeasures;
        Currency         : Association to Currencies;
        DimensionUnit    : Association to DimensionUnits;
        Category         : Association to Categories;
        SalesData        : Association to many sales.SalesData
                               on SalesData.Product = $self;
        Reviews          : Association to many ProductReview
                               on Reviews.Product = $self;

    };

    entity Categories {
        key ID   : String(1);
            Name : localized String;
    };


    entity StockAvailability {
        key ID          : Integer;
            Description : String;
            Product     : Association to Products;
    };

    entity Currencies {
        key ID          : String(3);
            Description : localized String;
    };

    entity UnitOfMeasures {
        key ID          : String(3);
            Description : String;

    }

    entity DimensionUnits {
        key ID          : String(3);
            Description : localized String;

    }

    entity ProductReview : cuid, managed {
        key Name    : String;
            Rating  : Integer;
            Comment : String;
            Product : Association to Products;
    }


    entity SelProducts   as select from Products;
    entity ProjProducts  as projection on Products;

    entity ProjProducts2 as projection on Products {
        *
    };

    entity ProjProducts3 as projection on Products {
        ReleaseDate,
        Name
    };

    // entity ParamProducts(pName : String)     as
    //     select from Products {
    //         Name,
    //         Price,
    //         Quantity
    //     }
    //     where
    //         Name = : pName;

    // entity ProjParamProducts(pName : String) as projection on Products where Name = : pName;

    extend Products with {
        PriceCondition     : String(2);
        PriceDetermination : String(3);
    };
} //Fin del context material

// entity Course {
//     key ID      : UUID;
//         Student : Association to many StudentCourse
//                       on Student.Course = $self;
// }

// entity Student {
//     key ID     : UUID;
//         Course : Association to many StudentCourse
//                      on Course.Student = $self;
// }

// entity StudentCourse {
//     key ID      : UUID;
//         Student : Association to Student;
//         Course  : Association to Course;
// }


context sales {

    entity Orders : cuid {
        Date     : Date;
        Customer : String;
        Item     : Composition of many OrderItems
                       on Item.Order = $self;
    };

    entity OrderItems : cuid {
        Order    : Association to Orders;
        Product  : Association to materials.Products;
        Quantity : Integer;
    }

    entity SalesData : cuid {
        DeliveryDate  : Date;
        Revenue       : Decimal(16, 2);
        Product       : Association to materials.Products;
        Currency      : Association to materials.Currencies;
        DeliveryMonth : Association to sales.Months
    }


    entity Suppliers : cuid, managed {
        Name       : type of materials.Products : Name; //String;   //Tomamos el dato del campo name de product
        Address    : Address;
        // Street     : String;
        // City       : String;
        // State      : String;
        // PostalCode : String(5);
        // Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
        Product    : Association to many materials.Products
                                    on Product.Supplier = $self;
    };

    // entity Suppliers_01 {
    //     key Id      : UUID;
    //         name    : String;
    //         Address : Address;
    //         email   : String;
    //         Phone   : String;
    //         Fax     : String;
    // };

    // entity Suppliers_02 {
    //     key Id             : UUID;
    //         name           : String;
    //         Address {
    //             Street     : String;
    //             City       : String;
    //             State      : String;
    //             PostalCode : String(5);
    //             Country    : String(3);
    //         }
    //         Email          : String;
    //         Phone          : String;
    //         Fax            : String;
    // };

    entity SelProducts  as
        select from materials.Products {
            *
        };

    entity SelProducts2 as
        select from materials.Products {
            Name,
            Price,
            Quantity
        };

    entity SelProducts3 as
        select from materials.Products
        left join materials.ProductReview
            on Products.Name = ProductReview.Name
        {
            Rating,
            Products.Name,
            sum(Price) as TotalPrice
        }
        group by
            Rating,
            Products.Name
        order by
            Rating;


    entity Months {
        key ID               : String(3);
            Description      : localized String;
            ShortDescription : localized String(3);
    }
}

context reports {

    entity AverageRating as
        select from dhl.materials.ProductReview {
            Product.ID  as ProductId,
            avg(Rating) as AverageRating : Decimal(16, 2)
        }
        group by
            Product.ID;

    entity Products      as
        select from dhl.materials.Products
        mixin {
            ToStockAvailibilty : Association to dhl.materials.StockAvailability
                                     on ToStockAvailibilty.ID = $projection.StockAvailability;
            ToAverageRating    : Association to AverageRating
                                     on ToAverageRating.ProductId = ID;
        }

        into {
            *,
            ToAverageRating.AverageRating as Rating,
            case
                when
                    Quantity >= 8
                then
                    3
                when
                    Quantity > 0
                then
                    2
                else
                    1
            end                           as StockAvailability : Integer,
            ToStockAvailibilty
        }
}
