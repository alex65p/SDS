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
    <version number="1.0" date="20/01/2004" author="Mike Kondratyuk">
	      <comments>
				  <comment date="20/01/2004" author="Mike Kondratyuk">
				   <description>DipendenteLingueStraniereBean.jsp</description>
				 </comment>		
      </comments> 
    </version>
  </versions>
</file> 
*/
%>
<%@ page import="javax.ejb.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.rmi.*"%>
<%@ page import="java.util.*"%>

<%!
///////////////ATTENTION!!//////////////////////////////////////////////
//<comment description="Zdes opredeliaetsia realizatzija EJB obiekta"/>

public class DipendenteLingueStraniereBean extends BMPEntityBean implements IDipendenteLingueStraniere, IDipendenteLingueStraniereHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long		COD_LNG_STR_DPD;
  String	NOM_LNG_STR_DPD;
  String	LIV_CSC_LNG_STR;
  long		COD_DPD;
  long		COD_AZL;
  //</comment>
 
////////////////////// CONSTRUCTOR///////////////////
 private DipendenteLingueStraniereBean()
  {
	//System.err.println("DipendenteLingueStraniereBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDipendenteLingueStraniere create(
							String	strNOM_LNG_STR_DPD,
							String	strLIV_CSC_LNG_STR,
							long	lCOD_DPD,
							long	lCOD_AZL) throws CreateException
  {
 	 DipendenteLingueStraniereBean bean =  new  DipendenteLingueStraniereBean();
	 try{
		 Object primaryKey=bean.ejbCreate(strNOM_LNG_STR_DPD, strLIV_CSC_LNG_STR, lCOD_DPD, lCOD_AZL);
		 bean.setEntityContext(new EntityContextWrapper(primaryKey));
		 bean.ejbPostCreate(strNOM_LNG_STR_DPD, strLIV_CSC_LNG_STR, lCOD_DPD, lCOD_AZL);
	     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
     }
  }
  
 
 // (Home Intrface) remove()
 public void remove(Object primaryKey) 
  {
  	DipendenteLingueStraniereBean iDipendenteLingueStraniereBean=new  DipendenteLingueStraniereBean();
    try
	{
    	Object obj=iDipendenteLingueStraniereBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDipendenteLingueStraniereBean.setEntityContext(new EntityContextWrapper(obj));
        iDipendenteLingueStraniereBean.ejbActivate();
        iDipendenteLingueStraniereBean.ejbLoad();
        iDipendenteLingueStraniereBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDipendenteLingueStraniere findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DipendenteLingueStraniereBean bean =  new  DipendenteLingueStraniereBean();
	try
	{
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
  	try
	{
   		return this.ejbFindAll();
	}
    catch(Exception ex){
        throw new javax.ejb.FinderException(ex.getMessage());
    }
  }
 
 
  // (Home Intrface) VIEWS  getDipendenteLingueStraniere_View(long	lCOD_DPD, long	lCOD_AZL)
  public Collection getDipendenteLingueStraniere_View(long	lCOD_DPD, long	lCOD_AZL)
  {
  	return (new  DipendenteLingueStraniereBean()).ejbGetDipendenteLingueStraniere_View(lCOD_DPD, lCOD_AZL);
  }
  
  
/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IDipendenteLingueStraniereHome-implementation>
  public Long ejbCreate(String	strNOM_LNG_STR_DPD,
						String	strLIV_CSC_LNG_STR,
						long	lCOD_DPD,
						long	lCOD_AZL)
  {
	this.COD_LNG_STR_DPD = NEW_ID();
	this.NOM_LNG_STR_DPD = strNOM_LNG_STR_DPD;
	this.LIV_CSC_LNG_STR = strLIV_CSC_LNG_STR;
	this.COD_DPD = lCOD_DPD;
	this.COD_AZL = lCOD_AZL;
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
		PreparedStatement ps=bmp.prepareStatement("INSERT INTO lng_str_dpd_tab (cod_lng_str_dpd,nom_lng_str_dpd, liv_csc_lng_str, cod_dpd, cod_azl) VALUES(?,?,?,?,?)");
		ps.setLong(1, COD_LNG_STR_DPD);
		ps.setString(2, NOM_LNG_STR_DPD);
		ps.setString(3, LIV_CSC_LNG_STR);
		ps.setLong(4, COD_DPD);
		ps.setLong(5, COD_AZL);
        ps.executeUpdate();
        return new Long(COD_LNG_STR_DPD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------   
  public void ejbPostCreate(String	strNOM_LNG_STR_DPD,
							String	strLIV_CSC_LNG_STR,
							long	lCOD_DPD,
							long	lCOD_AZL)
  { }	
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_lng_str_dpd FROM lng_str_dpd_tab ");
		  ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            al.add(new Long(rs.getLong(1)));
          }
          return al;
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }

//-----------------------------------------------------------
  	
  public Long ejbFindByPrimaryKey(Long primaryKey){
    return primaryKey;
  }  
//----------------------------------------------------------

  public void ejbActivate(){
    this.COD_LNG_STR_DPD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_LNG_STR_DPD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM lng_str_dpd_tab  WHERE cod_lng_str_dpd=?");
			ps.setLong(1, COD_LNG_STR_DPD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
              	this.COD_LNG_STR_DPD=rs.getLong("COD_LNG_STR_DPD");
              	this.NOM_LNG_STR_DPD=rs.getString("NOM_LNG_STR_DPD");
              	this.LIV_CSC_LNG_STR=rs.getString("LIV_CSC_LNG_STR");
              	this.COD_DPD=rs.getLong("COD_DPD");
              	this.COD_AZL=rs.getLong("COD_AZL");
           }
           else{
              throw new NoSuchEntityException("DipendenteLingueStraniere con ID="+COD_LNG_STR_DPD+" non è trovata");
           }
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//----------------------------------------------------------

  public void ejbRemove(){
      BMPConnection bmp=getConnection();
      try
	  {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM lng_str_dpd_tab  WHERE cod_lng_str_dpd=?");
          ps.setLong (1, COD_LNG_STR_DPD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteLingueStraniere con ID="+COD_LNG_STR_DPD+" non è trovata");
      }
      catch(Exception ex)
	  {
          throw new EJBException(ex);
      }
      finally{bmp.close();
	  }
  }  
//----------------------------------------------------------

  public void ejbStore()
  {
    if(!isModified()) return;
      BMPConnection bmp=getConnection();
      try{

			PreparedStatement ps=bmp.prepareStatement("UPDATE lng_str_dpd_tab  SET nom_lng_str_dpd = ?, liv_csc_lng_str = ?, cod_dpd=?,cod_azl=? WHERE cod_lng_str_dpd=?");

			ps.setString(1, NOM_LNG_STR_DPD);
			ps.setString(2, LIV_CSC_LNG_STR);
			ps.setLong(3, COD_DPD);
			ps.setLong(4, COD_AZL);
			ps.setLong(5, COD_LNG_STR_DPD);

			if(ps.executeUpdate()==0) throw new NoSuchEntityException("DipendenteLingueStraniere con ID="+COD_LNG_STR_DPD+" non &egrave trovata");
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
	// COD_LNG_STR_DPD
	public void setCOD_LNG_STR_DPD(long newCOD_LNG_STR_DPD)
	{
		COD_LNG_STR_DPD = newCOD_LNG_STR_DPD;
		setModified();
	}
	public long getCOD_LNG_STR_DPD()
	{
		return COD_LNG_STR_DPD;
	}

	// NOM_LNG_STR_DPD
	public void setNOM_LNG_STR_DPD(String newNOM_LNG_STR_DPD)
	{
		if(NOM_LNG_STR_DPD!=null) if( NOM_LNG_STR_DPD.equals(newNOM_LNG_STR_DPD)) return;
		NOM_LNG_STR_DPD = newNOM_LNG_STR_DPD;
		setModified();
	}
	public String getNOM_LNG_STR_DPD()
	{
		return NOM_LNG_STR_DPD;
	}

	// LIV_CSC_LNG_STR
	public void setLIV_CSC_LNG_STR(String newLIV_CSC_LNG_STR)
	{
		if(LIV_CSC_LNG_STR!=null) if( LIV_CSC_LNG_STR.equals(newLIV_CSC_LNG_STR)) return;
		LIV_CSC_LNG_STR = newLIV_CSC_LNG_STR;
		setModified();
	}
	public String getLIV_CSC_LNG_STR()
	{
		return LIV_CSC_LNG_STR;
	}

	// COD_DPD
	public void setCOD_DPD(long newCOD_DPD)
	{
		COD_DPD = newCOD_DPD;
		setModified();
	}
	public long getCOD_DPD()
	{
		return COD_DPD;
	}

	// COD_AZL
	public void setCOD_AZL(long newCOD_AZL)
	{
		COD_AZL = newCOD_AZL;
		setModified();
	}
	public long getCOD_AZL()
	{
		return COD_AZL;
	}
	
   //</comment>
   
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>
   
   //<comment description="extended setters/getters">
   public Collection ejbGetDipendenteLingueStraniere_View(long	lCOD_DPD, long	lCOD_AZL){
      BMPConnection bmp=getConnection();
      try{
        	PreparedStatement ps=bmp.prepareStatement("SELECT cod_lng_str_dpd,nom_lng_str_dpd,liv_csc_lng_str FROM lng_str_dpd_tab WHERE cod_dpd=? and cod_azl=? order by nom_lng_str_dpd");
  			ps.setLong(1, lCOD_DPD);
			ps.setLong(2, lCOD_AZL);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DipendenteLingueStraniere_View obj=new DipendenteLingueStraniere_View();
            obj.COD_LNG_STR_DPD=rs.getLong(1);
            obj.NOM_LNG_STR_DPD=rs.getString(2);
            obj.LIV_CSC_LNG_STR=rs.getString(3);
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
  
  //-------------------
  //</comment>         

///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  DipendenteLingueStraniereBean"/>
%>
<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DipendenteLingueStraniereBean", new DipendenteLingueStraniereBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
