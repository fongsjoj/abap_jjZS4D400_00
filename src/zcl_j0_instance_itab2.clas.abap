**********************************************************************
** METODO PROCEDIMENTAL USO DE IMPORTING EXPORTING
**********************************************************************
CLASS zcl_j0_instance_itab2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_instance_itab2 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    " Primera Instancia
    connection = NEW #( ).
    TRY.
        connection->set_attributes(
          EXPORTING
            i_carrier_id    = 'LH'
            i_connection_id = '0400' ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( | Error: No se pueden enviar valores vacíos. | ).
    ENDTRY.

    " Segunda Instancia
    connection = NEW #( ).
    TRY.
        connection->set_attributes(
          i_carrier_id    = 'AA'
          i_connection_id = '0017' ).
        APPEND connection TO connections. " <-- Agregado para guardar el segundo objeto
      CATCH cx_abap_invalid_value.
        out->write( | Error: No se pueden enviar valores vacíos. | ).
    ENDTRY.

    " Lectura y salida
    LOOP AT connections INTO connection.
      connection->get_attributes(
        IMPORTING
          e_carrier_id    = carrier_id
          e_connection_id = connection_id ).

      out->write( | Flight Connection { carrier_id } { connection_id } | ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

