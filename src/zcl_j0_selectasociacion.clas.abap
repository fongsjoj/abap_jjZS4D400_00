CLASS zcl_j0_selectasociacion DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_selectasociacion IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    TRY.
        " Instancia 1
        connection = NEW #(
          i_carrier_id    = 'LH'
          i_connection_id = '0400' ).
        APPEND connection TO connections.

        " Instancia 2
        connection = NEW #(
          i_carrier_id    = 'AA'
          i_connection_id = '0017' ).
        APPEND connection TO connections.

      CATCH cx_abap_invalid_value.
        out->write( 'Error: Se intentó crear una instancia con datos no válidos o inexistentes.' ).
    ENDTRY.

    " Imprimir la salida formateada de cada objeto
    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.

    out->write( |Instancias creadas: { lcl_connection=>conn_counter }| ).

  ENDMETHOD.
ENDCLASS.
