*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.

    " Definición del método con CHANGING
    METHODS format_carrier
      CHANGING
*        c_carrier_id TYPE /dmo/carrier_id.
        c_carrier_id TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD format_carrier.
    " c_carrier_id ya entra con un valor. Aquí lo modificamos:
    c_carrier_id = |AIRLINE-{ c_carrier_id }|.
  ENDMETHOD.


ENDCLASS.
