CLASS zcl_j0_instance_itab4 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_instance_itab4 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    " 1. Declaramos y asignamos valor INICIAL a la variable local
*    DATA my_carrier TYPE /dmo/carrier_id VALUE 'LH'.
    DATA my_carrier TYPE string VALUE 'LH'.

    DATA(connection) = NEW lcl_connection( ).

    " 2. Llamamos al método pasando la variable en CHANGING
    " En este punto my_carrier vale 'LH'
    connection->format_carrier(
      CHANGING
        c_carrier_id = my_carrier ).

    " 3. Imprimimos el resultado
    " Ahora my_carrier fue modificada directamente por el método y vale 'AIRLINE-LH'
    out->write( my_carrier ).


  ENDMETHOD.
ENDCLASS.
