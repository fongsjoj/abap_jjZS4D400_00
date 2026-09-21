CLASS zcl_j0_copy DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_j0_copy IMPLEMENTATION.

METHOD if_oo_adt_classrun~main.

    DATA lt_j0flight TYPE TABLE OF zj0flight.
    DATA lv_ts TYPE abp_creation_tstmpl.

    " 1. Vaciar la tabla de destino
    DELETE FROM zj0flight.

    " 2. Obtener la marca de tiempo y el usuario actual
    GET TIME STAMP FIELD lv_ts.
    DATA(lv_user) = cl_abap_context_info=>get_user_technical_name( ).

    " 3. Construir registros de prueba (líneas formateadas a < 255 caracteres)
    lt_j0flight = VALUE #(
      ( carrid = 'AA'
        connid = '0017'
        fldate = '20261001'
        price = '420.00'
        currency = 'USD'
        planetype = '747-400'
        seatsmax = 385
        seatsocc = 372
        paymentsum = '161280.00'
        seatsmax_b = 31
        seatsocc_b = 28
        seatsmax_f = 11
        seatsocc_f = 10
        created_by = lv_user
        created_at = lv_ts
        local_last_changed_by = lv_user
        local_last_changed_at = lv_ts
        last_changed_at = lv_ts )

      ( carrid = 'AA'
        connid = '0064'
        fldate = '20261001'
        price = '360.00'
        currency = 'USD'
        planetype = 'A320'
        seatsmax = 220
        seatsocc = 205
        paymentsum = '78120.00'
        seatsmax_b = 22
        seatsocc_b = 20
        seatsmax_f = 6
        seatsocc_f = 5
        created_by = lv_user
        created_at = lv_ts
        local_last_changed_by = lv_user
        local_last_changed_at = lv_ts
        last_changed_at = lv_ts )

      ( carrid = 'LH'
        connid = '0400'
        fldate = '20261002'
        price = '600.00'
        currency = 'EUR'
        planetype = '747-400'
        seatsmax = 385
        seatsocc = 350
        paymentsum = '220500.00'
        seatsmax_b = 31
        seatsocc_b = 30
        seatsmax_f = 11
        seatsocc_f = 11
        created_by = lv_user
        created_at = lv_ts
        local_last_changed_by = lv_user
        local_last_changed_at = lv_ts
        last_changed_at = lv_ts )

      ( carrid = 'LH'
        connid = '0402'
        fldate = '20261003'
        price = '650.00'
        currency = 'EUR'
        planetype = 'A340-600'
        seatsmax = 350
        seatsocc = 310
        paymentsum = '211150.00'
        seatsmax_b = 30
        seatsocc_b = 28
        seatsmax_f = 10
        seatsocc_f = 9
        created_by = lv_user
        created_at = lv_ts
        local_last_changed_by = lv_user
        local_last_changed_at = lv_ts
        last_changed_at = lv_ts )

      ( carrid = 'UA'
        connid = '0900'
        fldate = '20261004'
        price = '510.00'
        currency = 'USD'
        planetype = '777-200'
        seatsmax = 330
        seatsocc = 290
        paymentsum = '155450.00'
        seatsmax_b = 28
        seatsocc_b = 25
        seatsmax_f = 8
        seatsocc_f = 7
        created_by = lv_user
        created_at = lv_ts
        local_last_changed_by = lv_user
        local_last_changed_at = lv_ts
        last_changed_at = lv_ts )
    ).

    " 4. Insertar los registros en la tabla
    INSERT zj0flight FROM TABLE @lt_j0flight.

    IF sy-subrc = 0.
      out->write( 'zj0flight se lleno con datos exitosamente.' ).
    ELSE.
      out->write( 'Error al insertar los registros en zj0flight.' ).
    ENDIF.

  ENDMETHOD.

ENDCLASS.
