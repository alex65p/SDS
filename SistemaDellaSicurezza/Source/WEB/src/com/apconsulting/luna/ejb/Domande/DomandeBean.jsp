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

public class DomandeBean extends BMPEntityBean implements IDomande, IDomandeHome
{
  //  Zdes opredeliajutsia peremennie EJB obiekta
  //<comment description="Member Variables">
  long COD_DMD;
  String NOM_DMD;
  //-----------------------------
  String DES_DMD;
  //-----------------------------
	// Link Table RST_DMD_TAB
  long newCOD_RST;
  String newRST_ESI;
  //</comment>

////////////////////// CONSTRUCTOR///////////////////
 private DomandeBean()
  {
	//System.err.println("DomandeBean constructor<br>");
  }

////////////////////////////ATTENTION!!//////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody EJB objecta kotorie budut rabotat v JSP Containere (Zaglushki)"/>

  // (Home Intrface) create()
  public IDomande create(String NOM_DMD, String DES_DMD) throws CreateException
  {
 	 DomandeBean bean =  new  DomandeBean();
	 try{
	 Object primaryKey=bean.ejbCreate(NOM_DMD, DES_DMD);
	 bean.setEntityContext(new EntityContextWrapper(primaryKey));
	 bean.ejbPostCreate(NOM_DMD, DES_DMD);
     return bean;
	 }
	 catch(Exception ex){
          throw new javax.ejb.CreateException(ex.getMessage());
        }
  }


 // (Home Intrface) remove()
 public void remove(Object primaryKey)
  {
  	DomandeBean iDomandeBean=new  DomandeBean();
    try
	{
    	Object obj=iDomandeBean.ejbFindByPrimaryKey((Long)primaryKey);
        iDomandeBean.setEntityContext(new EntityContextWrapper(obj));
        iDomandeBean.ejbActivate();
        iDomandeBean.ejbLoad();
        iDomandeBean.ejbRemove();
    }
    catch(Exception ex){
          throw new EJBException(ex);
    }
  }
  // (Home Intrface) findByPrimaryKey()
  public IDomande findByPrimaryKey(Long primaryKey) throws FinderException
  {
   	DomandeBean bean =  new  DomandeBean();
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


  // (Home Intrface) VIEWS  getDomande_List_View()
  public Collection getDomande_List_View()
  {
  	return (new  DomandeBean()).ejbGetDomande_List_View();
 }

  // (Home Intrface) VIEWS  getDomandeRisposteByDMDID_View()
  public Collection getDomandeRisposteByDMDID_View(long COD_DMD)
  {
  	return (new  DomandeBean()).ejbGetDomandeRisposteByDMDID_View(COD_DMD);
 }


/////////////////////ATTENTION!!////////////////////////////////////////////////////////////////////////////
//<comment description="Zdes opredeliayutsia metody home intefeisa kotorie budut rabotat v EJB Containere"/>

  //</IDomandeHome-implementation>
  public Long ejbCreate(String NOM_DMD, String DES_DMD)
  {
    this.NOM_DMD=NOM_DMD;
    this.DES_DMD=DES_DMD;
    this.COD_DMD=NEW_ID(); // unic ID
    this.unsetModified();
    BMPConnection bmp=getConnection();
    try{
       PreparedStatement ps=bmp.prepareStatement("INSERT INTO ana_dmd_tab (cod_dmd,nom_dmd,des_dmd) VALUES(?,?,?)");
         ps.setLong   (1, COD_DMD);
         ps.setString (2, NOM_DMD);
         ps.setString (3, DES_DMD);
         ps.executeUpdate();
         return new Long(COD_DMD);
    }
    catch(Exception ex){
        throw new EJBException(ex);
    }
    finally{bmp.close();}
  }

//-------------------------------------------------------
  public void ejbPostCreate(String NOM_DMD, String DES_DMD) { }
//--------------------------------------------------

  public Collection ejbFindAll()
  {
      BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dmd FROM ana_dmd_tab ");
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
    this.COD_DMD=((Long)this.getEntityKey()).longValue();
  }
//----------------------------------------------------------

  public void ejbPassivate(){
      this.COD_DMD=-1;
  }
//----------------------------------------------------------

  public void ejbLoad(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("SELECT * FROM ana_dmd_tab  WHERE cod_dmd=?");
           ps.setLong (1, COD_DMD);
           ResultSet rs=ps.executeQuery();
           if(rs.next()){
            this.NOM_DMD=rs.getString("NOM_DMD");
            this.DES_DMD=rs.getString("DES_DMD");
           }
           else{
              throw new NoSuchEntityException("Domande con ID="+COD_DMD+" non &egrave trovata");
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
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM ana_dmd_tab  WHERE cod_dmd=?");
          ps.setLong (1, COD_DMD);
          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Domande con ID="+COD_DMD+" non &egrave trovata");
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
         PreparedStatement ps=bmp.prepareStatement("UPDATE ana_dmd_tab  SET nom_dmd=?, des_dmd=? WHERE cod_dmd=?");
          ps.setString(1, NOM_DMD);
          ps.setString(2, DES_DMD);
					ps.setLong  (3, COD_DMD);

          if(ps.executeUpdate()==0) throw new NoSuchEntityException("Domande con ID="+COD_DMD+" non &egrave trovata");
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
  }
//-------------------------------------------------------------

/////////////////////////////////ATTENTION!!//////////////////////////////
//<comment description="Zdes opredeliayutsia metody (remote) interfeisa"/>

//<comment description="Update Method">
	public void Update(){
		setModified();
	}
//<comment

//<comment description="setter/getters">
	//1
  	 public void setNOM_DMD(String newNOM_DMD){
      if( NOM_DMD.equals(newNOM_DMD) ) return;
      NOM_DMD = newNOM_DMD;
      setModified();
    }
    public String getNOM_DMD(){
      return (NOM_DMD!=null)?NOM_DMD:"";
    }
	//2
	public long getCOD_DMD(){
      return COD_DMD;
    }
    //-----------------------------
    //3
    public String getDES_DMD(){
      return (DES_DMD!=null)?DES_DMD:"";
    }
    public void setDES_DMD(String newDES_DMD){
      if( DES_DMD.equals(newDES_DMD) ) return;
      DES_DMD = newDES_DMD;
      setModified();
    }

    //-----------------------------#############################################
    // %%%Link%%% Table RST_DMD_TAB
    public void addCOD_RST(long newCOD_RST, String newRST_ESI){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("INSERT INTO rst_dmd_tab (cod_dmd,cod_rst,rst_esi) VALUES(?,?,?)");
           ps.setLong   (1, COD_DMD);
           ps.setLong		(2, newCOD_RST);
           ps.setString (3, newRST_ESI);
           ps.executeUpdate();
           //return new Long(COD_DMD);
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
		// %%%Update%%% Table RST_DMD_TAB  --- mary
    public void editCOD_RST(String newCOD_RST){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE rst_dmd_tab SET  rst_esi=? WHERE cod_dmd=? AND cod_rst IN (" + newCOD_RST + ") ");
           ps.setString (1, "S");
					 ps.setLong   (2, COD_DMD);
           
           ps.executeUpdate();
           //return new Long(COD_DMD);
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
		// %%%clear%%% Table RST_DMD_TAB  --- mary
    public void clearCOD_RST(){
      BMPConnection bmp=getConnection();
      try{
         PreparedStatement ps=bmp.prepareStatement("UPDATE rst_dmd_tab SET  rst_esi=? WHERE cod_dmd=? ");
           ps.setString (1, "N");
					 ps.setLong   (2, COD_DMD);
           
           ps.executeUpdate();
           //return new Long(COD_DMD);
      }
      catch(Exception ex){
          throw new EJBException(ex);
      }
      finally{bmp.close();}
 		}
    // %%%UNLink%%% Table RST_DMD_TAB
    public void removeCOD_RST(long newCOD_RST){
      BMPConnection bmp=getConnection();
      try
      {
         PreparedStatement ps=bmp.prepareStatement("DELETE FROM rst_dmd_tab  WHERE cod_dmd=? AND cod_rst=?");
         ps.setLong (1, COD_DMD);
         ps.setLong (2, newCOD_RST);
         if(ps.executeUpdate()==0) throw new NoSuchEntityException("Risposte con ID="+newCOD_RST+" non &egrave trovata");
      }
      catch(Exception ex)
      {
         throw new EJBException(ex);
      }
      finally{bmp.close();}
		}
    //-----------------------------#############################################

   //</comment>
	public long getNUM_PTG_DMD(long newCOD_TES_VRF)
	{
		BMPConnection bmp=getConnection();
		try
    	{
        	PreparedStatement ps=bmp.prepareStatement("SELECT num_ptg_dmd FROM dmd_tes_vrf_tab  WHERE cod_dmd=? AND cod_tes_vrf=?");
			ps.setLong (1, COD_DMD);
			ps.setLong (2, newCOD_TES_VRF);
			ResultSet rs=ps.executeQuery();
          	java.util.ArrayList al=new java.util.ArrayList();
  	        if(rs.next())
			{
				return rs.getLong(1);
           	}
           	else{
            	throw new NoSuchEntityException("Numero Punteggio Domanda con ID="+newCOD_TES_VRF+" non &egrave trovata");
           	}
      	}
      	catch(Exception ex){
          throw new EJBException(ex);
      	}
        finally{bmp.close();}
	}
	public void setNUM_PTG_DMD(long newNUM_PTG_DMD, long newCOD_TES_VRF)
	{
		BMPConnection bmp=getConnection();
		try
      	{
        	PreparedStatement ps=bmp.prepareStatement(
			"UPDATE dmd_tes_vrf_tab  SET num_ptg_dmd=? WHERE cod_dmd=? AND cod_tes_vrf=?" );
			ps.setLong (1, newNUM_PTG_DMD);
			ps.setLong (2, COD_DMD);
    		ps.setLong (3, newCOD_TES_VRF);
		    if(ps.executeUpdate()==0) 
			 throw new NoSuchEntityException("Numero Punteggio Domanda con ID="+newCOD_TES_VRF+" non &egrave trovata");
		}catch(Exception ex){
        	throw new EJBException(ex);
      	}finally{bmp.close();}
   	}
   ///////////ATTENTION!!//////////////////////////////////////
   //<comment description="Zdes opredeliayutsia metody-views"/>

   //<comment description="extended setters/getters">
   public Collection ejbGetDomande_List_View(){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT cod_dmd,nom_dmd,des_dmd FROM ana_dmd_tab ORDER BY nom_dmd");

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            Domande_List_View obj=new Domande_List_View();
            obj.COD_DMD=rs.getLong(1);
            obj.NOM_DMD=rs.getString(2);
						obj.DES_DMD=rs.getString(3);
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

   public Collection ejbGetDomandeRisposteByDMDID_View(long COD_DMD){
       BMPConnection bmp=getConnection();
      try{
          PreparedStatement ps=bmp.prepareStatement("SELECT rdt.cod_rst, rdt.rst_esi, art.nom_rst FROM rst_dmd_tab rdt, ana_rst_tab art WHERE rdt.cod_rst=art.cod_rst AND rdt.cod_dmd=? ORDER BY art.nom_rst");
					ps.setLong(1, COD_DMD);

          ResultSet rs=ps.executeQuery();
          java.util.ArrayList al=new java.util.ArrayList();
          while(rs.next()){
            DomandeRisposteByDMDID_View obj=new DomandeRisposteByDMDID_View();
            obj.COD_RST=rs.getLong(1);
            obj.RST_ESI=rs.getString(2);
            obj.NOM_RST=rs.getString(3);
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

//=============by Juli======
  public Collection findEx(
                                             Long lCOD_TES_VRF,
                                              String strNOM_DMD,
                                            String strDES_DMD,
                                              int iOrderBy /*not used for now*/
                                    )
    {
        return ejbFindEx(
                                             lCOD_TES_VRF,
                                              strNOM_DMD,
                                            strDES_DMD,
                                              iOrderBy /*not used for now*/

                                     );
    }

 public Collection ejbFindEx(Long lCOD_TES_VRF, String strNOM_DMD, String strDES_DMD, int iOrderBy /*not used for now*/)
 {
    String strSql=" SELECT cod_dmd,nom_dmd,des_dmd from ana_dmd_tab WHERE ";
    if(strNOM_DMD!=null){
        strSql+=" UPPER(nom_dmd) LIKE ? AND   ";
    }
    if(strDES_DMD!=null){
        strSql+=" UPPER(des_dmd) LIKE ? AND   ";
    }
    if (lCOD_TES_VRF!=null){

        strSql+=" cod_dmd NOT IN (SELECT cod_dmd  FROM  dmd_tes_vrf_tab WHERE cod_tes_vrf = ?)        ";
    }

    strSql=strSql.substring(1,strSql.length()- 6);

    int i=1;
    BMPConnection bmp=getConnection();
    try{
                    PreparedStatement ps=bmp.prepareStatement(strSql);
        if(strNOM_DMD!=null){
                ps.setString(i++, strNOM_DMD.toUpperCase());
        }

        if(strDES_DMD!=null){
                ps.setString(i++, strDES_DMD.toUpperCase());
        }
        if (lCOD_TES_VRF!=null){
                    ps.setLong(i++, lCOD_TES_VRF.longValue());
        }
        //----------------------------------------------------------------------
        ResultSet rs=ps.executeQuery();
        java.util.ArrayList ar= new java.util.ArrayList();
        while(rs.next()){
            Domande_List_View v=new Domande_List_View();
            v.COD_DMD=rs.getLong(1);
            v.NOM_DMD=rs.getString(2);
            v.DES_DMD=rs.getString(3);
            ar.add(v);
        //----------------------------------------------------------------------
        }
        return ar;
     }
     catch(Exception ex){
      throw new EJBException(ex);
     }
     finally{bmp.close();}


  }
///////////ATTENTION!!////////////////////////////////////////
}//<comment description="end of implementation  DomandeBean"/>
%>

<%
////////////////////////////////////////// <BINDING> /////////////////////////////////////////////////////////////////
//<comment description="Obiazatelnaja sviazka classa s PsevdoContextom"/>
PseudoContext.bind("DomandeBean", new DomandeBean());
////////////////////////////////////////// </BINDING> /////////////////////////////////////////////////////////////////
%>
