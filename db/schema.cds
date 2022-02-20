namespace com.dhl;

entity Products {
    key Id              : UUID;
        name            : String;
        Description     : String;
        ImageUrl        : String;
        ReleaseDate     : DateTime;
        DiscontinueDate : DateTime;
        Price           : Decimal(16, 2);
        Height          : Decimal(16, 2);
        Width           : Decimal(16, 2);
        Depth           : Decimal(16, 2);
        Quantity        : Decimal(16, 2);
};

entity Supplier {
    key Id         : UUID;
        name       : String;
        Street     : String;
        City       : String;
        State      : String;
        PostalCode : String(5);
        Country    : String(3);
        Email      : String;
        Phone      : String;
        Fax        : String;
};

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
    key ID             : String(3);
        Description    : String;
        ShortDescption : String(3);

}

entity ProductReview {
    key Name    : String(3);
        Rating  : Integer;
        comment : String;
}

entity SalesData {
    key DeliveryDate : Date;
        Revenue      : Decimal(16, 2);
}
