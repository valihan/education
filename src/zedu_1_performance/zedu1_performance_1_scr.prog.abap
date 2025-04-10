*&---------------------------------------------------------------------*
*& Include          ZEDU1_PERFORMANCE_1_SCR
*&---------------------------------------------------------------------*

TABLES acdoca.
PARAMETERS: p_bukrs TYPE bukrs OBLIGATORY DEFAULT '1000',
            p_gjahr TYPE gjahr DEFAULT '2022'.
SELECT-OPTIONS:
            so_belnr FOR acdoca-belnr MEMORY ID bln,
            so_poper FOR acdoca-poper.


INITIALIZATION.
  APPEND VALUE #( low = '2500032912' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
  APPEND VALUE #( low = '2500032306' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '2500032386' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '5104524387' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '5104524388' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '5104524389' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.

  APPEND VALUE #( low = '8800035275' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '8800035274' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '4900001211' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.
*  APPEND VALUE #( low = '7100050767' sign = wmegc_sign_inclusive option = wmegc_option_eq ) TO so_belnr.

*  APPEND VALUE #( low = '86000118*' sign = wmegc_sign_inclusive option = wmegc_option_cp ) TO so_belnr.
  APPEND VALUE #( low = '8600011*' sign = wmegc_sign_inclusive option = wmegc_option_cp ) TO so_belnr.
*  APPEND VALUE #( low = '86*' sign = wmegc_sign_inclusive option = wmegc_option_cp ) TO so_belnr.

  append VALUE #( low = '009' sign = wmegc_sign_inclusive option = wmegc_option_eq ) to so_poper.
