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
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>
<%@ page import="com.apconsulting.luna.ejb.Ruoli.*" %>

<%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
<%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
<%@ include file="../src/com/apconsulting/luna/conf/ApplicationConfigurator.jsp" %>
<%@ include file="../_include/Checker.jsp" %>

<script type="text/javascript">
    var err=false;
    var isNew=false;
</script>
<script type="text/javascript" src="../_scripts/Alert.js"></script>
<%
            String ReqMODE = "";
            IRuoli Ruoli = null;
            long lCOD_RUO = 0;

            if (request.getParameter("SBM_MODE") != null) {
                ReqMODE = request.getParameter("SBM_MODE");
                Checker c = new Checker();
                
//- checking for required fields		
                lCOD_RUO = c.checkLong(ApplicationConfigurator.LanguageManager.getString("Ruolo"), request.getParameter("RUO_ID"), true);
                String strNOM_RUO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Ruolo"), request.getParameter("RUOLO"), true);
                String strDES_RUO = c.checkString(ApplicationConfigurator.LanguageManager.getString("Descrizione"), request.getParameter("DESC"), true);

                if (c.isError) {
                    String err = c.printErrors();
                    out.println("<script>alert(\"" + err + "\");</script>");
                    return;
                }

                if (ReqMODE.equals("edt")) {
                    IRuoliHome home = (IRuoliHome) PseudoContext.lookup("RuoliBean");
                    try {
                        String strCOD_RUO = request.getParameter("RUO_ID");
                        Long ruo_id = new Long(strCOD_RUO);
                        Ruoli = home.findByPrimaryKey(ruo_id);
                        Ruoli.setNOM_RUO(strNOM_RUO);
                        Ruoli.setDES_RUO(strDES_RUO);
                        String index = "";
                        String tip_ace = "";
                        Vector lstCOD_FUZ = Ruoli.getCODFUZList();
                        for (int i = 0; i < lstCOD_FUZ.size(); i++) {
                            long id = ((Long) lstCOD_FUZ.get(i)).longValue();
                            {
                                index = new String(Long.toString(id)) + "T";
                                tip_ace = request.getParameter(index);
                                if (tip_ace == null) {
                                    tip_ace = " ";
                                }
                                if (tip_ace.equals("G")) {
                                    tip_ace = "XXXXXXXXXXX0000";
                                } else if (tip_ace.equals("L")) {
                                    tip_ace = "X0X000XX0XX0000";
                                } else {
                                    tip_ace = " ";
                                }
                                try {
                                    Ruoli.setTIP_ACE(lCOD_RUO, id, tip_ace);
                                } catch (Exception ex) {
                                    Ruoli.addTIP_ACE(lCOD_RUO, id, tip_ace);
                                }
                            }
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                }
                if (ReqMODE.equals("new")) {
                    IRuoliHome home = (IRuoliHome) PseudoContext.lookup("RuoliBean");
%><script type="text/javascript">isNew=true;</script><%
                    try {
                        Ruoli = home.create(strNOM_RUO, strDES_RUO);
                        Vector lstCOD_FUZ = Ruoli.getCODFUZList();
                        String index = "";
                        String tip_ace = "";
                        for (int i = 0; i < lstCOD_FUZ.size(); i++) {
                            long id = ((Long) lstCOD_FUZ.get(i)).longValue();
                            {
                                index = new String(Long.toString(id)) + "T";
                                tip_ace = request.getParameter(index);
                                if (tip_ace == null) {
                                    tip_ace = " ";
                                }
                                if (tip_ace.equals("G")) {
                                    tip_ace = "XXXXXXXXXXX0000";
                                } else if (tip_ace.equals("L")) {
                                    tip_ace = "X0X000XX0XX0000";
                                } else {
                                    tip_ace = " ";
                                }
                                Ruoli.addTIP_ACE(Ruoli.getCOD_RUO(), id, tip_ace);
                            }
                        }
                    } catch (Exception ex) {
                        ex.printStackTrace();
                        out.print("<script>Alert.Error.showDublicate();err=true;</script>");
                        return;
                    }
                }
                if (Ruoli != null) {
//   *Not require Fields*
                }
            }
%>	
<script type="text/javascript">
    if(!err){
    parent.returnValue="OK";
    if(isNew){
    Alert.Success.showCreated();
    parent.ToolBar.OnNew("ID=<%=Ruoli.getCOD_RUO()%>");
    }else{
    Alert.Success.showSaved();
    parent.ToolBar.OnNew("ID=<%=Ruoli.getCOD_RUO()%>");
    }
    }else{
    parent.returnValue="ERROR";
    }
</script>
