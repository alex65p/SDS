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

package s2s.luna.Toolbar;

import javax.servlet.http.*;
import s2s.luna.ejb.Security.Security.*;
import s2s.luna.util.SecurityWrapper;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.luna.conf.ModuleManager.MODULES;

public class Toolbar{
    
    public String strEditUrl, strDeleteUrl, strCopyUrl, strPrintUrl, strSearchUrl, strAttachUrl, strPrintUrl2, strPrintUrl3, strHelpUrl, strEnableUrl;
    public String strQueryString;
    
    public boolean Debug = false;
    
    HttpServletRequest request;
    
    public boolean bCanEdit, bCanSearch, bCanSave,bCanDelete, bCanEnable,bCanPrint, bCanNew, bCanReturn, bCanExit;
    public boolean bShowSearch, bShowSave,bShowDelete,bShowEnable,bShowPrint, bShowNew, bShowReturn, bShowExit, bShowHelp;
    
    //public boolean bCanEnable=false;
    public boolean bShowDetail=false, bCanDetail=false;
    public boolean bShowPrint2=false, bCanPrint2=false;
    public boolean bShowPrint3=false, bCanPrint3=false;
    public boolean bCanAssociateCreate = false;
    public boolean bCanAssociateDelete = false;
    public boolean bAlwaysShowPrint = false;
    public boolean bShowAziende = false;
    public boolean bShowCopyFrom=false, bCanCopyFrom=false;
    
    // Dario Massaroni
    
    // Gestisce la possibilità di visualizzare un messaggio a lato della toobar.
    // nello style passato in input.
    private String message = "";
    private String messageStyle = "toolBarMessage";
    
    // Dario MAssaroni
    
    // Gestisce la possibilità di cambiare il titolo dei bottoni della toolbar.
    // nello style passato in input.
    private String btnNew_title = ApplicationConfigurator.LanguageManager.getString("Nuovo");
    private String btnCopy_title = ApplicationConfigurator.LanguageManager.getString("Copia");
    private String btnSearch_title = ApplicationConfigurator.LanguageManager.getString("Ricerca");
    private String btnDetail_title = ApplicationConfigurator.LanguageManager.getString("Dettaglio");
    private String btnSave_title = ApplicationConfigurator.LanguageManager.getString("Salva");
    private String btnDelete_title = ApplicationConfigurator.LanguageManager.getString("Elimina.record");
    private String btnPrint_title = ApplicationConfigurator.LanguageManager.getString("Stampa");
    private String btnPrint2_title = ApplicationConfigurator.LanguageManager.getString("Stampa.multiazienda");
    private String btnPrint3_title = ApplicationConfigurator.LanguageManager.getString("Stampa");
    private String btnAziende_title = ApplicationConfigurator.LanguageManager.getString("Elenco.delle.aziende");
    private String btnExit_title = ApplicationConfigurator.LanguageManager.getString("Uscita");
    private String btnReturn_title = ApplicationConfigurator.LanguageManager.getString("Associa.dati");
    private String btnHelp_title = ApplicationConfigurator.LanguageManager.getString("Help");
    private String btnEnable_title = ApplicationConfigurator.LanguageManager.getString("Abilita.record");

//<alex>
    public java.util.ArrayList pFields = new java.util.ArrayList();
    
    
    public Toolbar(HttpServletRequest request){
        this.request=request;
        strEditUrl=request.getRequestURI();
        
        String strRefreshFlag="&RELOAD";
        
        strDeleteUrl=Replace(strEditUrl, "_Form.jsp", "_Delete.jsp?")+request.getQueryString();
        strCopyUrl=Replace(strEditUrl, "_Form.jsp", "_Copy.jsp?")+request.getQueryString();
        strPrintUrl=null;//Replace(strEditUrl,  "_Form.jsp", "_Print.jsp?")+request.getQueryString();
        strSearchUrl=Replace(strEditUrl, "_Form.jsp", "_View.jsp?")+request.getQueryString();
        strHelpUrl=Replace(strEditUrl, "_Form.jsp", "_Help.jsp");
        strEnableUrl=Replace(strEditUrl, "_Form.jsp", "_Enable.jsp?")+request.getQueryString();
        
        if(request.getParameter("ATTACH_URL")!=null){
            int li=strEditUrl.indexOf("Form_");
            if(li==-1) li=0;
            strAttachUrl=strEditUrl.substring( 0, li);
            strAttachUrl+=request.getParameter("ATTACH_URL")+"?"+request.getQueryString();
        }
        
        strQueryString=request.getQueryString();
        if(strQueryString!=null){
            strQueryString=Replace(strQueryString, "ID=", "IDD=");
            strEditUrl+="?"+strQueryString;
        } else{
            strEditUrl+="?";
        }
        
        bCanEdit=hasId(request.getParameter("ID"));
        bCanSearch=true;
        bCanSave=true;
        bCanDelete=bCanEdit;
        //bCanEnable=bCanEdit;
        bCanPrint=bCanEdit;
        bCanNew=true;
        bCanReturn=true;
        bCanExit=true;
        bCanReturn=(bCanEdit && request.getParameter("IDD")!=null);// esli est' ID togda
        
        bShowSearch=bShowSave=bShowDelete=bShowNew=bShowReturn=bShowExit=true;
        // bShowHelp=true;
        
        bShowPrint=bCanEdit;
        if(request.getParameter("ID_PARENT")==null) bShowReturn=false;
        //bShowExit=false;
        bCanCopyFrom=true;
    }
    
    //  Metodi Get e Set
    //  message
    public String getMessage(){
        return message;
    }
    
    public void setMessage(String _message){
        message = _message;
    }

    //  messageStyle
    public String getMessageStyle(){
        return messageStyle;
    }

    public void setMessageStyle(String _style){
        messageStyle = _style;
    }
        
    // btnNew_title
    public String getBtnNew_title(){
        return btnNew_title;
    }

    public void setBtnNew_title(String _btnNew_title){
        btnNew_title = _btnNew_title;
    }

    // btnCopy_title
    public String getBtnCopy_title(){
        return btnCopy_title;
    }

    public void setBtnCopy_title(String _btnCopy_title){
        btnCopy_title = _btnCopy_title;
    }
    
    // btnSearch_title
    public String getBtnSearch_title(){
        return btnSearch_title;
    }

    public void setBtnSearch_title(String _btnSearch_title){
        btnSearch_title = _btnSearch_title;
    }
    
    // btnDetail_title
    public String getBtnDetail_title(){
        return btnDetail_title;
    }

    public void setBtnDetail_title(String _btnDetail_title){
        btnDetail_title = _btnDetail_title;
    }

    // btnSave_title            
    public String getBtnSave_title(){
        return btnSave_title;
    }

    public void setBtnSave_title(String _btnSave_title){
        btnSave_title = _btnSave_title;
    }

    // btnDelete_title
    public String getBtnDelete_title(){
        return btnDelete_title;
    }
    
   
    public void setBtnDelete_title(String _btnDelete_title){
        btnDelete_title = _btnDelete_title;
    }
    
     // btnEnable_title
    public String getBtnEnable_title(){
        return btnEnable_title;
    }
    
    public void setBtnEnable_title(String _btnEnable_title){
        btnEnable_title = _btnEnable_title;
    }
    
    // btnPrint_title
    public String getBtnPrint_title(){
        return btnPrint_title;
    }

    public void setBtnPrint_title(String _btnPrint_title){
        btnPrint_title = _btnPrint_title;
    }

    // btnPrint2_title
    public String getBtnPrint2_title(){
        return btnPrint2_title;
    }

    public void setBtnPrint2_title(String _btnPrint2_title){
        btnPrint2_title = _btnPrint2_title;
    }
    
    // btnPrint3_title
    public String getBtnPrint3_title(){
        return btnPrint3_title;
    }

    public void setBtnPrint3_title(String _btnPrint3_title){
        btnPrint3_title = _btnPrint3_title;
    }

    // btnAziende_title
    public String getBtnAziende_title(){
        return btnAziende_title;
    }

    public void setBtnAziende_title(String _btnAziende_title){
        btnAziende_title = _btnAziende_title;
    }
    
    // btnExit_title
    public String getBtnExit_title(){
        return btnExit_title;
    }

    public void setBtnExit_title(String _btnExit_title){
        btnExit_title = _btnExit_title;
    }
    
    // btnReturn_title
    public String getBtnReturn_title(){
        return btnReturn_title;
    }

    public void setBtnReturn_title(String _btnReturn_title){
        btnReturn_title = _btnReturn_title;
    }
    
    // btnHelp_title
    public String getBtnHelp_title(){
        return btnHelp_title;
    }

    public void setBtnHelp_title(String _btnHelp_title){
        btnHelp_title = _btnHelp_title;
    }
    
    public void applySecurity() throws Exception{
        SecurityUserPermissionDetails permission=SecurityWrapper.getInstance().getUserPermission(); //###Security
        if(bCanNew)bCanNew=permission.bCanCreate;
        if(bCanSave)bCanSave=permission.bCanSave;
        //bCanList=false;
        if(bCanSearch)bCanSearch=permission.bCanList;
        if(bCanDelete)bCanDelete=permission.bCanDelete;
        if(bCanEnable)bCanEnable=permission.bCanEnable;
        bCanAssociateCreate=permission.bCanAssociateCreate;
        bCanAssociateDelete=permission.bCanAssociateDelete;
        
        
        //permission.bCanAssociateCreate;
        //permission.bCanAssociateDelete;
        
        if(bCanPrint)bCanPrint=permission.bCanPrint;
        if(bCanPrint2)bCanPrint2=permission.bCanPrint2;
        if(bCanReturn)bCanReturn=permission.bCanReturn;
        if(bCanDetail)bCanDetail=permission.bCanDetalize;
        
        if(bCanCopyFrom)bCanCopyFrom=permission.bCanCopyFrom;
        
    }
    
    public String buildForHelp(int iRowspan) throws Exception{
        this.bShowDelete = false;
        this.bShowNew = false;
        this.bShowSearch = false;
        this.bShowSave = false;
        this.bShowHelp = false;
        return this.build(iRowspan);
    }
    
    public String build() throws Exception{
        return build(4);
    }

    public String build(int iRowspan) throws Exception{
        if(bShowPrint && strPrintUrl==null ) bShowPrint=false;
        if (bAlwaysShowPrint) bShowPrint=true;
        applySecurity();
        StringBuffer str=new StringBuffer();
        
        str.append("<tr><td style='width:10px' rowspan="+iRowspan+" valign=top cellspacing=''>\n");
        str.append("<style>\n");
        str.append("button { width: 25px}\n");
        str.append(".invisible {display:none}\n");
        str.append("</style>\n");
        str.append("<script src='../_include/ToolBar.js'></script>\n");
        str.append("<LINK REL=STYLESHEET HREF=\"../_styles/toolBar.css\" TYPE=\"text/css\">\n");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        
        // Nuovo
        str.append("<tr >");
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowNew)+">\n");
        str.append("<td><button id='btnNew' onclick='ToolBar.New.OnClick()' title='"+getBtnNew_title()+"' "+isDisabled(bCanNew)+"><img src='../_images/new/NEW.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Copia
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowCopyFrom)+">\n");
        str.append("<td><button id='btnCopy' onclick='ToolBar.Copy.OnClick()' title='"+getBtnCopy_title()+"' "+isDisabled(bCanCopyFrom)+"><img src='../_images/new/COPY.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");

        // Ricerca
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowSearch)+">");
        str.append("<td><button id='btnSearch' onclick='ToolBar.Search.OnClick()' title='"+getBtnSearch_title()+"' "+isDisabled(bCanSearch)+"><img src='../_images/new/SEARCH.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Dettaglio
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowDetail)+">");
        str.append("<td><button id='btnDetail' onclick='ToolBar.Detail.OnClick()' title='"+getBtnDetail_title()+"' "+isDisabled(bCanDetail)+"><img src='../_images/new/DETAILS.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Salva
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowSave)+">\n");
        str.append("<td><button id='btnSave' onclick='ToolBar.Save.OnClick()' title='"+getBtnSave_title()+"' "+isDisabled(bCanSave)+"><img src='../_images/new/SAVE.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Elimina Record       
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowDelete)+">\n");
        str.append("<td><button id='btnDelete' onclick='ToolBar.Delete.OnClick(" + ApplicationConfigurator.isModuleEnabled(MODULES.DEL_MSG_EXT) + ")' title='"+getBtnDelete_title()+"' "+isDisabled(bCanDelete)+"><img src='../_images/new/DELETE.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Abilita Record solo per MSR
        this.bCanEnable=true;
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowEnable)+">\n");
        str.append("<td><button id='btnEnable' onclick='ToolBar.Enable.OnClick()' title='"+getBtnEnable_title()+"' "+isDisabled(bCanEnable)+"><img src='../_images/Abilita.png'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Stampa
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowPrint)+">\n");
        str.append("<td><button id='btnPrint' onclick='ToolBar.Print.OnClick()' title='"+getBtnPrint_title()+"' "+isDisabled(bCanPrint)+"><img src='../_images/new/PRINT.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Stampa Multiazienda
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowPrint2)+">\n");
        str.append("<td><button id='btnPrint2' onclick='ToolBar.Print2.OnClick()' title='"+getBtnPrint2_title()+"' "+isDisabled(bCanPrint2)+"><img src='../_images/new/PRINTM.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Stampa PSC
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowPrint3)+">\n");
        str.append("<td><button id='btnPrint' onclick='ToolBar.Print3.OnClick()' title='"+getBtnPrint3_title()+"' "+isDisabled(bCanPrint3)+"><img src='../_images/new/PRINT.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        
        // Elenco delle aziende
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowAziende)+">\n");
        str.append("<td><button id='btnAziende' onclick='ToolBar.Aziende.OnClick()' title='"+getBtnAziende_title()+"'><img src='../_images/new/LIST1.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Uscita
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowExit)+">\n");
        str.append("<td><button id='btnExit' onclick='ToolBar.Exit.OnClick()' title='"+getBtnExit_title()+"' "+isDisabled(bCanExit)+"><img src='../_images/new/EXIT.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Associa dati
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowReturn)+">\n");
        str.append("<td><button id='btnReturn' onclick='ToolBar.Return.OnClick()' title='"+getBtnReturn_title()+"' "+isDisabled(bCanReturn)+" ><img src='../_images/new/RETURN.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");

        // Help
        str.append("<td> ");
        str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
        str.append("<tr "+isVisible(bShowHelp)+">\n");
        str.append("<td><button id='btnHelp' onclick='ToolBar.Help.OnClick()' title='"+getBtnHelp_title()+"' "+isDisabled(true)+" ><img src='../_images/new/HELP.GIF'></button></td>\n");
        str.append("</tr>\n");
        str.append("</table>\n");
        str.append("</td> ");
        
        // Message
        if (message != null && !message.equals("")){
            str.append("<td> ");
            str.append("<table cellpadding='0' cellspacing='2' border=0>\n");
            str.append("<tr>");
            str.append("<td>&nbsp;</td>\n");    
            if (messageStyle != null && !messageStyle.equals("")){
                str.append("<td nowrap class=\"" + messageStyle + "\">"+message+"</td>\n");    
            } else {
                str.append("<td nowrap>"+message+"</td>\n");                    
            }
            str.append("</tr>\n");
            str.append("</table>\n");
            str.append("</td> ");
        }
        
        str.append("</tr> ");
        str.append("</table>\n");
        
        if (Debug){
            str.append("<iframe name='frameRefresh' style='display:nonen; width:100px; height:100px; overflow:auto;' onreadystatechange='tb_OnRefresh(this)' src='../empty.txt'></iframe>\n");
        }else{
            str.append("<iframe name='frameRefresh' style='display:nonen; width:0px; height:0px; overflow:auto;' onreadystatechange='tb_OnRefresh(this)' src='../empty.txt' scrolling='NO'  frameborder='0' marginheight='0' marginwidth='0'></iframe>\n");
        }
        
        str.append("</td><td width='7px' class='toolbarSpace' rowspan='"+iRowspan+"'>&nbsp;</td></tr>\n");
        
        str.append("<script>\n");
        str.append("var pFields = new Array();\n");
        str.append("var tb_url_Query='"+strQueryString+"';\n");
        str.append("var tb_url='"+request.getRequestURI()+"';\n");
        str.append("var tb_url_Search='"+strSearchUrl+"';\n");
        str.append("var tb_url_Help='"+strHelpUrl+"';\n");
        str.append("var tb_url_Delete='"+strDeleteUrl+"';\n");
        str.append("var tb_url_Enable='"+strEnableUrl+"';\n");
        str.append("var tb_url_Copy='"+strCopyUrl+"';\n");
        str.append("var tb_url_Print='"+strPrintUrl+"';\n");
        str.append("var tb_url_Print2='"+strPrintUrl2+"';\n");
        str.append("var tb_url_Print3='"+strPrintUrl3+"';\n");
        str.append("var tb_url_Edit='"+strEditUrl+"';\n");
        
        str.append("isExtendedMode = "+SecurityWrapper.getInstance().isExtendedMode()+";\n");
        
        str.append("tb_isExtendedAttach = "+( request.getParameter("EXTENDED_ATTACH")!=null)+";\n");
        
        if(strAttachUrl!=null){
            str.append("var tb_url_Attach='"+strAttachUrl+"';\n");
        } else{
            str.append("var tb_url_Attach=null;\n");
        }
        str.append("var tb_bShowNew="+bShowNew+";\n");
        str.append("var tb_bShowSearch="+bShowSearch+";\n");
        str.append("var tb_bShowNew="+bShowNew+";\n");
        str.append("var tb_bShowDelete="+bShowDelete+";\n");
        str.append("var tb_bShowPrint="+bShowPrint+";\n");
        str.append("var tb_bShowEnable="+bShowEnable+";\n");
        str.append("var tb_bShowReturn="+bShowReturn+";\n");
        str.append("var tb_bShowExit="+bShowExit+";\n");
        str.append("var tb_strQueryString=\""+request.getQueryString()+"\";\n");
        str.append("var bCanAssociate="+bCanAssociateCreate+";\n");
        str.append("var bCanAssociateDelete="+bCanAssociateDelete+";\n");
        str.append("var tb_strAziendaId=\""+SecurityWrapper.REQUEST_COD_AZL+"="+SecurityWrapper.getInstance().getAzienda()+"\";\n");
        
        
        if (pFields!=null){
            for (int i=0; i<pFields.size(); i++){
                str.append("pFields[pFields.length]=\""+(String)pFields.get(i)+"\";\n");
            }
        }
        str.append("</script>\n");
        str.append("<script src='../_scripts/editor.js'></script>");
        str.append("<script src='../_scripts/index_.js'></script>\n");
        str.append("<script src='../_scripts/feachures.js'></script>\n");
        
        return str.toString();
    }//end build
    
    public String Replace(String psWord, String psReplace, String psNewSeg) {
        StringBuffer lsNewStr = new StringBuffer();
        int liFound = 0;
        int liLastPointer=0;
        do {
            liFound = psWord.indexOf(psReplace, liLastPointer);
            if ( liFound < 0 )
                lsNewStr.append(psWord.substring(liLastPointer,psWord.length()));
            else {
                if (liFound > liLastPointer)
                    lsNewStr.append(psWord.substring(liLastPointer, liFound));
                
                lsNewStr.append(psNewSeg);
                liLastPointer = liFound + psReplace.length();
            }
        }while (liFound > -1);
        return lsNewStr.toString();
    }
    
    public boolean hasId(String strID){
        if(strID==null) return false;
        return !strID.equals("");
    }
    public String isDisabled(boolean b){
        return b?"":"disabled";
    }
    public String isVisible(boolean b){
        return b?"":" class='invisible'";
    }
    
}

