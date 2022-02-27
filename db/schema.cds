namespace com.dhl;

//type Name : String(20);

// type Address {
//     Street     : String;
//     City       : String;
//     State      : String;
//     PostalCode : String(5);
//     Country    : String(3);

// }

// type EmailAdress_01 : array of {
//     kind  : String;
//     email : String;
// }

// type EmailAdress_02 {
//     kind  : String;
//     email : String;
// }

// entity Emails { //Las tres columnas representan lo mimsmo
//     email_01  :      EmailAdress_01;
//     email_02  : many EmailAdress_02;
//     email_03  : many {
//         kind  :      String;
//         email :      String;
//     }
// }

// type Gender : String enum {
//     male;
//     female
// }

// entity Order {
//     ClientGender : Gender;
//     Status       : Integer enum {
//         submitted = 1;
//         Fulliller = 2;
//         Shipped   = 3;
//         Cancel    = -1;
//     };
//     priority     : String @assert.range enum {
//         Hight;
//         Medium;
//         Low;
//     }
// }


//Comenta     Ctrl+K+C
//Descomentar Ctrl+C+U

// entity Car {
//     ID                 : UUID;
//     Name               : String;
//     virtual discount_1 : Decimal;
//     //Si queremos que ademas se pueda escribir en el campo virtual desde el cliente del servicio 
//     @Core.Computed : false
//     virtual discount_2 : Decimal;
}

entity Products {
    key ID               : UUID;
        // Name             : String default 'NoName';
        Name             : String not null;
        Description      : String;
        ImageUrl         : String;
        ReleaseDate      : DateTime default $now;
        // CreationDate     : DateTime default CURRENT_DATE;
        DiscontinuedDate : DateTime;
        Price            : Decimal(16, 2);
        Height           : type of Price; //Decimal(16, 2);
        Width            : Decimal(16, 2);
        Depth            : Decimal(16, 2);
        Quantity         : Decimal(16, 2);
        Supplier_ID      : UUID;
};

entity Suppliers {
    key ID         : UUID;
        Name       : type of Products : Name; //String;   //Tomamos el dato del campo name de product
        Street     : String;
        City       : String;
        State      : String;
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
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

entity StockAvility {
    key ID          : Integer;
        Description : String;
};

entity Currency {
    key ID          : String(3);
        Description : String;
};

entity UnitOfMesurejection {
    key ID          : String(3);
        Description : String;

}

entity DimensionUnits {
    key ID          : String(3);
        Description : String;

}

entity Months {
    key ID               : String(3);
        Description      : String;
        ShortDescription : String(3);

}

entity ProductReview {
    key Name    : String(3);
        Rating  : Integer;
        comment : String;
}

entity SalesData {
    key ID           : UUID;
        DeliveryDate : Date;
        Revenue      : Decimal(16, 2);
}
