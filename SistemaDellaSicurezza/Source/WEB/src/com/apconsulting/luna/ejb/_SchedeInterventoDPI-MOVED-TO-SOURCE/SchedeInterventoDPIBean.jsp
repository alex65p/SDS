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
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>
public class SchedeInterventoDPIBean extends BMPEntityBean implements ISchedeInterventoDPI, ISchedeInterventoDPIHome{
  //---------------------------------------- 
  long           COD_SCH_INR_DPI;        //1 
  long           COD_LOT_DPI;            //2 
  long           COD_TPL_DPI;            //3 
  String         TPL_INR_DPI;            //4 
  String         ATI_INR;                //5 
  java.sql.Date  DAT_PIF_INR;            //6 
	//-------------------------------------- 
  java.sql.Date  DAT_INR;                //7 
  String         ESI_INR;                //8 
  String         PBM_RSC;                //9 
  String         NOM_RSP_INR;            //10
  //-----------------------------------------
  private SchedeInterventoDPIBean() {}

  // (Home Interface) create()
  public ISchedeInterventoDPI create(long lCOD_LOT_DPI, long lCOD_TPL_DPI, String strTPL_INR_DPI, String strATI_INR, java.sql.Date dtDAT_PIF_INR) throws CreateException
  {
  	 SchedeInterventoDPIBean bean =  new  SchedeInterventoDPIBean();
	   try{
	     Object primaryKey=bean.ejbCreate(lCOD_LOT_DPI, lCOD_TPL_DPI, strTPL_INR_DPI, strATI_INR, dtDAT_PIF_INR);
	     bean.setEntityContext(new EntityContextWrapper(primaryKey));
	     bean.ejbPostCreate(lCOD_LOT_DPI, lCOD_TPL_DPI, strTPL_INR_DPI, strATI_INR, dtDAT_PIF_INR);
       return bean;
	   }
	   catch(Exception ex){
       throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
 // (Home Intrface) remove()
 public void remove(Object primaryKey){
  	SchedeInterventoDPIBean iSchedeInterventoDPIBean=new  SchedeInterventoDPIBean();
    try	{
    	Object obj=iSchedeInterventoDPIBean.ejbFindByPrimaryKey((Long)primaryKey);
        iSchedeInterventoDPIBean.setEntityContext(new EntityContextWrapper(obj));
        iSchedeInterventoDPIBean.ejbActivate();
        iSchedeInterventoDPIBean.ejbLoad();
        iSchedeInterventoDPIBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
 }
  // (Home Interface) findByPrimaryKey()
  public ISchedeInterventoDPI findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	SchedeInterventoDPIBean bean =  new  SchedeInterventoDPIBean();
  	try	{
   		bean.setEntityContext(new EntityContextWrapper(primaryKey));
   		bean.ejbActivate();
   		bean.ejbLoad();
   		return bean;
  	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
  // (Home Intrface) findAll()
  public Collection findAll() throws FinderException
  {
  	try	{
   		return this.ejbFindAll();
  	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }

	//---------- view
//--- <comment date="22/01/2004" author="Treskina Maria">
	//--- view per LOT_DPI
  public Collection getSchedeInterventoDPIByLOTDPIID_View(long LOT_DPI_ID)
  {
  	return (new  SchedeInterventoDPIBean()).ejbGetSchedeInterventoDPIByLOTDPIID_View(LOT_DPI_ID);
  }
  //--- <comment date="22/01/2004" author="Podmasteriev Alexander">
  //--- view per COD_AZL
  public Collection getSchedeInterventoLOV_View(long COD_AZL)
  {
  	return (new  SchedeInterventoDPIBean()).ejbGetSchedeInterventoLOV_View(COD_AZL);
  }
  //
  public Collection getfindEx(long COD_AZL, long COD_LOT_DPI, java.sql.Date DAT_PIF_INR, java.sql.Date DAT_INR, String ATI_INR, String NOM_RSP_INR, String PBM_RSC, long iOrderBy)
  {
  	return (new  SchedeInterventoDPIBean()).ejbfindEx(COD_AZL, COD_LOT_DPI, DAT_PIF_INR, DAT_INR, ATI_INR, NOM_RSP_INR, PBM_RSC, iOrderBy);
  }

/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</ISchedeInterventoDPIHome-implementation>
  public Long ejbCreate(long lCOD_LOT_DPI, long lCOD_TPL_DPI, String strTPL_INR_DPI, String strATI_INR, java.sql.Date dtDAT_PIF_INR){
    this.COD_LOT_DPI=lCOD_LOT_DPI;
	this.COD_TPL_DPI=lCOD_TPL_DPI;
	this.TPL_INR_DPI=strTPL_INR_DPI;
	this.ATI_INR=strATI_INR;
	this.DAT_PIF_INR=dtDAT_PIF_INR;
    this.COD_SCH_INR_DPI=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO sch_inr_dpi_tab (cod_sch_inr_dpi,cod_lot_dpi,cod_tpl_dpi,tpl_inr_dpi,ati_inr,dat_pif_inr) VALUES(?,?,?,?,?,?)");
         ps.setLong   (1, COD_SCH_INR_DPI);
		 ps.setLong   (2, COD_LOT_DPI);
		 ps.setLong   (3, COD_TPL_DPI);
         ps.setString (4, TPL_INR_DPI);
		 ps.setString (5, ATI_INR);
		 ps.setDate   (6, DAT_PIF_INR);
         ps.executeUpdate();
         return new Long(COD_SCH_INR_DPI);
    }catch(Exception ex){
        throw new EJBException(ex);
    }finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(long lCOD_LOT_DPI, long lCOD_TPL_DPI, String strTPL_INR_DPI, String strATI_INR, java.sql.Date dtDAT_PIF_INR) { }	
//--------------------------------------------------
  public Collection ejbFindAll(){
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_sch_inr_dpi FROM sch_inr_dpi_tab ");
    		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }

//-----------------------------------------------------------
  	
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------
  public void ejbActivate(){
    this.COD_SCH_INR_DPI=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------
  public void ejbPassivate(){
      this.COD_SCH_INR_DPI=-1;
  }
//----------------------------------------------------------
  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM sch_inr_dpi_tab  WHERE cod_sch_inr_dpi=?");
           ps.setLong (1, COD_SCH_INR_DPI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
	  	  	this.COD_SCH_INR_DPI=rs.getLong("COD_SCH_INR_DPI");
           	this.DAT_PIF_INR=rs.getDate("DAT_PIF_INR");
			this.DAT_INR=rs.getDate("DAT_INR");
			this.COD_TPL_DPI=rs.getLong("COD_TPL_DPI");
			this.COD_LOT_DPI=rs.getLong("COD_LOT_DPI");
			this.ESI_INR=rs.getString("ESI_INR");
			this.ATI_INR=rs.getString("ATI_INR");
			this.NOM_RSP_INR=rs.getString("NOM_RSP_INR");
			this.PBM_RSC=rs.getString("PBM_RSC");
			this.TPL_INR_DPI=rs.getString("TPL_INR_DPI");
           }
           else{
              throw new NoSuchEntityException("COD_SCH_INR_DPI con ID= non è trovata");
           }
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
//----------------------------------------------------------
  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM sch_inr_dpi_tab  WHERE cod_sch_inr_dpi=?");
         ps.setLong (1, COD_SCH_INR_DPI);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }  
//----------------------------------------------------------
  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE sch_inr_dpi_tab  SET cod_sch_inr_dpi=?, dat_pif_inr=?, dat_inr=?, esi_inr=?, ati_inr=?, nom_rsp_inr=?, pbm_rsc=?, tpl_inr_dpi=?, cod_tpl_dpi=?, cod_lot_dpi=? WHERE cod_sch_inr_dpi=?");
         ps.setLong           (1,COD_SCH_INR_DPI);
         ps.setDate           (2,DAT_PIF_INR);
		 ps.setDate  		  (3,DAT_INR);
		 ps.setString         (4,ESI_INR);
		 ps.setString         (5,ATI_INR);
		 ps.setString         (6,NOM_RSP_INR);
		 ps.setString         (7,PBM_RSC);
		 ps.setString         (8,TPL_INR_DPI);
		 ps.setLong           (9,COD_TPL_DPI);
		 ps.setLong           (10,COD_LOT_DPI);
         ps.setLong           (11,COD_SCH_INR_DPI);
	     if(ps.executeUpdate()==0) throw new NoSuchEntityException("Tipologie Macchine con ID= non è trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="setter/getters">
    //1
    public long getCOD_SCH_INR_DPI(){
      return COD_SCH_INR_DPI;
    }
	//2
	public void setCOD_LOT_DPI(long newCOD_LOT_DPI){
      if( COD_LOT_DPI==newCOD_LOT_DPI ) return;
      COD_LOT_DPI = newCOD_LOT_DPI;
      setModified();
    }
    public long getCOD_LOT_DPI(){
      return COD_LOT_DPI;
    }
  	//3
	public void setCOD_TPL_DPI(long newCOD_TPL_DPI){
      if( COD_TPL_DPI==newCOD_TPL_DPI ) return;
      COD_TPL_DPI = newCOD_TPL_DPI;
      setModified();
    }
    public long getCOD_TPL_DPI(){
      return COD_TPL_DPI;
    }
	//4
	public void setTPL_INR_DPI(String newTPL_INR_DPI){
      if( TPL_INR_DPI.equals(newTPL_INR_DPI) ) return;
      TPL_INR_DPI = newTPL_INR_DPI;
      setModified();
    }
    public String getTPL_INR_DPI(){
      return TPL_INR_DPI;
    }
	//5
	public void setATI_INR(String newATI_INR){
      if( ATI_INR.equals(newATI_INR) ) return;
      ATI_INR = newATI_INR;
      setModified();
    }
    public String getATI_INR(){
      return ATI_INR;
    }
	//6
	public void setDAT_PIF_INR(java.sql.Date newDAT_PIF_INR){
      if( DAT_PIF_INR.equals(newDAT_PIF_INR) ) return;
      DAT_PIF_INR = newDAT_PIF_INR;
      setModified();
    }
    public java.sql.Date getDAT_PIF_INR(){
      return DAT_PIF_INR;
    }
	//============================================
	// not required field
  	//7
	public void setDAT_INR(java.sql.Date newDAT_INR){
      if(( DAT_INR!=null)&&(DAT_INR.equals(newDAT_INR)) ) return;
      DAT_INR = newDAT_INR;
      setModified();
    }
    public java.sql.Date getDAT_INR(){
      return DAT_INR;
    }
	//8
	public void setESI_INR(String newESI_INR){
      if( ( ESI_INR!=null)&&(ESI_INR.equals(newESI_INR)) ) return;
      ESI_INR = newESI_INR;
      setModified();
    }
    public String getESI_INR(){
      if (ESI_INR==null){ESI_INR="";}
			return ESI_INR;
    }//9
	public void setPBM_RSC(String newPBM_RSC){
      if( ( PBM_RSC!=null)&&(PBM_RSC.equals(newPBM_RSC)) ) return;
      PBM_RSC = newPBM_RSC;
      setModified();
    }
    public String getPBM_RSC(){
      if (PBM_RSC==null){PBM_RSC="";}
			return PBM_RSC;
    }//10
		public void setNOM_RSP_INR(String newNOM_RSP_INR){
      if( ( NOM_RSP_INR!=null)&&(NOM_RSP_INR.equals(newNOM_RSP_INR)) ) return;
      NOM_RSP_INR = newNOM_RSP_INR;
      setModified();
    }
    public String getNOM_RSP_INR(){
		  if (NOM_RSP_INR==null){NOM_RSP_INR="";}
      return NOM_RSP_INR;
    }
   //</comment>
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
  
   //<comment description="extended setters/getters">
	 
//--- <comment date="25/01/2004" author="Treskina Maria">
   public Collection ejbGetSchedeInterventoDPIByLOTDPIID_View(long LOT_DPI_ID){
       BMPConnection bmp=getConnection();
       try{
          PreparedStatement ps=bmp.prepareStatement("SELECT sid.cod_sch_inr_dpi, sid.ati_inr, sid.dat_inr, sid.dat_pif_inr, sid.nom_rsp_inr, td.nom_tpl_dpi FROM sch_inr_dpi_tab sid, tpl_dpi_tab td WHERE  sid.cod_tpl_dpi=td.cod_tpl_dpi AND sid.cod_lot_dpi=? ");
         ps.setLong(1, LOT_DPI_ID);
		 ResultSet rs=ps.executeQuery();
         java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            SchedeInterventoDPIByLOTDPIID_View obj=new SchedeInterventoDPIByLOTDPIID_View();
            obj.COD_SCH_INR_DPI=rs.getLong(1);
            obj.ANI_INR=rs.getString(2);
			obj.DAT_INR=rs.getDate(3);
			obj.DAT_PIF_INR=rs.getDate(4);
            obj.NOM_RSP_INR=rs.getString(5);
			obj.NOM_TPL_DPI=rs.getString(6);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

	//----------------------------------------------------------
    public Collection ejbGetSchedeInterventoLOV_View(long COD_AZL){
       BMPConnection bmp=getConnection();
       try{
       PreparedStatement ps=bmp.prepareStatement(
					" SELECT "+
				  " a.cod_sch_inr_dpi, "+
					" a.cod_lot_dpi, "+
					" a.cod_tpl_dpi, "+
					" a.dat_inr, "+
					" a.dat_pif_inr,"+
					" a.esi_inr, "+
					" b.ide_lot_dpi,"+
					" a.tpl_inr_dpi  "+
			" FROM  sch_inr_dpi_tab a, "+
			      " ana_lot_dpi_tab b, "+
            " ana_for_azl_tab c  "+
			" WHERE  "+
				  "  a.cod_lot_dpi = b.cod_lot_dpi "+
          "  AND    b.cod_for_azl = c.cod_for_azl "+
           " AND    b.cod_azl = ? order by b.ide_lot_dpi"
		 );
         ps.setLong(1, COD_AZL);
		 ResultSet rs=ps.executeQuery();
         java.util.ArrayList al=new java.util.ArrayList();
         while(rs.next()){
	        SchedeInterventoLOV_View obj=new SchedeInterventoLOV_View();
            obj.COD_SCH_INR_DPI=rs.getLong(1);
			obj.COD_LOT_DPI=rs.getLong(2);
			obj.COD_TPL_DPI=rs.getLong(3);
			obj.DAT_INR=rs.getDate(4);
           	obj.DAT_PIF_INR=rs.getDate(5);
			obj.ESI_INR=rs.getString(6);
			obj.IDE_LOT_DPI=rs.getString(7);
            obj.TPL_INR_DPI=rs.getString(8);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }
/////////////////////<Kushkarov for new Search>///////////////////////////////////
	public Collection ejbfindEx(
		long COD_AZL, 
		long COD_LOT_DPI, 
		java.sql.Date DAT_PIF_INR, 
		java.sql.Date DAT_INR, 
		String ATI_INR, String 
		NOM_RSP_INR, 
		String PBM_RSC, 
		long iOrderBy)
	{
       	int i=2;
		int indexLotti=0;
			 String Sql="SELECT "+
				  " a.cod_sch_inr_dpi, "+
					" a.cod_lot_dpi, "+
					" a.cod_tpl_dpi, "+
					" a.dat_inr, "+
					" a.dat_pif_inr,"+
					" a.esi_inr, "+
					" b.ide_lot_dpi,"+
					" a.tpl_inr_dpi  "+
			" FROM  sch_inr_dpi_tab a, "+
			      " ana_lot_dpi_tab b, "+
            " ana_for_azl_tab c  "+
			" WHERE  "+
				  "  a.cod_lot_dpi = b.cod_lot_dpi "+
          "  AND    b.cod_for_azl = c.cod_for_azl "+
           " AND    b.cod_azl = ? ";
			 if(COD_LOT_DPI!=0)
			 {
			   Sql+=" AND a.cod_lot_dpi = ? ";
				 indexLotti=i++;
			 }
			 int indexDatPianif=0;
			 if(DAT_PIF_INR!=null)
			 {
			   Sql+=" AND a.dat_pif_inr = ? ";
				 indexDatPianif=i++;
			 }
			 int indexInr=0;
			 if(DAT_INR!=null)
			 {
			   Sql+=" AND a.dat_inr = ? ";
				 indexInr=i++;
			 }
			 int indexAti=0;
			 if(ATI_INR!=null)
			 {
			   Sql+=" AND UPPER(a.ati_inr) LIKE ? ";
			   indexAti=i++;
			 }
			 int indexResp=0;
			 if(NOM_RSP_INR!=null)
			 {
			   Sql+=" AND a.nom_rsp_inr LIKE ? ";
				 indexResp=i++;
			 }
			 int indexPbm=0;
			 if(PBM_RSC!=null)
			 {
			   Sql+=" AND UPPER(a.pbm_rsc) LIKE ? ";
				 indexPbm=i++;
			 }
			 Sql+=" order by UPPER(b.ide_lot_dpi) ";
			 BMPConnection bmp=getConnection();
       try{
       PreparedStatement ps=bmp.prepareStatement(Sql);
         ps.setLong(1, COD_AZL);
		 if(indexLotti!=0){ps.setLong(indexLotti, COD_LOT_DPI);}
		 if(indexDatPianif!=0){ps.setDate(indexDatPianif,DAT_PIF_INR);}
		 if(indexInr!=0){ps.setDate(indexInr,DAT_INR);}
		 if(indexAti!=0){ps.setString(indexAti,ATI_INR.toUpperCase()+"%");}
		 if(indexResp!=0){ps.setString(indexResp,NOM_RSP_INR+"%");}
		 if(indexPbm!=0){ps.setString(indexPbm,PBM_RSC.toUpperCase()+"%");}
		 ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next())
		  {
		    findEx_inr_dpi obj=new findEx_inr_dpi();
            obj.COD_SCH_INR_DPI=rs.getLong(1);
			obj.COD_LOT_DPI=rs.getLong(2);
			obj.COD_TPL_DPI=rs.getLong(3);
			obj.DAT_INR=rs.getDate(4);
           	obj.DAT_PIF_INR=rs.getDate(5);
			obj.ESI_INR=rs.getString(6);
			obj.IDE_LOT_DPI=rs.getString(7);
            obj.TPL_INR_DPI=rs.getString(8);
            al.add(obj);
          }
          bmp.close();
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
     finally{bmp.close();}
  }

	
 //----------------------------------------------------------
 //<report>
 	public ReportSchedeInterventoDPIView getReportSchedeInterventoDPIView(long lCOD_SCH_INR_DPI){
		return this.ejbGetReportSchedeInterventoDPIView(lCOD_SCH_INR_DPI);
	}
  	
	public ReportSchedeInterventoDPIView ejbGetReportSchedeInterventoDPIView(long lCOD_SCH_INR_DPI){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement(
			" SELECT "+
				  " a.cod_sch_inr_dpi,  "+
				  " a.ati_inr, "+
				  " a.dat_inr, "+
				  " a.esi_inr, "+
				  " a.pbm_rsc, "+
				  " b.ide_lot_dpi, "+
				  " c.nom_tpl_dpi "+
			" FROM sch_inr_dpi_tab a,  "+
				 " ana_lot_dpi_tab b,  "+
				 " tpl_dpi_tab c "+
			" WHERE  "+
				  " a.COD_SCH_INR_DPI = ? and "+
				  " a.COD_LOT_DPI = b.COD_LOT_DPI and "+
				  " b.COD_TPL_DPI = c.COD_TPL_DPI "
		 );
           ps.setLong (1, lCOD_SCH_INR_DPI);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
	  			ReportSchedeInterventoDPIView w= new ReportSchedeInterventoDPIView();
	  			w.lCOD_SCH_INR_DPI=rs.getLong(1);
	        	w.strATI_INR=rs.getString(2);
				w.dtDAT_INR=rs.getDate(3);
				w.strESI_INR=rs.getString(4);
				w.strPBM_RSC=rs.getString(5);
				w.strIDE_LOT_DPI=rs.getString(6);
				w.strNOM_TPL_DPI=rs.getString(7);
				return w;
           }
			return null;
      }catch(Exception ex){
          throw new EJBException(ex);
      }finally{bmp.close();}
  }
  //</report>
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  SchedeInterventoDPIBean"/>
%>
<%
////////////////////////////////////////// <BINDING> ////////////////////////
PseudoContext.bind("SchedeInterventoDPIBean", new SchedeInterventoDPIBean());
////////////////////////////////////////// </BINDING> ///////////////////////
%>
