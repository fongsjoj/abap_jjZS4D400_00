*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i.

    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PRIVATE SECTION.
    DATA carrier_id      TYPE /dmo/carrier_id.
    DATA connection_id   TYPE /dmo/connection_id.
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id   TYPE /dmo/airport_to_id.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    " Validación de entrada
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Lectura desde la base de datos de los aeropuertos de origen y destino
    SELECT SINGLE
      FROM /dmo/connection
      FIELDS airport_from_id, airport_to_id
      WHERE carrier_id    = @i_carrier_id
        AND connection_id = @i_connection_id
      INTO ( @me->airport_from_id, @me->airport_to_id ).

    " Si la combinación no existe en la tabla de base de datos
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Asignación de llaves e incremento de contador
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
    APPEND |--------------------------------| TO r_output.
    APPEND |Carrier:     { me->carrier_id      }| TO r_output.
    APPEND |Connection:  { me->connection_id   }| TO r_output.
    APPEND |Departure:   { me->airport_from_id }| TO r_output.
    APPEND |Destination: { me->airport_to_id   }| TO r_output.
  ENDMETHOD.

ENDCLASS.
