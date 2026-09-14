CLASS zcl_j0_instance_itab3 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_j0_instance_itab3 IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection  TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    " ------------------------------------------------------------------
    " 1. Crear Instancia #1 y guardar en la tabla interna
    " ------------------------------------------------------------------
    connection = NEW #( ).
    TRY.
        connection->set_attributes( i_carrier_id = 'LH' i_connection_id = '0400' ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Error en Instancia 1` ).
    ENDTRY.

    " ------------------------------------------------------------------
    " 2. Crear Instancia #2 y guardar en la tabla interna
    " ------------------------------------------------------------------
    connection = NEW #( ).
    TRY.
        connection->set_attributes( i_carrier_id = 'AA' i_connection_id = '0017' ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Error en Instancia 2` ).
    ENDTRY.

    " ------------------------------------------------------------------
    " 3. Recorrer la tabla e invocar el Método Funcional para CADA objeto
    " ------------------------------------------------------------------
    LOOP AT connections INTO connection.

      " Llamamos al método funcional directamente dentro del out->write
      out->write(
        data = connection->get_output( )
        name = |Datos del vuelo:|
      ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.


