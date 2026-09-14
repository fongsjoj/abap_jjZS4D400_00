*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    " Atributos de la instancia
    DATA carrier_id    TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    " Método para establecer atributos con validación
    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

    " Método funcional que retorna una tabla de strings
    METHODS get_output
      RETURNING
        VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.

  METHOD set_attributes.
    " Validar que los parámetros no vengan vacíos
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id    = i_carrier_id.
    me->connection_id = i_connection_id.
  ENDMETHOD.

  METHOD get_output.
    " Devuelve la información formateada dentro de la tabla interna r_output
    APPEND |Flight Connection { me->carrier_id } { me->connection_id }| TO r_output.
  ENDMETHOD.

ENDCLASS.

