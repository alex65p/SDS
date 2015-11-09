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
<%!
// BASE TABLE: ANA_DPD_TAB
//////////////////////////////////ATTENTION!!/////////////////////////
//<comment description="Zdes opredeliayutsia interfeisi EJB objecta"/>

//     Remote Intrface EJB obiekta 
public interface IDipendenteAttivitaLavorative extends EJBObject
{
  // dat_inz
  public java.sql.Date getdat_inz();
  public void setdat_inz(java.sql.Date newdat_inz);

  // dat_fie
  public java.sql.Date getdat_fie();
  public void setdat_fie(java.sql.Date newdat_fie);

  // cod_uni_org
  public long getcod_uni_org();
  public void setcod_uni_org(long newcod_uni_org);

  // cod_man
  public long getcod_man();
  public void setcod_man(long newcod_man);

  // cod_dpd
  public long getcod_dpd();
  public void setcod_dpd(long newcod_dpd);

  // cod_azl
  public long getcod_azl();
  public void setcod_azl(long newcod_azl);

}

//     Home Intrface EJB obiekta 
public interface IDipendenteAttivitaLavorativeHome extends EJBHome
{
   public IDipendenteAttivitaLavorative create(
	java.sql.Date	dat_inz,
	java.sql.Date	dat_fie,
	long	cod_uni_org, 
	long	cod_man,
	long	cod_dpd,
	long	cod_azl
   ) throws CreateException;
   public void remove(Object primaryKey);
   public IDipendenteAttivitaLavorative findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;
   // opredelenie view metodov
//   public Collection getDipendenteAttivitaLavorative_Name_Address_View() throws FinderException;
}

/*public*/
// view metodi   
/*
class DipendenteAttivitaLavorative_Name_Address_View implements java.io.Serializable{
	public long COD_AZL;
	public String RAG_SCL_ACL,IDZ_AZL;
}
*/
%>
