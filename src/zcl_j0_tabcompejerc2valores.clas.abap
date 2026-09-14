CLASS zcl_j0_tabcompejerc2valores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_j0_tabcompejerc2valores IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "1. Declaracion de tipos
    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
           END OF st_connection.

    "1. Declaracion de tipos

    "2. Declaracion de las tablas
    DATA numbers           TYPE TABLE OF i.
    DATA connections       TYPE TABLE OF st_connection.
    DATA connections_x     TYPE TABLE OF st_connection.
    DATA connections_1 TYPE TABLE OF st_connection.
    DATA connections_2 TYPE STANDARD TABLE OF st_connection
                            WITH NON-UNIQUE DEFAULT KEY.
    DATA connections_3 TYPE SORTED TABLE OF st_connection
                            WITH NON-UNIQUE KEY airport_from_id airport_to_id.
    DATA connections_4 TYPE HASHED TABLE OF st_connection
                            WITH UNIQUE KEY carrier_id connection_id.

    " ----------------------------------------------------------------------
    " 3. Poblar las tablas internas mediante la expresión VALUE
    " ----------------------------------------------------------------------

    " Tabla simple (escalar)
    numbers = VALUE #( ( 10 ) ( 20 ) ( 30 ) ( 40 ) ).

    " Tablas complejas (estructuradas)
    connections = VALUE #(
      ( carrier_id = 'LH' connection_id = '0400' airport_from_id = 'FRA' airport_to_id = 'JFK' )
      ( carrier_id = 'AA' connection_id = '0017' airport_from_id = 'MIA' airport_to_id = 'SCL' )
    ).

    connections_1 = VALUE #(
      ( carrier_id = 'UA' connection_id = '0500' airport_from_id = 'EWR' airport_to_id = 'ORD' )
    ).

    connections_2 = VALUE #(
      ( carrier_id = 'AF' connection_id = '0001' airport_from_id = 'CDG' airport_to_id = 'JFK' )
    ).

    " Sorted Table: Inserta manteniendo automáticamente el orden por aeropuerto de origen/destino
    connections_3 = VALUE #(
      ( carrier_id = 'LH' connection_id = '0400' airport_from_id = 'FRA' airport_to_id = 'JFK' )
      ( carrier_id = 'LA' connection_id = '0500' airport_from_id = 'SCL' airport_to_id = 'EZE' )
    ).

    " Hashed Table: Exige claves primarias estrictamente únicas (carrier_id + connection_id)
    connections_4 = VALUE #(
      ( carrier_id = 'LH' connection_id = '0400' airport_from_id = 'FRA' airport_to_id = 'JFK' )
      ( carrier_id = 'SQ' connection_id = '0026' airport_from_id = 'SIN' airport_to_id = 'FRA' )
    ).

    " Repetir en la tabla compleja estructurada
    connections_x = VALUE #(
    ( carrier_id = 'LA' connection_id = '0900' airport_from_id = 'MIA' airport_to_id = 'CCS' )
    ( carrier_id = 'SQ' connection_id = '0800' airport_from_id = 'LON' airport_to_id = 'LIM' )
    ).

    " ----------------------------------------------------------------------
    " 4. Visualización en la Consola de Eclipse ABAP (Console View)
    " ----------------------------------------------------------------------
    out->write( `--------------------------------------------` ).
    out->write( `Example 1: Simple and Complex Internal Table` ).
    out->write( data = numbers     name = `Simple Table NUMBERS:` ).
    out->write( data = connections name = `Complex Table CONNECTIONS:` ).

    out->write( `--------------------------------------------` ).
    out->write( `Example 2: Complex Internal Tables` ).
    out->write( data = connections_1 name = `Table CONNECTIONS_1 (Standard Short):` ).
    out->write( data = connections_2 name = `Table CONNECTIONS_2 (Standard Explicit):` ).
    out->write( data = connections_3 name = `Table CONNECTIONS_3 (Sorted Table):` ).
    out->write( data = connections_4 name = `Table CONNECTIONS_4 (Hashed Table):` ).
    out->write( data = connections_x name = `Table CONNECTIONS_X (Hashed Table):` ).


  ENDMETHOD.
ENDCLASS.
