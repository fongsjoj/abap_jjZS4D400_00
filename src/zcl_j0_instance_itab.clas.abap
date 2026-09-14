CLASS zcl_J0_instance_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ZCL_J0_INSTANCE_ITAB IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

  DATA connection type ref to lcl_connection.
  DATA connections TYPE table of ref to lcl_connection.

    connection = NEW #(  ).
    APPEND connection TO connections.

    connection = NEW #(  ).
    APPEND connection TO connections.

*    connection = NEW #(  ).
*    APPEND connection TO connections.


  ENDMETHOD.
ENDCLASS.
