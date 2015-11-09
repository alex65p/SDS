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

public class SentinelSuperpro {
	static boolean libLoaded = false;
	
	public native int RNBOsproFormatPacket(byte[] apiPacket,
	                                         int apiPacketSize);
	public native int RNBOsproInitialize(byte[] apiPacket);
	public native int RNBOsproFindFirstUnit(byte[] apiPacket,
	                                          int developerID);
	public native int RNBOsproFindNextUnit(byte[] apiPacket);
	public native int RNBOsproRead(byte[] apiPacket, int address,
	                               int[] data);
	public native int RNBOsproExtendedRead(byte[] apiPacket,
	                                       int address, int[] data,
	                                       byte[] accessCode);
	public native int RNBOsproWrite(byte[] apiPacket,
	                                int writePassword, int address,
	                                int data, byte accessCode);
	public native int RNBOsproOverwrite(byte[] apiPacket,
	                                    int writePassword,
	                                    int overwritePassword1,
	                                    int overwritePassword2,
	                                    int address, int data,
	                                    byte accessCode);
	public native int RNBOsproDecrement(byte[] apiPacket,
	                                      int writePassword, int address);
	public native int RNBOsproActivate(byte[] apiPacket,
	                                     int writePassword,
	                                     int activatePassword1,
	                                     int activatePassword2,
	                                     int address);
	public native int RNBOsproQuery(byte[] apiPacket, int address,
	                                char[] queryData, char[] response,
	                                long[] response32, int length);
	public native int RNBOsproGetFullStatus(byte[] apiPacket);
	public native int RNBOsproGetVersion(byte[] apiPacket,
	                                       byte[] majVer, byte[] minVer,
	                                       byte[] rev, byte[] osDrvrType);
	public native int RNBOsproSetContactServer(byte[] apiPacket,
	                                       String serverName);
	public native String RNBOsproGetContactServer(byte[] apiPacket);
	public native int RNBOsproGetSubLicense(byte[] apiPacket,
	                                       int address);
	public native int RNBOsproReleaseLicense(byte[] apiPacket,
	                                       int address, int[] NumSubLicense);
	public native int RNBOsproGetHardLimit(byte[] apiPacket , int[] hardLmt);
	public native int RNBOsproSetHeartBeat(byte[] apiPacket, int heartBeat);
	public native int RNBOsproSetProtocol(byte[] apiPacket, int protocol);
	
	static 
	{
		try{
			if(!libLoaded){
	  		System.loadLibrary("sxjdk");
	  	}
	  	else
	  	{
			}
	  	libLoaded=true;
	  }
	  catch(Exception e){
	  }
	}
	
  public SentinelSuperpro() {};
}
