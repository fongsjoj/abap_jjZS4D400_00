CLASS zcl_j0_usoeml1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_usoeml1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA agencies_upd TYPE TABLE FOR UPDATE /DMO/R_AgencyTP.
    agencies_upd = VALUE #( ( agencyID = '070045' Name = 'LOTERY Agency' ) ).
    MODIFY ENTITIES OF /DMO/R_AgencyTP
    ENTITY /DMO/Agency
    UPDATE FIELDS ( name )
    WITH agencies_upd.
    COMMIT ENTITIES.
    out->write( 'Method execution finished!' ).

  ENDMETHOD.
ENDCLASS.
