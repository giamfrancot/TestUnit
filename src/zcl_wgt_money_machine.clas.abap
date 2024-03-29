class ZCL_WGT_MONEY_MACHINE definition
  public
  final
  create public .

public section.

  methods GET_AMOUNT_IN_COINS
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  methods GET_AMOUNT_IN_NOTES
    importing
      !I_AMOUNT type I
    returning
      value(R_VALUE) type I .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_WGT_MONEY_MACHINE IMPLEMENTATION.


  METHOD get_amount_in_coins.
    r_value = COND #( WHEN i_amount <= 0
                      THEN -1
                      ELSE i_amount MOD 5 ).
  ENDMETHOD.


  METHOD get_amount_in_notes.
    r_value = get_amount_in_coins( i_amount ).
    IF r_value >= 0.
      r_value = i_amount - r_value.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
