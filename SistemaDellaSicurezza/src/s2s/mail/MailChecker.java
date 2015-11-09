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

/*
 * Mailer.java
 *
 * Created on 12 giugno 2007, 10.33
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.mail;

/**
 *
 * @author dario.massaroni
 */

import javax.mail.internet.InternetAddress;
import javax.mail.internet.AddressException;

public class MailChecker {

  public MailChecker(){
      //
  }
    
  /**
  * Validate the form of an email address.
  *
  * <P>Return <code>true</code> only if 
  *<ul> 
  * <li> <code>aEmailAddress</code> can successfully construct an 
  * {@link javax.mail.internet.InternetAddress} 
  * <li> when parsed with a "@" delimiter, <code>aEmailAddress</code> contains 
  * two tokens which satisfy {@link hirondelle.web4j.util.Util#textHasContent}.
  *</ul>
  *
  *<P> The second condition arises since local email addresses, simply of the form
  * "<tt>albert</tt>", for example, are valid but almost always undesired.
  */
  public boolean isValidEmailAddress(String aEmailAddress){
    if (aEmailAddress == null) return false;
    
    boolean result = true;
    try {
      InternetAddress emailAddr = new InternetAddress(aEmailAddress);
      if ( ! hasNameAndDomain(aEmailAddress) ) {
        result = false;
      }
    }
    catch (AddressException ex){
      result = false;
    }
    return result;
  }
  
  private boolean hasNameAndDomain(String aEmailAddress){
    String[] tokens = aEmailAddress.split("@");
    return 
     tokens.length == 2 &&
     textHasContent( tokens[0] ) && 
     textHasContent( tokens[1] ) ;
  }
  
  private boolean textHasContent( String aText ){
    String emptyString = "";
    return (aText != null) && (!aText.trim().equals(emptyString));
  }
  
}
