@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_J0FLIGHT
  as select from ZJ0FLIGHT as FLIGHT
{
  key carrid as Carrid,
  key connid as Connid,
  key fldate as Fldate,
  @Semantics.amount.currencyCode: 'Currency'
  price as Price,
  @Consumption.valueHelpDefinition: [ {
    entity.name: 'I_CurrencyStdVH', 
    entity.element: 'Currency', 
    useForValidation: true
  } ]
  currency as Currency,
  planetype as Planetype,
  seatsmax as Seatsmax,
  seatsocc as Seatsocc,
  @Semantics.amount.currencyCode: 'Currency'
  paymentsum as Paymentsum,
  seatsmax_b as SeatsmaxB,
  seatsocc_b as SeatsoccB,
  seatsmax_f as SeatsmaxF,
  seatsocc_f as SeatsoccF,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
