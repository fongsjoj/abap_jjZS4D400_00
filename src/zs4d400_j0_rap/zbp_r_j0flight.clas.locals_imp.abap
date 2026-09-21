CLASS lhc_zr_j0flight DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR flight
        RESULT result,

      CheckSemanticKey FOR VALIDATE ON SAVE
        IMPORTING keys FOR flight~CheckSemanticKey,

      CheckCarrier FOR VALIDATE ON SAVE
        IMPORTING keys FOR flight~CheckCarrier,
      validatePrice FOR VALIDATE ON SAVE
            keys FOR flight~validatePrice.
ENDCLASS.

CLASS lhc_zr_j0flight IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

METHOD CheckSemanticKey.

    READ ENTITIES OF zr_j0flight IN LOCAL MODE
      ENTITY flight
        FIELDS ( Carrid Connid Fldate ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_flights).

    DATA ls_reported LIKE LINE OF reported-flight.

    LOOP AT lt_flights INTO DATA(ls_flight).

      IF ls_flight-Carrid IS INITIAL OR ls_flight-Connid IS INITIAL OR ls_flight-Fldate IS INITIAL.
        CONTINUE.
      ENDIF.

      " Consulta de coincidencia
      SELECT FROM zj0flight
        FIELDS carrid
        WHERE carrid = @ls_flight-Carrid
          AND connid = @ls_flight-Connid
          AND fldate = @ls_flight-Fldate
      UNION
      SELECT FROM zj0flight_d
        FIELDS carrid
        WHERE carrid = @ls_flight-Carrid
          AND connid = @ls_flight-Connid
          AND fldate = @ls_flight-Fldate
      INTO TABLE @DATA(check_result).

      " Si estamos editando un borrador ya existente, el registro se encontrará a sí mismo (1 coincidencia).
      " Solo es un duplicado si se encuentra MÁS de 1 registro o si es una creación desde cero.
      DATA(lv_is_create) = COND abap_bool( WHEN ls_flight-%is_draft = if_abap_behv=>mk-on AND ls_flight-Carrid IS NOT INITIAL THEN abap_true ).

      IF ( lv_is_create = abap_true AND lines( check_result ) > 1 )
      OR ( lines( check_result ) > 1 ).

        APPEND VALUE #( %tky = ls_flight-%tky ) TO failed-flight.

        DATA(message) = me->new_message(
                          id       = 'ZMC_J0FLIGHT'
                          number   = '001'
                          severity = if_abap_behv_message=>severity-error
                          v1       = ls_flight-Carrid
                          v2       = ls_flight-Connid ).

        CLEAR ls_reported.
        ls_reported-%tky                  = ls_flight-%tky.
        ls_reported-%msg                  = message.
        ls_reported-%element-carrid       = if_abap_behv=>mk-on.
        ls_reported-%element-connid       = if_abap_behv=>mk-on.
        ls_reported-%element-fldate       = if_abap_behv=>mk-on.

        APPEND ls_reported TO reported-flight.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

METHOD CheckCarrier.

    " 1. Leer el campo Carrid de los registros modificados
    READ ENTITIES OF zr_j0flight IN LOCAL MODE
      ENTITY flight
        FIELDS ( Carrid ) WITH CORRESPONDING #( keys )
      RESULT DATA(lt_flights).

    DATA ls_reported LIKE LINE OF reported-flight.

    " 2. Evaluar cada línea
    LOOP AT lt_flights INTO DATA(ls_flight).

      IF ls_flight-Carrid IS INITIAL.
        CONTINUE.
      ENDIF.

      " 3. Consultar la vista CDS agregando WITH PRIVILEGED ACCESS
      SELECT SINGLE
        FROM /dmo/i_carrier WITH PRIVILEGED ACCESS
        FIELDS @abap_true
        WHERE AirlineID = @ls_flight-Carrid
        INTO @DATA(exists).

      " 4. Si la aerolínea no existe
      IF exists <> abap_true.

        " Rechazar guardado (FAILED)
        APPEND VALUE #( %tky = ls_flight-%tky ) TO failed-flight.

        " Crear objeto de mensaje 002
        DATA(message) = me->new_message(
                          id       = 'ZMC_J0FLIGHT'
                          number   = '002'
                          severity = if_abap_behv_message=>severity-error
                          v1       = ls_flight-Carrid ).

        " Completar la estructura reported
        CLEAR ls_reported.
        ls_reported-%tky            = ls_flight-%tky.
        ls_reported-%msg            = message.
        ls_reported-%element-carrid = if_abap_behv=>mk-on.

        APPEND ls_reported TO reported-flight.

      ENDIF.

      CLEAR exists.

    ENDLOOP.

  ENDMETHOD.

  METHOD validatePrice.

  " Declaración imperativa de estructuras según el manual
    DATA failed_record LIKE LINE OF failed-flight.
    DATA reported_record LIKE LINE OF reported-flight.

    " 1. Leer el campo Price desde el buffer transaccional
    READ ENTITIES OF zr_j0flight IN LOCAL MODE
      ENTITY flight
        FIELDS ( Price ) WITH CORRESPONDING #( keys )
      RESULT DATA(flights).

    " 2. Recorrer los vuelos evaluando que el precio sea mayor que cero
    LOOP AT flights INTO DATA(flight).

      IF flight-price <= 0.

        " Informar el fallo
        failed_record-%tky = flight-%tky.
        APPEND failed_record TO failed-flight.

        " Informar el mensaje de error de la clase del curso y resaltar el campo
        reported_record-%tky                  = flight-%tky.
        reported_record-%msg                  = new_message(
                                                  id       = '/LRN/S4D400'
                                                  number   = '101'
                                                  severity = if_abap_behv_message=>severity-error ).
        reported_record-%element-price        = if_abap_behv=>mk-on.

        APPEND reported_record TO reported-flight.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
