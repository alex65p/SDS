<%--   ======================================================================== --%>
<%--                                                                            --%>
<%-- @copyright Copyright (c) 2010-2015, S2S s.r.l. --%>
<%-- @license   http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2 --%>
<%-- @version   6.0  --%>
<%-- This file is part of SdS - Sistema della Sicurezza  . --%>
<%-- SdS - Sistema della Sicurezza   is free software: you can redistribute it and/or modify --%>
<%-- it under the terms of the GNU General Public License as published by  --%>
<%-- the Free Software Foundation, either version 3 of the License, or  --%>
<%-- (at your option) any later version.  --%>

<%-- SdS - Sistema della Sicurezza  is distributed in the hope that it will be useful, --%>
<%-- but WITHOUT ANY WARRANTY; without even the implied warranty of --%>
<%-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the --%>
<%-- GNU General Public License for more details. --%>

<%-- You should have received a copy of the GNU General Public License --%>
<%-- along with SdS - Sistema della Sicurezza .  If not, see <http://www.gnu.org/licenses/gpl-2.0.html>  GNU Public License v.2 --%>
<%--                                                                            --%>
<%--   ======================================================================== --%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <link rel="shortcut icon" type="image/ico" href="http://www.datatables.net/favicon.ico">
        <meta name="viewport" content="initial-scale=1.0, maximum-scale=2.0">

        <title>TableTools example - Basic initialisation</title>
        <link rel="stylesheet" type="text/css" href="./testDT/dataTable/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="./testDT/dataTable/dataTables.tableTools.css">

        <style type="text/css" class="init">

        </style>        
        
        
        <script type='text/javascript' language='javascript' src='./testDT/jquery.js'></script>
        <script type="text/javascript" language="javascript" src="./testDT/jquery.dataTables1.js"></script>
        <script type="text/javascript" src="./testDT/date-euro.js"></script>

        
        
        
        <script type="text/javascript" language="javascript" class="init">


            $(document).ready(function() {

                var t = $('#tableEX').DataTable({
                    "iDisplayStart": 0,
                    "iDisplayLength": 5,
                    "bLengthChange": false,
                    "sPaginationType": "full_numbers",
                    "sDom": 'T<"clear">lfrtip',
                    "autoWidth": true,
                    "oLanguage": {
                        "sSearch": "Cerca su tutte le colonne:",
                        "oPaginate": {
                            "sFirst": "Prima pagina",
                            "sPrevious": "Precedente",
                            "sNext": "Successiva",
                            "sLast": "Ultima pagina"
                        },
                        "sInfo": "Visualizzate da _START_ a _END_ su _TOTAL_ voci",
                        "sInfoEmpty": "Visualizzate da _END_ a  _END_ su _TOTAL_ voci",
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
                                    // Pu??? essere utile per aggiungere in futuro delle funzionalit??? subito dopo la preparazione della pagina di stampa.
                                }
                            }
                        ]
                    },
                    "sSortDataType": "dom-text",
                    "aoColumnDefs": [
                        {"bSortable": false, "bOrderable": false, "aTargets": [0]},
                        {"sWidth": "15%", "aTargets": [0], "sType": "numeric"},
                        {"sWidth": "30%", "aTargets": [1], "sType": "string"},
                        {"sWidth": "35%", "aTargets": [2], "sType": "string"},
                        {"sWidth": "10%", "aTargets": [3], "sType": "numeric"},
                        {"sWidth": "10%", "aTargets": [4], "sType": "date-uk"},
                        {"sWidth": "10%", "aTargets": [5], "sType": "string"}],
                    /*  "fnDrawCallback": function ( oSettings ) {
               
                     if ( oSettings.bSorted || oSettings.bFiltered )
                     {
                     this.$('td:first-child', {"filter":"applied"}).each( function (i) {
                     that.fnUpdate( i+1, this.parentNode, 0, false, false );
                     } );
                     }
                     } ,          */


                    "aaSorting": [[1, 'asc']]



                });

                t.on('order.dt search.dt', function() {
                    t.column(0, {search: 'applied', order: 'applied'}).nodes().each(function(cell, i) {
                        cell.innerHTML = i + 1;
                    });
                }).draw();

            });


        </script>
    </head>

    <body class="dt-example">
        <div class="container">
            <section>
                <h1>TableTools example <span>Basic initialisation</span></h1>

                <table id="tableEX" class="display" cellspacing="0" width="100%">
                    <thead>
                        <tr>
                            <th></th>
                            <th>Position</th>
                            <th>Office</th>
                            <th>Age</th>
                            <th>Start date</th>
                            <th>Salary</th>
                        </tr>
                    </thead>

                    <tfoot>
                        <tr>
                            <th></th>
                            <th>Position</th>
                            <th>Office</th>
                            <th>Age</th>
                            <th>Start date</th>
                            <th>Salary</th>
                        </tr>
                    </tfoot>

                    <tbody>
                        <tr>
                            <td></td>
                            <td>System Architect</td>
                            <td>Edinburgh</td>
                            <td>61</td>
                            <td>25/04/2011</td>
                            <td>$320,800</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Accountant</td>
                            <td>Tokyo</td>
                            <td>63</td>
                            <td>01/07/2011</td>
                            <td>$170,750</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Junior Technical Author</td>
                            <td>San Francisco</td>
                            <td>66</td>
                            <td>01/01/2009</td>
                            <td>$86,000</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Senior Javascript Developer</td>
                            <td>Edinburgh</td>
                            <td>22</td>
                            <td>01/03/2012</td>
                            <td>$433,060</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Accountant</td>
                            <td>Tokyo</td>
                            <td>33</td>
                            <td>01/11/2008</td>
                            <td>$162,700</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Integration Specialist</td>
                            <td>New York</td>
                            <td>61</td>
                            <td>01/12/2012</td>
                            <td>$372,000</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Sales Assistant</td>
                            <td>San Francisco</td>
                            <td>59</td>
                            <td>01/08/2012</td>
                            <td>$137,500</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Integration Specialist</td>
                            <td>Tokyo</td>
                            <td>55</td>
                            <td>01/10/2010</td>
                            <td>$327,900</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Javascript Developer</td>
                            <td>San Francisco</td>
                            <td>39</td>
                            <td>01/09/2009</td>
                            <td>$205,500</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Software Engineer</td>
                            <td>Edinburgh</td>
                            <td>23</td>
                            <td>01/12/2008</td>
                            <td>$103,600</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Office Manager</td>
                            <td>London</td>
                            <td>30</td>
                            <td>19/12/2008</td>
                            <td>$90,560</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Support Lead</td>
                            <td>Edinburgh</td>
                            <td>22</td>
                            <td>03/03/2013</td>
                            <td>$342,000</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Regional Director</td>
                            <td>San Francisco</td>
                            <td>36</td>
                            <td>16/10/2008</td>
                            <td>$470,600</td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>Senior Marketing Designer</td>
                            <td>London</td>
                            <td>43</td>
                            <td>18/12/2012</td>
                            <td>$313,500</td>
                        </tr>

                        <tr>
                            <td></td>
                            <td>Customer Support</td>
                            <td>New York</td>
                            <td>27</td>
                            <td>25/01/2011</td>
                            <td>$112,000</td>
                        </tr>
                    </tbody>
                </table>



                <div class="tabs">






                </div>
            </section>
        </div>


    </body>
</html>
