namespace com.training;


using { cuid, Country } from '@sap/cds/common';

entity Course : cuid {
    Student : Association to many StudentCourse
                  on Student.Course = $self;
}

entity Student : cuid {
    Course : Association to many StudentCourse
                 on Course.Student = $self;
}

entity StudentCourse : cuid {
    Student : Association to Student;
    Course  : Association to Course;
}

entity Orders {
    key ClientEmail : String(65);
        FirstName   : String(30);
        LastName    : String(30);
        CreatedOn   : Date;
        Reviewed    : Boolean;
        Approved    : Boolean;
        Country     : Country;
        Status      : String(1);
}


// type Name : String(20);

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


// Comenta     Ctrl+K+C
// Descomentar Ctrl+C+U

// entity Car {
//     ID                 : UUID;
//     Name               : String;
//     virtual discount_1 : Decimal;
//     //Si queremos que ademas se pueda escribir en el campo virtual desde el cliente del servicio 
//     @Core.Computed : false
//     virtual discount_2 : Decimal;
// }
