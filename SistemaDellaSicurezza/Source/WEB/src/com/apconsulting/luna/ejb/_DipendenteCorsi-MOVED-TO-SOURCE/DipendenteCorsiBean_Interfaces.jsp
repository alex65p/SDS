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
// BASE TABLE: ANA_COR_TAB, COR_DPD_TAB

//     Remote Intrface EJB obiekta
public interface IDipendenteCorsi extends EJBObject{
  //   *Require Fields*
  //1 COD_COR
  public long getCOD_COR();
  //2 NOM_COR ()
  public String getNOM_COR();
  public void setNOM_COR(String newNOM_COR);

  //   *Not require Fields*
  //3 DES_COR ()
  public String getDES_COR();
  public void setDES_COR(String newDES_COR);
  //4 DAT_EFT_COR()
  public java.sql.Date getDAT_EFT_COR();
  public void setDAT_EFT_COR(java.sql.Date newDAT_EFT_COR);

}

//     Home Intrface EJB obiekta
public interface IDipendenteCorsiHome extends EJBHome{
   public IDipendenteCorsi create(String strNOM_COR) throws CreateException;
   public void remove(Object primaryKey);
   public IDipendenteCorsi findByPrimaryKey(Long primaryKey) throws FinderException;
   public Collection findAll() throws FinderException;

	 public Collection getDipendente_View(long lCOD_AZL, long lCOD_COR, java.sql.Date dDATE,long lCOD_SCH_EGZ_COR);
	 public void addCOR_DPD_ISC(long lCOD_DPD, long lCOD_SCH_EGZ_COR, long lCOD_AZL);

   //<report>
   public Collection getDipendenteCorsi_View(long lCOD_DPD);
   public Collection getDipendentiCorsi(long lCOD_COR,long lCOD_AZL,long lCOD_DPD,java.sql.Date DAT_EFT_COR);

  

}

//<report>

class DipendentiCorsi implements java.io.Serializable{


    
    public String MAT_CSG;
    public java.sql.Date DAT_CSG_MAT;
    public String ESI_TES_VRF;
    public java.sql.Date DAT_EFT_TES_VRF;
    public long   PTG_OTT_DPD;
    public String ATE_FRE_DPD;


}
class DipendenteCorsi_View implements java.io.Serializable{
    public long lCOD_COR;
    public String strNOM_COR;
	public String strDES_COR;
    public java.sql.Date dtDAT_EFT_COR;
 

}

class Dipendente_View implements java.io.Serializable{
	public long COD_COR;
	public long COD_DPD;
	public long COD_SCH_EGZ_COR;
	public String NOM_DPD;
	public String COG_DPD;
	public String NOM_COR;
	public java.sql.Date DAT_PIF_EGZ_COR;
    public java.sql.Date DAT_EFT_COR;
}
%>
