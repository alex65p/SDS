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

package s2s.luna.util;

public class SentinelSuperproHelper {
	private Object sentinel=null;
	private Class sentinelClass=null;
	
	public SentinelSuperproHelper(){
		try{
			sentinelClass=Class.forName("SentinelSuperpro");
			sentinel = sentinelClass.getConstructors()[0].newInstance(new Object[]{});
		}
		catch(Exception e){
			e.printStackTrace(System.err);
		}
	}
	
  public int RNBOsproFormatPacket(byte[] apiPacket, int apiPacketSize){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproFormatPacket", 
	  		new Class[]{
	  			new byte[1].getClass(), Integer.TYPE
	  		}
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket, new Integer(apiPacketSize)});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }

  public int RNBOsproInitialize(byte[] apiPacket){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproInitialize", 
	  		new Class[]{
	  			new byte[1].getClass() }
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }
  public int RNBOsproFindFirstUnit(byte[] apiPacket, int developerID){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproFindFirstUnit", 
	  		new Class[]{
	  			new byte[1].getClass(), Integer.TYPE
	  		}
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket, new Integer(developerID)});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }
  public int RNBOsproFindNextUnit(byte[] apiPacket){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproFindNextUnit", 
	  		new Class[]{
	  			new byte[1].getClass(), Integer.TYPE
	  		}
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }
  public int RNBOsproReleaseLicense(byte[] apiPacket,int address, int[] NumSubLicense){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproReleaseLicense", 
	  		new Class[]{
	  			new byte[1].getClass(), Integer.TYPE, new int[1].getClass()
	  		}
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket, new Integer(address), NumSubLicense});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }

  public int RNBOsproRead(byte[] apiPacket,int address, int[] data){
  	int iRet=-1;
		try{
	  	java.lang.reflect.Method md = sentinelClass.getMethod("RNBOsproRead", 
	  		new Class[]{
	  			new byte[1].getClass(), Integer.TYPE, new int[1].getClass()
	  		}
	  		);
	  	Object oRet = md.invoke(sentinel, new Object[]{apiPacket, new Integer(address), data});
	  	iRet = ((Integer) oRet).intValue();
		}
		catch(Exception e){
			iRet=-1;
			e.printStackTrace(System.err);
		}

  	return iRet;
  }
}
