*&---------------------------------------------------------------------*
*& Include          ZEDU1_PERFORMANCE_1_EVT
*&---------------------------------------------------------------------*

START-OF-SELECTION.
  DATA(lo_main) = NEW lcl_main( ).
  lo_main->start_of_selection( ).

END-OF-SELECTION.
  lo_main->end_of_selection( ).
