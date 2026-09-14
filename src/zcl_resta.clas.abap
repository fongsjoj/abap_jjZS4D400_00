* Autor      : Usuario
* Fecha      : 24.08.2026
* Descripción: Clase con operación de resta
* Paquete    : ZS4D400_00
*nuevo
CLASS zcl_resta DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    " Método que recibe dos números y retorna su resta
    METHODS restar
      IMPORTING
        iv_num1 TYPE i
        iv_num2 TYPE i
      RETURNING
        VALUE(rv_resultado) TYPE i.

ENDCLASS.

CLASS zcl_resta IMPLEMENTATION.
  METHOD restar.
    " Resta el segundo parámetro del primero y devuelve el resultado
    rv_resultado = iv_num1 - iv_num2.
  ENDMETHOD.
ENDCLASS.
