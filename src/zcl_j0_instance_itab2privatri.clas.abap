CLASS zcl_j0_instance_itab2privatri DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_j0_instance_itab2privatri IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.
    DATA carrier_id  TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    TRY.
        " Instancia 1
        connection = NEW #( ).
        connection->set_attributes(
          i_carrier_id    = 'LH'
          i_connection_id = '0400' ).
        APPEND connection TO connections.

        " Instancia 2
        connection = NEW #( ).
        connection->set_attributes(
          i_carrier_id    = 'AA'
          i_connection_id = '0017' ).
        APPEND connection TO connections. " Se agrega la segunda instancia a la tabla

      CATCH cx_abap_invalid_value.
        out->write( 'Ocurrió un error con los valores proporcionados.' ).
    ENDTRY.

    " Recorrer la tabla de referencias
    LOOP AT connections INTO connection.
      connection->get_attributes(
        IMPORTING
          e_carrier_id    = carrier_id
          e_connection_id = connection_id ).

      out->write( | Flight Connection { carrier_id } { connection_id } | ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
