/**   ======================================================================== */
/**                                                                            */
/** @copyright Copyright (c) 2010-2015, S2S s.r.l. */
/** @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 */
/** @version   6.0  */
/** This file is part of SdS - Sistema della Sicurezza  . */
/** SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify */
/** it under the terms of the GNU General Public License as published by  */
/** the Free Software Foundation, either version 3 of the License, or  */
/** (at your option) any later version.  */

/** SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, */
/** but WITHOUT ANY WARRANTY; without even the implied warranty of */
/** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the */
/** GNU General Public License for more details. */

/** You should have received a copy of the GNU General Public License */
/** along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 */
/**                                                                            */
/**   ======================================================================== */

//2015.01.21 versione per lista DPD
var originalRowHeader;

function eventFired(type) {
    //
}

function setRowSelection(row) {
    if ($(row).hasClass("dataTrSelected") || $(row).hasClass("dataTrSelected_DIP_CESSATO"))
    {
        $(row).removeClass('odd');
        $(row).removeClass('even');
    }
}

function setFixedCellHeight(row) {
    $(row).children().each(function(index, td) {
        var div = document.createElement('div');
        div.innerHTML = $(td).html();
        $(td).empty();
        $(td).append(div);
    });
}

function OnInit(obj, pInitialize) {
    divTable.innerHTML = obj.outerHTML;

    tab = divContent.getElementsByTagName("TABLE")[0];
    tab.id = "dataTable";

    g_Clear();
    pInitialize();
    window.status = "Loaded";

    var asInitVals = new Array();

    var oTable = new Object();
    if (parent.g_Handler.dataTableOn == "Y"){
        oTable = initDataTableWidthDefined(tab);
    }
    else{
         oTable = initDataTableWidthBASE(tab);
    }

    oTable.fnSort([[1, 'asc']]);

    $("tfoot input").keyup(function() {
        /* Filter on the column (the index) of this element */
        oTable.fnFilter(this.value, $("tfoot input").index(this));
    });

    /*
     * Support functions to provide a little bit of 'user friendlyness' to the textboxes in 
     * the footer
     */

    $("tfoot input").each(function(i) {
        asInitVals[i] = this.value;
    });

    $("tfoot input").focus(function() {
        if (this.className === "search_init")
        {
            this.className = "search_init_select";
            this.value = "";
        }
    });

    $("tfoot input").blur(function(i) {
        if (this.value === "")
        {
            this.className = "search_init";
            this.value = asInitVals[$("tfoot input").index(this)];
        }
    });


}

//
//Definizione DataTable con Tabelle la cui larghezza delle colonne  NON è definita.
//BASE
function initDataTableWidthBASE(tab) {
    var oTable = $('#' + tab.id)
            .bind('sort', function() {
                eventFired('Sort');
            })
            .bind('filter', function() {
                eventFired('Filter');
            })
            .bind('page', function() {
                eventFired('Page');
            })
            .dataTable({
                "iDisplayStart": 0,
                "iDisplayLength": 10,
                "bLengthChange": false,
                "sPaginationType": "full_numbers",
                "sDom": 'T<"clear">lfrtip',
                "oLanguage": {
                    "sSearch": "Cerca su tutte le colonne:",
                    "oPaginate": {
                        "sFirst": "Prima pagina",
                        "sPrevious": "precedente",
                        "sNext": "successiva",
                        "sLast": "Ultima pagina"
                    },
                    "sInfo": "Visualizzate da _START_ a _END_ su _TOTAL_ voci",
                    "sInfoEmpty": "Visualizzate da _END_ a _END_ su _TOTAL_ voci",
                    "sInfoFiltered": " - (filtrate da _MAX_ voci totali)",
                    "sZeroRecords": "Nessuna voce trovata"
                },
                "oTableTools": {
                    "sSwfPath": "_scripts/dataTable/media/swf/copy_csv_xls_pdf.swf",
                    "aButtons": [
                        {
                            "sExtends": "copy",
                            "sButtonText": "Copia negli appunti"
                        },
                        /*
                         {
                         "sExtends": "csv"
                         },
                         */
                        {
                            "sExtends": "xls"
                            , "sButtonText": "Esporta in Excel"
                        },
                        {
                            "sExtends": "pdf"
                            , "sButtonText": "Esporta in PDF"
                        },
                        /*
                         {
                         "sExtends":    "collection",
                         "sButtonText": "Esporta in...",
                         "aButtons":    [ "csv", "xls", "pdf" ]
                         },
                         */
                        {
                            "sExtends": "print",
                            "sButtonText": "Stampa",
                            "fnClick": function(nButton, oConfig) {
                                this.fnPrint(true, oConfig);
                                // Può essere utile per aggiungere in futuro delle funzionalità subito dopo la preparazione della pagina di stampa.
                            }
                        }
                    ]
                },
                "sSortDataType": "dom-text",
                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    setRowSelection(nRow);
                },
                "fnCreatedRow": function(nRow, aData, iDataIndex) {
                    // setFixedCellHeight(nRow);
                },
               "fnDrawCallback": function ( oSettings ) {
            /* Need to redo the counters if filtered or sorted */
                    var that = this;
                    if (oSettings.bSorted || oSettings.bFiltered)
                    {
                        this.$('td:first-child', {"filter": "applied"}).each(function(i) {
                            that.fnUpdate(i + 1, this.parentNode, 0, false, false);
                        });
                    }
                }
                , "aaSorting": [[1, 'asc']]
            });



    return oTable;
}
//
//Definizione DataTable con Tabelle la cui larghezza delle colonne è definita.
//
function initDataTableWidthDefined(tab) {
 
    var thisArrayWidth = parent.g_Handler.dataTableArrayWidth;

    var oTable = $('#' + tab.id)
            .bind('sort', function() {
                eventFired('Sort');
            })
            .bind('filter', function() {
                eventFired('Filter');
            })
            .bind('page', function() {
                eventFired('Page');
            })
            .dataTable({
                "iDisplayStart": 0,
                "iDisplayLength": 10,
                "bLengthChange": false,
                "sPaginationType": "full_numbers",
                "sDom": 'T<"clear">lfrtip',
                "oLanguage": {
                    "sSearch": "Cerca su tutte le colonne:",
                    "oPaginate": {
                        "sFirst": "Prima pagina",
                        "sPrevious": "precedente",
                        "sNext": "successiva",
                        "sLast": "Ultima pagina"
                    },
                    "sInfo": "Visualizzate da _START_ a _END_ su _TOTAL_ voci",
                    "sInfoEmpty": "Visualizzate da _END_ a _END_ su _TOTAL_ voci",
                    "sInfoFiltered": " - (filtrate da _MAX_ voci totali)",
                    "sZeroRecords": "Nessuna voce trovata"
                },
                "oTableTools": {
                    "sSwfPath": "_scripts/dataTable/media/swf/copy_csv_xls_pdf.swf",
                    "aButtons": [
                        {
                            "sExtends": "copy",
                            "sButtonText": "Copia negli appunti"
                        },
                        {
                            "sExtends": "xls"
                            , "sButtonText": "Esporta in Excel"
                        },
                        {
                            "sExtends": "pdf"
                            , "sButtonText": "Esporta in PDF"
                        },
                        {
                            "sExtends": "print",
                            "sButtonText": "Stampa",
                            "fnClick": function(nButton, oConfig) {
                                this.fnPrint(true, oConfig);
                                // Può essere utile per aggiungere in futuro delle funzionalità subito dopo la preparazione della pagina di stampa.
                            }
                        }
                    ]
                },
                "sSortDataType": "dom-text",
                "aoColumnDefs": thisArrayWidth,
                "fnRowCallback": function(nRow, aData, iDisplayIndex, iDisplayIndexFull) {
                    setRowSelection(nRow);
                },
                "fnCreatedRow": function(nRow, aData, iDataIndex) {
                    // setFixedCellHeight(nRow);
                },
                "fnDrawCallback": function ( oSettings ) {
            /* Need to redo the counters if filtered or sorted */
                    var that = this;
                    if (oSettings.bSorted || oSettings.bFiltered)
                    {
                        this.$('td:first-child', {"filter": "applied"}).each(function(i) {
                            that.fnUpdate(i + 1, this.parentNode, 0, false, false);
                        });
                    }
                }
                , "aaSorting": [[1, 'asc']]
            });
       

    return oTable;
}

 
