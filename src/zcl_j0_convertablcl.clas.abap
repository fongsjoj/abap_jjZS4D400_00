CLASS zcl_j0_convertablcl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_convertablcl IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

" Invoca al método estático de la clase local lcl_connection
    DATA(lt_airports) = lcl_connection=>get_airports_by_city( 'London' ).

    " Imprime la tabla devuelta por la clase local
    out->write( `----------------------------------------------------------` ).
    out->write( `Resultados obtenidos desde la clase local lcl_connection:` ).
    out->write( data = lt_airports
                 name = `Aeropuertos de Londres (tt_airports):` ).


  ENDMETHOD.
ENDCLASS.
