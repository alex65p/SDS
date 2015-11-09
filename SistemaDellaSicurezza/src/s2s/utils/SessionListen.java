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
 * SessionListen.java
 *
 * Created on 5 aprile 2007, 14.10
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package s2s.utils;

/**
 *
 * @author dario.massaroni
 */

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

public class SessionListen implements HttpSessionListener {

  private static int activeSession = 0;

  public synchronized void sessionCreated(HttpSessionEvent se) {
    HttpSession session = se.getSession();
    
    // Tempo di validità della sessione espresso in secondi.
    session.setMaxInactiveInterval(60*30);
    
    activeSession++;
    System.out.println(
            "SESSION CREATED: " + session.getId() +
            " - ACTIVE SESSION: " + getActiveSessionCount());
  }

  public synchronized void sessionDestroyed(HttpSessionEvent se) {
    HttpSession session = se.getSession();

    if (activeSession > 0){
        activeSession--;
        System.out.println(
                "SESSION DESTROYED: " + session.getId() +
                " - ACTIVE SESSION: " + getActiveSessionCount());
    }
  }

  public int getActiveSessionCount(){
    return activeSession;
  };
}
