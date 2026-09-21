@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_J0FLIGHT
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_J0FLIGHT
  association [1..1] to ZR_J0FLIGHT as _BaseEntity on $projection.CARRID = _BaseEntity.CARRID and $projection.CONNID = _BaseEntity.CONNID and $projection.FLDATE = _BaseEntity.FLDATE
{
  key Carrid,
  key Connid,
  key Fldate,
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  Price,
  @Consumption: {
    Valuehelpdefinition: [ {
      Entity.Element: 'Currency', 
      Entity.Name: 'I_CurrencyStdVH', 
      Useforvalidation: true
    } ]
  }
  Currency,
  Planetype,
  Seatsmax,
  Seatsocc,
  @Semantics: {
    Amount.Currencycode: 'Currency'
  }
  Paymentsum,
  SeatsmaxB,
  SeatsoccB,
  SeatsmaxF,
  SeatsoccF,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Localinstancelastchangedby: true
  }
  LocalLastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
