*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    " Atributos de instancia
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    " Definición de firmas de métodos
    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_attributes
      EXPORTING
        e_carrier_id    TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  " Lógica para guardar datos dentro del objeto
  METHOD set_attributes.
" 2. Validamos la condición y lanzamos la excepción
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.
  ENDMETHOD.

  " Lógica para entregar datos hacia afuera
  METHOD get_attributes.
    e_carrier_id    = me->carrier_id.
    e_connection_id = me->connection_id.
  ENDMETHOD.

ENDCLASS.
