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

<%@ page import="com.apconsulting.luna.ejb.Rischio.*" %>
<%@ page import="com.apconsulting.luna.ejb.Azienda.*" %>

<div id="div_file">
    <%@ include file="../src/com/apconsulting/pseudoejb/EntityContextWrapper.jsp" %>
    <%@ include file="../src/com/apconsulting/pseudoejb/BMPEntityBean.jsp" %>
    <%@ include file="../src/com/apconsulting/pseudoejb/ContextWrapper.jsp" %>
    <%@ include file="../src/com/apconsulting/luna/util/Security.jsp" %>
    <%@ include file="../src/com/apconsulting/luna/util/Formatter.jsp" %>

    <%@ include file="../_include/Checker.jsp" %>
    <%
            response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
            response.setHeader("Pragma", "no-cache"); //HTTP 1.0
            response.setDateHeader("Expires", 0); //prevents caching at the proxy server
            //---------------------------------------------------------------------------------------
            long lCOD_AZL = new Long(request.getParameter("COD_AZL")).longValue();
            //long lCOD_AZL = Security.getAzienda();
            long lCOD_RSO = 0;
            long lCOD_FAT_RSO = 0;

            String strSTA_RSO = "";
            java.sql.Date dtDT_RIV_DAL = null;
            java.sql.Date dtDT_RIV_AL = null;
            String strRG_GROUP = "";
            String strRG_TIP_RSO = "";
            String strVAR_RIV = "";
            //String strTYPE="";
            String str = "";
            String strSel = "";
            String COLOR_TXT = "";
            String IMAGE = "";
            long range = 0;
            long PARENT_ID = 0;
            long ID = 0;
            java.util.Date cdt = new java.util.Date();
            java.sql.Date dtDAT_INZ = new java.sql.Date(cdt.getYear(), cdt.getMonth(), cdt.getDate());
            Checker c = new Checker();

            lCOD_RSO = c.checkLong("Rischio", request.getParameter("COD_RSO"), false);
            lCOD_FAT_RSO = c.checkLong("Fattorio di Rischio", request.getParameter("COD_FAT_RSO"), false);
            strRG_GROUP = c.checkString("Order", request.getParameter("RG_GROUP"), false);

            dtDT_RIV_AL = c.checkDate("Data Riv. AL", request.getParameter("DAT_RFC_VLU_RSO_AL"), false);

            dtDT_RIV_DAL = c.checkDate("Data Riv. DAL", request.getParameter("DAT_RFC_VLU_RSO_DAL"), false);

            strSTA_RSO = c.checkString("Stato", request.getParameter("STA_RSO"), false);
            strRG_TIP_RSO = c.checkString("Type", request.getParameter("RG_TIP_RSO"), false);
            strVAR_RIV = request.getParameter("TYPE");
            if (c.isError) {
                String err = c.printErrors();
                out.print("<script>alert(\"" + err + "\");</script>");
                return;
            }
            if ((dtDT_RIV_DAL != null) && (dtDT_RIV_AL != null)) {
                if (dtDT_RIV_DAL.compareTo(dtDT_RIV_AL) > 0) {
                    out.print("<script>parent.alert(arraylng[\"MSG_0086\"]);</script>");
                    return;
                }
            }
            int i = 0;
            IRischioHome home = (IRischioHome) PseudoContext.lookup("RischioBean");


            java.util.Collection col = null;
            if (("M".equals(strRG_TIP_RSO)) || ("L".equals(strRG_TIP_RSO))) {
                col = home.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDT_RIV_DAL, dtDT_RIV_AL, strRG_TIP_RSO, strRG_GROUP, strVAR_RIV);
            } else if ("E".equals(strRG_TIP_RSO)) {
                col = home.getRischio_collection_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDT_RIV_DAL, dtDT_RIV_AL, strRG_TIP_RSO, strRG_GROUP, strVAR_RIV);
               // col = home.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDT_RIV_DAL, dtDT_RIV_AL, "M", strRG_GROUP, strVAR_RIV);
               // col.addAll(
               //         home.getRischio_foo_SCHRIVRSO_View(lCOD_AZL, lCOD_RSO, lCOD_FAT_RSO, strSTA_RSO, dtDT_RIV_DAL, dtDT_RIV_AL, "L", strRG_GROUP, strVAR_RIV));
            }

            out.print("<table border='0' align='left' width='787' id='ListTable' class='dataTable' cellpadding='0' cellspacing='0'>");
            java.util.Iterator it = col.iterator();
            while (it.hasNext()) {
                COLOR_TXT = "";
                IMAGE = "";
                Rischio_foo_SCHRIVRSO_View obj = (Rischio_foo_SCHRIVRSO_View) it.next();
                if ("M".equals(strRG_TIP_RSO)) {
                    ID = obj.lCOD_RSO_MAN;
                    PARENT_ID = obj.lCOD_MAN;
                } else {
                    ID = obj.lCOD_RSO_LUO_FSC;
                    PARENT_ID = obj.lCOD_LUO_FSC;
                }
                out.print("<tr class='listTr' ID='tr" + obj.lCOD_RSO + "_" + i + "' onclick='selTrSCH_VST(4," + obj.lCOD_RSO + "," + i + ");' ondblclick='showDetailSCH_VST()' class='listTr'>");
                //str+="<td width='15%' align='center'>";
                if (dtDAT_INZ.compareTo(obj.dtDAT_RFS_VLU_RSO) > 0) {
                    COLOR_TXT = "style='color:red;'";
                    range = dtDAT_INZ.getTime() - obj.dtDAT_RFS_VLU_RSO.getTime();

                    if (range / (1000 * 3600 * 24) == 1) {
                        IMAGE = "../_images/1-r.gif";
                    }
                    if (range / (1000 * 3600 * 24) == 2) {
                        IMAGE = "../_images/2-r.gif";
                    }
                    if (range / (1000 * 3600 * 24) == 3) {
                        IMAGE = "../_images/3-r.gif";
                    }
                    if (range / (1000 * 3600 * 24) == 4) {
                        IMAGE = "../_images/4-r.gif";
                    }
                    if (range / (1000 * 3600 * 24) >= 5) {
                        IMAGE = "../_images/5-r.gif";
                    }
                } else if (dtDAT_INZ.compareTo(obj.dtDAT_RFS_VLU_RSO) == 0) {
                    COLOR_TXT = "style='color:blue;'";
                } else {
                    COLOR_TXT = "style='color:black;'";
                }
                out.print("<td width='40' style='border-left:none;border-bottom:none;border-top:none;'>");
                if (COLOR_TXT.equals("style='color:red;'")) {
                    out.print("<img src=" + IMAGE + ">");
                }
                out.print("</td>");
                out.print("<input type='hidden' id='PAR_ID" + obj.lCOD_RSO + "_" + i + "' value='" + PARENT_ID + "'>");
                out.print("<input type='hidden' id='_ID" + obj.lCOD_RSO + "_" + i + "' value='" + ID + "'>");
                out.print("<td class='dataTd'><input " + COLOR_TXT + " type='text' id='inp0" + obj.lCOD_RSO + "_" + i + "' readonly style='width: 140px;' class='dataInput' value=\"" + Formatter.format(obj.dtDAT_RFS_VLU_RSO) + "\"></td>");
                out.print("<td class='dataTd'><input " + COLOR_TXT + " type='text' id='inp1" + obj.lCOD_RSO + "_" + i + "' readonly style='width: 203px;' class='dataInput' value=\"" + Formatter.format(obj.strNOM_RSO) + "\"></td>");
                out.print("<td class='dataTd'><input type='text' " + COLOR_TXT + " id='inp2" + obj.lCOD_RSO + "_" + i + "' readonly style='width: 202px;' class='dataInput' value=\"" + Formatter.format(obj.strNOM_FAT_RSO) + "\"></td>");
                out.print("<td class='dataTd'><input type='text' " + COLOR_TXT + " id='inp3" + obj.lCOD_RSO + "_" + i + "' readonly style='width: 202px;' class='dataInput' value=\"" + Formatter.format(obj.strNOM_AZL) + "\"></td>");
                out.print("</tr>");
                i++;
            }
            out.print("</table>");
            //out.print(str);
            out.print("<script>parent.document.all['kolTr'].value=" + i + ";</script>");

    %>
</div>
<script>
    parent.document.all['div_s'].innerHTML=document.all['div_file'].innerHTML;
</script>
<%
            if (i > 0) {
%>
<script>
    if(parent.document.all['first'].value!="1")
    {
        parent.document.all['pifTd'].style.cursor='hand';
        parent.document.all['pifDw'].style.display='';
        parent.document.all['first'].value="1";
    }
</script>
<%    }
%>
