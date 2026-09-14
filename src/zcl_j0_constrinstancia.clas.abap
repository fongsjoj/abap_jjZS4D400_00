CLASS zcl_j0_constrinstancia DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_constrinstancia IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    TRY.
        " Instancia 1: Invocación directa del constructor vía NEW
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
        out->write( 'Error: Se intentó crear una instancia con datos no válidos.' ).
    ENDTRY.

    " Recorrer la tabla de objetos y mostrar el resultado
    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.

    " Salida del contador global de instancias creadas
    out->write( |Instancias creadas: { lcl_connection=>conn_counter }| ).

  ENDMETHOD.
ENDCLASS.
