*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
" ----------------------------------------------------------------------
" Definición de Tipos Locales
" ----------------------------------------------------------------------
TYPES:
  BEGIN OF st_details,
    DepartureAirport   TYPE /dmo/airport_from_id,
    DestinationAirport TYPE /dmo/airport_to_id,
    AirlineName        TYPE /dmo/carrier_name,
  END OF st_details.

TYPES:
  BEGIN OF st_airport,
    AirportId TYPE /dmo/airport_id,
    Name      TYPE /dmo/airport_name,
  END OF st_airport.

TYPES tt_airports TYPE STANDARD TABLE OF st_airport
                  WITH NON-UNIQUE DEFAULT KEY.

" ----------------------------------------------------------------------
" Definición de la Clase Local lcl_connection
" ----------------------------------------------------------------------
CLASS lcl_connection DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS:
      get_airports_by_city
        IMPORTING
          i_city            TYPE /dmo/city
        RETURNING
          VALUE(rt_airports) TYPE tt_airports.
ENDCLASS.

" ----------------------------------------------------------------------
" Implementación de la Clase Local lcl_connection
" ----------------------------------------------------------------------
CLASS lcl_connection IMPLEMENTATION.
  METHOD get_airports_by_city.

    SELECT FROM /dmo/i_airport
           FIELDS AirportID, Name
           WHERE City = @i_city
           INTO CORRESPONDING FIELDS OF TABLE @rt_airports.

  ENDMETHOD.
ENDCLASS.

