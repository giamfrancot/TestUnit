class ZCL_WGT_CASH_PROVIDER_MANAGED definition
  public
  final
  create public .

public section.

  interfaces ZIF_WGT_CASH_PROVIDER .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WGT_CASH_PROVIDER_MANAGED IMPLEMENTATION.


  METHOD ZIF_WGT_CASH_PROVIDER~get_coins.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.


  METHOD ZIF_WGT_CASH_PROVIDER~get_notes.
    "not usable right now
    ASSERT 0 = 1.
  ENDMETHOD.
ENDCLASS.
