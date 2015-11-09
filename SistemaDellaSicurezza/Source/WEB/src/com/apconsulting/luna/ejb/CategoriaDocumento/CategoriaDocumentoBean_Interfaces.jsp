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

<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>
<%!//[1]
// BASE TABLE: CAT_DOC_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta
public interface  ICategoriaDocumento extends EJBObject
// class ICategoriaDocumento extends BMPEntityBean
{
  //1 COD_STA (Azienda ID)
  public long getCOD_CAG_DOC();
  //2 RAG_SCL_AZL (name)
  public String getNOM_CAG_DOC();
  public void setNOM_CAG_DOC(String newNOM_CAG_DOC);
  //3 DES_ATI_SVO_AZL (descr)
  public String getDES_CAG_DOC();
  public void setDES_CAG_DOC (String newDES_CAG_DOC);
}
//     Home Intrface EJB obiekta
public interface ICategoriaDocumentoHome extends EJBHome
// class ICategoriaDocumentoHome extends  ICategoriaDocumento
{
   public ICategoriaDocumento create(String strNOM_CAG_DOC) throws CreateException;
   public void remove(Object primaryKey);
   public ICategoriaDocumento findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws RemoteException, FinderException;
   public Collection getComboView();
   public Collection getCategoriaDocumento_Name_Description_View();
   public Collection findEx(String NOM_CAG_DOC, String DES_CAG_DOC, int iOrderBy);
}
//-------------------------------------------------------------------------
class CategoriaDocumento_ComboView implements java.io.Serializable{
	public long lCOD_CAT_DOC;
	public String strNOM_CAT_DOC;
}
class CategoriaDocumento_Name_Description_View implements java.io.Serializable{
	public long lCOD_CAG_DOC;
	public String strNOM_CAG_DOC, strDES_CAG_DOC;
}
%>
