* Autor      : Usuario
* Fecha      : 27.08.2026
* Descripción: Clase calculadora simple
* Paquete    : ZS4D400_00

CLASS zcl_acalculadora DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    " Método que recibe dos números enteros y retorna su suma
    METHODS sumar
      IMPORTING
        iv_num1 TYPE i
        iv_num2 TYPE i
      RETURNING
        VALUE(rv_resultado) TYPE i.

ENDCLASS.

CLASS zcl_acalculadora IMPLEMENTATION.
  METHOD sumar.
    " Suma los dos parámetros de entrada y devuelve el resultado
    "cambio desde eclipse
    rv_resultado = iv_num1 + iv_num2.
  ENDMETHOD.
ENDCLASS.
