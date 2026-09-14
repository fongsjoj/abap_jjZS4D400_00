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
    TYPES:
      BEGIN OF st_details,
        DepartureAirport   TYPE /dmo/airport_from_id,
        DestinationAirport TYPE /dmo/airport_to_id,
        AirlineName        TYPE /dmo/carrier_name,
      END OF st_details.

    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    DATA details       TYPE st_details.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    " Validación de campos obligatorios
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Mapeo por coincidencia exacta de nombres hacia la estructura interna
    SELECT SINGLE
      FROM /DMO/I_Connection
    FIELDS DepartureAirport,
           DestinationAirport,
           \_Airline-Name AS AirlineName
     WHERE AirlineID    = @i_carrier_id
       AND ConnectionID = @i_connection_id
      INTO CORRESPONDING FIELDS OF @me->details.

    " Validación de existencia del registro en la base de datos
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Asignación de atributos e incremento del contador global
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
    APPEND |--------------------------------| TO r_output.
    APPEND |Carrier:     { me->carrier_id      } ({ me->details-airlinename })| TO r_output.
    APPEND |Connection:  { me->connection_id   }| TO r_output.
    APPEND |Departure:   { me->details-departureairport }| TO r_output.
    APPEND |Destination: { me->details-destinationairport }| TO r_output.
  ENDMETHOD.

ENDCLASS.
