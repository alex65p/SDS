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

<%
    /*
    <file>
    <versions>
    <version number="1.0" date="19/10/2004" author="Artur Denysenko">
    <comments>
    <comment date="19/10/2004" author="Artur Denysenko">
    <description>Chernovik interfeisa searcha</description>
    </comment>
    <comment date="19/10/2004 author="Artur Denysenko">
    <description>API esho ne stabilizirovalos'</description>
    </comment>
    </comments>
    </version>
    </versions>
    </file>
     */
    response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
    response.setHeader("Pragma", "no-cache"); //HTTP 1.0
    response.setDateHeader("Expires", 0); //prevents caching at the proxy server

%>
<%@ include file="_include/Global.jsp" %>
<%@ include file="src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>

<script src="_scripts/scrollTable.js" type="text/javascript"></script>
<script src='_scripts/help.js' language='JavaScript1.2' type='text/javascript'></script>
<html>
    <head><title>Ricerca</title></head>
    <body>
        <link rel="stylesheet" href="_styles/search.css">
        <link rel="stylesheet" href="_styles/tabs.css">
        <%
            String u = "";
            try {
                u = request.getParameter("URL");
                u = u.replace('|', '&');
            } catch (Exception ex) {
                out.print(ex.getMessage());
            }
        %>
        <form action="<%=u%>" name="frmMain" target="frameView" method="POST" onsubmit="g_OnSubmit()">
            <table id="tblAll" border=0 width=100% height=100% style="display:block">
                <tr>
                    <td align=left width="100%" height="100%" valign=top>
                        <table border=0 width="100%" height="100%" >
                            <tr valign='top'>
                                <td  valign=top cellspacing='0' style='width:10px'>
                                </td>
                                <td style="width:7px"></td>
                                <td align="top">
                                    <table height="100%" width="100%" cellpadding='0' cellspacing='0' border=0  >
                                        <tr style='height:30px;'>
                                            <td valign="top" width="100%" class="title"><h2 id="lbCaption" class="h2" size="5">Loading ...</h2></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <button id='btnRefresh' onclick='g_OnRefresh(this)' title='<%=ApplicationConfigurator.LanguageManager.getString("Refresh")%>'><img src='_images/new/REFRESH.GIF'></button>&nbsp;&nbsp;&nbsp;
                                                <button id='btnPrint' onclick='g_OnPrint(this)' disabled title='<%=ApplicationConfigurator.LanguageManager.getString("Stampa")%>'><img src='_images/new/PRINT.GIF'></button>&nbsp;&nbsp;&nbsp;
                                                <!--<button id='btnPrint3' onclick='g_OnPrint3(this)' disabled title='<%=ApplicationConfigurator.LanguageManager.getString("Stampa")%>'><img src='_images/new/PRINT.GIF'></button>&nbsp;&nbsp;&nbsp;-->
                                                <button id='btnOk' onclick='g_OnOk()' disabled title='<%=ApplicationConfigurator.LanguageManager.getString("Associa.dati")%>'><img src='_images/new/RETURN.GIF'></button>&nbsp;&nbsp;&nbsp;
                                                <button id='btnExit' onclick='g_OnCancel()' title='<%=ApplicationConfigurator.LanguageManager.getString("Uscita")%>'><img src='_images/new/EXIT.GIF'></button>&nbsp;&nbsp;&nbsp;
                                                <!--button id='btnHelp' onclick='g_OnHelp(this)' title='Help'><img src='_images/new/HELP.GIF'></button-->
                                            </td>
                                        </tr>

                                        <tr><td style="height:5px;"></td></tr>
                                        <tr style="height:100%; border:0" >
                                            <td valign=top align=left style="height:100%" >
                                                <div id="headerContainer" style="border:0px solid green; position: absolute; z-index:2; overflow:hidden">
                                                </div>
                                                <div id="divTable" style="border:#000; overflow: auto; height:100%; width:95%">
                                                </div>
                                                <div id="dataContainer" style="border:#000; width:95%; height:100%;overflow: auto; z-index:1;" >
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td  <%if (RELEASE) {
                            out.print(" style='display:none'");
                        }%> >
                        <iframe id="frameView" style="width:100%" src="<%=u%>"></iframe><br>
                    </td>
                </tr>
            </table>
            <style>
                divTable.TABLE{ cursor: pointer}
            </style>
            <script>
                var g_Handler = null;
                var g_objCurrentRow=null;

                function g_LoadView(url){
                    if(url==null) return;
                    g_navigateFrame(frameView, url);
                }

                function g_navigateFrame(frame, url){
                    alert(url)
                    frame.document.location.reload(true);
                }

                function g_Clear(){
                    g_objCurrentRow=null;
                    g_Handler = new Object();

                    //<not-used>
                    g_Handler.New=new Object();
                    g_Handler.New.OnBefore=null;
                    g_Handler.New.OnAfter=null;
                    g_Handler.New.URL="";
                    g_Handler.New.Width=0;
                    g_Handler.New.Height=0;

                    g_Handler.Delete=new Object();
                    g_Handler.Delete.URL="";
                    g_Handler.Delete.OnBefore=null;
                    g_Handler.Delete.OnAfter=null;

                    g_Handler.Open=new Object();
                    g_Handler.Open.URL="";
                    g_Handler.Open.OnBefore=null;
                    g_Handler.Open.OnAfter=null;

                    g_Handler.Help=new Object();
                    g_Handler.Help.URL="";
                    g_Handler.Help.OnBefore=null;
                    g_Handler.Help.OnAfter=null;

                    g_Handler.Delete.getButton=function(){return new Object();};
                    g_Handler.Delete.getButton().disabled=false;
                    //</not-used>

                    g_Handler.OnRowClick=g_OnRowClick;
                    g_Handler.OnRowDblClick=g_OnRowDblClick;

                    g_Handler.OnViewChange=g_OnViewChange;
                    g_Handler.setCaption=g_setCaption;
                    g_Handler.setCaptionHTML=g_setCaptionHTML;

                    var btn=document.getElementById("btnOk");
                    if (btn!=null) btn.disabled=true;
                    window.status="Loading..";
                }

                function g_OnPrint(){
                }

                function g_setCaption(strCaption){
                    lbCaption.innerText=strCaption;
                }

                function g_setCaptionHTML(strCaption){
                    lbCaption.innerHTML=strCaption.toUpperCase();
                }

                function g_getRowIndex(){
                    if(g_objCurrentRow==null) return null;
                    return g_objCurrentRow.getAttribute("INDEX");
                }

                function g_OnSubmit(){
                    if(frmMain.SEARCH_TEXT.value!="") return true;
                }

                function g_OnOk(){
                    window.returnValue="OK";
                    window.dialogArguments.ID=g_getRowIndex();
                    window.dialogArguments.CELLS=null;
                    if(g_objCurrentRow!=null){
                        window.dialogArguments.CELLS=new Array();
                        var i;
                        for(i=0; i<g_objCurrentRow.cells.length; i++){
                            window.dialogArguments.CELLS[i]=g_objCurrentRow.cells[i].innerText;
                        }
                    }
                    g_OnCancel();
                }

                function g_OnHelp(obj){
                    var HelpPar = "";
                    if (g_Handler.Help.URL.indexOf('?') > -1)
                        HelpPar = "&";
                    else
                        HelpPar = "?";
                    HelpPar += "HelpFrom=SEARCH";

                    if (g_Handler.Help.URL!=null && g_Handler.Help.URL!=""){
                        if(g_Handler.Help.OnBefore!=null){
                            if(!g_Handler.Help.OnBefore()) return;
                        }
                        g_openHelpWindow(g_Handler.Help.URL+HelpPar);
                        if(g_Handler.Help.OnAfter!=null){
                            g_Handler.Help.OnAfter()
                        }
                    }
                }

                function g_OnCancel(){
                    window.close();
                }

                function g_OnSearch(obj){
                }

                function g_OnRefresh(obj){
                    window.status="Loading ...";
                    g_setCaption("Loading ...");
                    divTable.innerHTML="";
                    document.all["frameView"].src=document.all["frameView"].src;
                }

                function g_OnViewChange(obj, pInitialize){
                    OnInit(obj, pInitialize);
                    return;
                    divTable.innerHTML=obj.outerHTML;
                    g_Clear()
                    pInitialize();
                    window.status="Loaded";
                }
                
                function g_getFeachures(obj){
                    return "dialogHeight:"+obj.Height+"; dialogWidth:"+obj.Width+";help:no;resizable:no;status:no;scroll:no;";
                }

                function g_preParseUrl(url){
                    url=url.replace("/luna", "<%=APP_VIRTUAL_PATH%>");
                    return url;
                }

                function g_showModalDialog(url, param, obj){
                    url = g_preParseUrl(url);
                    var strFeatures=g_getFeachures(obj);
                <%if (DEBUG) {%>
                        return window.open(url);
                <%} else {%>
                        return window.showModalDialog(url, null, strFeatures);
                <%}%>
                    }

                    //<ROW-EVENT-HANDLERS>
                    function g_OnRowClick(tr){
                        if(g_objCurrentRow!=null){
                            g_objCurrentRow.className="VIEW_TR";
                        }
                        g_objCurrentRow=tr;
                        g_objCurrentRow.className="dataTrSelected";
                        g_objCurrentRow.style.cursor="hand";
                        var btn=document.getElementById("btnOk");
                        btn.disabled=false;
                    }
                    function g_OnRowDblClick(tr){
                        g_OnOk(null);
                    }
                    //</ROW-EVENT-HANDLERS>

                    g_Clear();
            </script>
