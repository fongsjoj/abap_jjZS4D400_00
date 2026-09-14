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
    DATA carrier_name    TYPE /dmo/carrier_name.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    " Validación de entradas
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Consulta usando la Vista CDS y la asociación \_Airline
    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
     WHERE AirlineID    = @i_carrier_id
       AND ConnectionID = @i_connection_id
      INTO ( @me->airport_from_id, @me->airport_to_id, @me->carrier_name ).

    " Control de existencia del registro
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Asignación de atributos de clave e incremento de contador
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
    APPEND |--------------------------------| TO r_output.
    APPEND |Carrier:     { me->carrier_id      } ({ me->carrier_name })| TO r_output.
    APPEND |Connection:  { me->connection_id   }| TO r_output.
    APPEND |Departure:   { me->airport_from_id }| TO r_output.
    APPEND |Destination: { me->airport_to_id   }| TO r_output.
  ENDMETHOD.

ENDCLASS.
