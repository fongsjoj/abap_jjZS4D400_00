*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    " Atributo estático para conteo global de instancias
    CLASS-DATA conn_counter TYPE i.

    " Constructor de instancia
    METHODS constructor
      IMPORTING
        i_connection_id TYPE /dmo/connection_id
        i_carrier_id    TYPE /dmo/carrier_id
      RAISING
        cx_abap_invalid_value.

    " Método de salida de datos
    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

    " * METHODS set_attributes ... (Comentado)

  PRIVATE SECTION.
    " Atributos encapsulados
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    " Validación de valores no iniciales
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    " Asignación de atributos
    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.

    " Incremento del contador global
    conn_counter = conn_counter + 1.
  ENDMETHOD.

  " * METHOD set_attributes ... (Comentado)

  METHOD get_output.
    APPEND |Flight Connection { me->carrier_id } { me->connection_id }| TO r_output.
  ENDMETHOD.

ENDCLASS.
