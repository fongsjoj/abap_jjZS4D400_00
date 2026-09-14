*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    " Atributo estático
    CLASS-DATA counter TYPE i.

    " Métodos de Instancia
    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id DEFAULT 'LH'
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    METHODS get_attributes
      EXPORTING
        e_carrier_id    TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id.

    METHODS set_attributes_me
      IMPORTING
        carrier_id    TYPE /dmo/carrier_id
        connection_id TYPE /dmo/connection_id.

    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PRIVATE SECTION.
    " Encapsulación: Atributos privados para evitar modificación directa
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD set_attributes.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.
  ENDMETHOD.

  METHOD get_attributes.
    e_carrier_id    = me->carrier_id.
    e_connection_id = me->connection_id.
  ENDMETHOD.

  METHOD set_attributes_me.
    me->carrier_id    = carrier_id.
    me->connection_id = connection_id.
  ENDMETHOD.

  METHOD get_output.
    APPEND |Flight Connection { me->carrier_id } { me->connection_id }| TO r_output.
  ENDMETHOD.

ENDCLASS.
