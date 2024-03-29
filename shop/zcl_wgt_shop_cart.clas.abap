CLASS zcl_wgt_shop_cart DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS add_item
      IMPORTING
        !i_item TYPE zase_shop_item .
    METHODS remove_item
      IMPORTING
        !i_cart_item TYPE zase_shop_cart_item .
    METHODS get_cart
      RETURNING
        VALUE(r_cart) TYPE zase_shop_cart .
    METHODS get_number_of_items_in_cart
      RETURNING
        VALUE(r_size) TYPE i .
    METHODS get_standard_total
      RETURNING
        VALUE(r_total) TYPE zase_shop_item_standard_total .
    METHODS get_total_rebate_reason
      RETURNING
        VALUE(r_reason) TYPE string .
    METHODS get_rebate
      RETURNING
        VALUE(r_total) TYPE zase_shop_item_rebate .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      m_cart           TYPE zase_shop_cart,
      m_standard_total TYPE zase_shop_item_standard_total.
    METHODS calculate_rebates.
    METHODS calculate_standard_total.
ENDCLASS.



CLASS zcl_wgt_shop_cart IMPLEMENTATION.


  METHOD add_item.
    DATA:
      cart_item TYPE zase_shop_cart_item.

    READ TABLE m_cart INTO cart_item WITH KEY id = i_item-id.
    IF sy-subrc <> 0.
      cart_item-mandt          = i_item-mandt.
      cart_item-id             = i_item-id.
      cart_item-category       = i_item-category.
      cart_item-name           = i_item-name.
      cart_item-standard_price = i_item-price.
      cart_item-quantity       = 1.
      cart_item-standard_total = i_item-price.
      cart_item-rebate_amount  = 0.
      cart_item-rebate_reason  = space.
      APPEND cart_item TO m_cart.
    ELSE.
      cart_item-quantity       = cart_item-quantity + 1.
      cart_item-standard_total = cart_item-quantity * i_item-price.
      MODIFY TABLE m_cart FROM cart_item.
    ENDIF.

    calculate_standard_total( ).


    calculate_rebates( ).
  ENDMETHOD.


  METHOD calculate_rebates.
    "We need to clear all previous rebate calculations because adding or
    "removing items may change everything

    "You should call the rebate engine here
  ENDMETHOD.


  METHOD calculate_standard_total.
    CLEAR m_standard_total.
    LOOP AT m_cart ASSIGNING FIELD-SYMBOL(<cart_item>).
      <cart_item>-standard_total = <cart_item>-quantity * <cart_item>-standard_price.
      m_standard_total = m_standard_total + <cart_item>-standard_total.
    ENDLOOP.
  ENDMETHOD.


  METHOD get_cart.
    r_cart = m_cart.
  ENDMETHOD.


  METHOD get_number_of_items_in_cart.
    r_size = lines( m_cart ).
  ENDMETHOD.


  METHOD get_rebate.
  ENDMETHOD.


  METHOD get_standard_total.
    r_total = m_standard_total.
  ENDMETHOD.


  METHOD get_total_rebate_reason.
  ENDMETHOD.


  METHOD remove_item.
    DATA:
      cart_item TYPE zase_shop_cart_item.

    cart_item = i_cart_item.
    IF cart_item-quantity = 1.
      DELETE TABLE m_cart WITH TABLE KEY id = cart_item-id.
    ELSE.
      cart_item-quantity       = cart_item-quantity - 1.
      cart_item-standard_total = cart_item-quantity * cart_item-standard_price.
      MODIFY TABLE m_cart FROM cart_item.
    ENDIF.

    calculate_standard_total( ).
    calculate_rebates( ).
  ENDMETHOD.
ENDCLASS.
