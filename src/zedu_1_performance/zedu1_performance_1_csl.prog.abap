*&---------------------------------------------------------------------*
*& Include          ZEDU1_PERFORMANCE_1_CSL
*&---------------------------------------------------------------------*

CLASS lcl_main DEFINITION.
  PUBLIC SECTION.
    METHODS:
      start_of_selection,
      end_of_selection.
  PRIVATE SECTION.

    TYPES: BEGIN OF ts_data,
             rbukrs     TYPE bukrs,
             gjahr      TYPE gjahr,
             belnr      TYPE belnr_d,
             docln      TYPE docln6,
             rmvct      TYPE rmvct,
             awtyp      TYPE awtyp,
             aworg      TYPE aworg,
             awref      TYPE awref,
             awitem     TYPE fins_awitem,
             anbwa      TYPE anbwa,
             xreversing TYPE acdoca-xreversing,

             awtyp_rev  TYPE acdoca-awtyp_rev,
             aworg_rev  TYPE acdoca-aworg_rev,
             awref_rev  TYPE awref_rev,

             rmvct_new  TYPE rmvct,
           END OF ts_data.

    DATA mt_data TYPE STANDARD TABLE OF ts_data.

ENDCLASS.


CLASS lcl_main IMPLEMENTATION.
  METHOD start_of_selection.
    DATA(lv_updated) = 0.
    SELECT *
      FROM acdoca
     WHERE rbukrs = @p_bukrs
       AND gjahr  = @p_gjahr
       AND poper  IN @so_poper
       AND belnr  IN @so_belnr
      INTO CORRESPONDING FIELDS OF TABLE @mt_data.

    LOOP AT mt_data ASSIGNING FIELD-SYMBOL(<ls_data>).

      IF <ls_data>-xreversing = abap_false.
        IF <ls_data>-anbwa IS NOT INITIAL.
          SELECT SINGLE *
            FROM tabw
           WHERE bwasl = @<ls_data>-anbwa
            INTO @DATA(ls_tabw).
          IF sy-subrc = 0.
            <ls_data>-rmvct_new = ls_tabw-bwakon.
            ADD 1 TO lv_updated.
          ENDIF.
        ENDIF.
      ELSE.
        READ TABLE mt_data ASSIGNING FIELD-SYMBOL(<ls_data_storno>) WITH KEY awtyp = <ls_data>-awtyp_rev
                                                                             aworg = <ls_data>-aworg_rev
                                                                             awref = <ls_data>-awref_rev.
        IF sy-subrc = 0.
          <ls_data>-rmvct_new = <ls_data_storno>-rmvct.
          ADD 1 TO lv_updated.
          CONTINUE.
        ENDIF.

        SELECT SINGLE rmvct
          FROM acdoca
         WHERE rldnr = '0L'
           AND awtyp    = @<ls_data>-awtyp_rev
           AND aworg    = @<ls_data>-aworg_rev
           AND awref    = @<ls_data>-awref_rev
           AND xreversed = @abap_true
          INTO @DATA(lv_rmvct_new).
        IF sy-subrc = 0.
          <ls_data>-rmvct_new = lv_rmvct_new.
          ADD 1 TO lv_updated.
        ENDIF.
      ENDIF.
    ENDLOOP.

    MESSAGE s001(00) WITH lv_updated.
  ENDMETHOD.


  METHOD end_of_selection.
    TRY.
        cl_salv_table=>factory( IMPORTING r_salv_table = DATA(lo_salv)
                                CHANGING  t_table      = mt_data ).
        lo_salv->get_functions( )->set_all( ).
        lo_salv->display( ).
      CATCH cx_salv_msg cx_salv_not_found INTO DATA(lx_error).
        cl_demo_output=>display( lx_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
