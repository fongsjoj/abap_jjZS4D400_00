CLASS zcl_j0_instance_itab1 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_instance_itab1 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

* First Instance
**********************************************************************

    connection = NEW #(  ).

    connection->carrier_id    = 'LH'.
    connection->connection_id = '0400'.

    APPEND connection TO connections.

* Second Instance
**********************************************************************
    connection = NEW #(  ).

    connection->carrier_id    = 'AA'.
    connection->connection_id = '0017'.

    APPEND connection TO connections.

* Third Instance
**********************************************************************
    connection = NEW #(  ).

    connection->carrier_id    = 'SQ'.
    connection->connection_id = '0001'.

    APPEND connection TO connections.

* Mostrar datos en la consola
**********************************************************************
    LOOP AT connections INTO connection.
      out->write( |Aerolínea: { connection->carrier_id } | &
                  |Conexión: { connection->connection_id }| ).
    ENDLOOP.

    LOOP AT connections INTO connection.
      out->write( |Name: carrier_id     -> Data: { connection->carrier_id }| ).
      out->write( |Name: connection_id  -> Data: { connection->connection_id }| ).
      out->write( '----------------------------------------' ).
    ENDLOOP.

    DATA: v_index TYPE i.

    LOOP AT connections INTO connection.
      v_index = v_index + 1.

      " Imprime la instancia identificada con un nombre o etiqueta
      out->write(
        data = connection
        name = |Instancia { v_index } (Objeto)|
      ).
    ENDLOOP.

* Para mostrar una fila con titulos y abajo los datos de las aerolineas
*    DATA connection TYPE REF TO lcl_connection.
*    DATA connections TYPE TABLE OF REF TO lcl_connection.
*
*    " Definición de una estructura y tabla de salida con los nombres de columna deseados
*    TYPES: BEGIN OF ty_output,
*             aerolinea    TYPE /dmo/carrier_id,
*             conexion     TYPE /dmo/connection_id,
*             conn_counter TYPE i,
*           END OF ty_output.
*
*    DATA lt_output TYPE TABLE OF ty_output.
*
** First Instance
*    connection = NEW #( ).
*    connection->carrier_id    = 'LH'.
*    connection->connection_id = '0400'.
*    lcl_connection=>conn_counter = lcl_connection=>conn_counter + 1.
*    APPEND connection TO connections.
*
** Second Instance
*    connection = NEW #( ).
*    connection->carrier_id    = 'AA'.
*    connection->connection_id = '0017'.
*    lcl_connection=>conn_counter = lcl_connection=>conn_counter + 1.
*    APPEND connection TO connections.
*
** Third Instance
*    connection = NEW #( ).
*    connection->carrier_id    = 'SQ'.
*    connection->connection_id = '0001'.
*    lcl_connection=>conn_counter = lcl_connection=>conn_counter + 1.
*    APPEND connection TO connections.
*
** Mapeo de referencias a la tabla de salida
*    LOOP AT connections INTO connection.
*      APPEND VALUE #(
*        aerolinea    = connection->carrier_id
*        conexion     = connection->connection_id
*        conn_counter = lcl_connection=>conn_counter
*      ) TO lt_output.
*    ENDLOOP.
*
** Imprimir la tabla procesada con su encabezado
*    out->write( data = lt_output name = 'Tabla de Conexiones' ).
*
*  ENDMETHOD.

  ENDMETHOD.

ENDCLASS.
