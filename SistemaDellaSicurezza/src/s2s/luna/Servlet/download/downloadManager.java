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
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package s2s.luna.Servlet.download;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import s2s.luna.conf.ApplicationConfigurator;
import s2s.utils.text.StringManager;

public class downloadManager extends javax.servlet.http.HttpServlet implements
        javax.servlet.Servlet {

    static final long serialVersionUID = 1L;
    private static final int BUFSIZE = 4096;
    private String filePath;

    @Override
    public void init() {
        //
    }

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {

        // Determino l'applicazione da scaricare
        String appToDownload = request.getParameter("appName");
        if (StringManager.isEmpty(appToDownload)) {
            return;
        }

        // Determino il percorso dell'appliczione da scaricare
        String appPath = "EXTERNAL_APP" + File.separator + appToDownload;

        // Determino il nome del file da scaricare.
        String fileName = "";
        /*
         In futuro questa sezione potrà essere resa dinamica, andando a leggere
         la lista dei file presenti nel percorso dell'applicazione e scaricandoli tutti
         in automatico.
    
         Per il momento cabliamo invece direttamente nel codice il nome del file
         da scaricare.
         */
        if (appToDownload.equals("Firefox")) {
            fileName = "Firefox-Portable-3.5.19-for-BO-XI-3.1.zip";
        }
        if (StringManager.isEmpty(fileName)) {
            return;
        }

        // Determino il percorso completo del file di origine.
        filePath
                = ApplicationConfigurator.getApplicationPath()
                + "WEB" + File.separator + appPath + File.separator + fileName;

        File file = new File(filePath);
        int length = 0;
        ServletOutputStream outStream = response.getOutputStream();
        ServletContext context = getServletConfig().getServletContext();
        String mimetype = context.getMimeType(filePath);

        // sets response content type
        if (mimetype == null) {
            mimetype = "application/octet-stream";
        }
        response.setContentType(/*mimetype*/"application/octet-stream");
        response.setContentLength((int) file.length());

        // sets HTTP header
        response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

        byte[] byteBuffer = new byte[BUFSIZE];
        DataInputStream in = new DataInputStream(new FileInputStream(file));

        // reads the file's bytes and writes them to the response stream
        while ((in != null) && ((length = in.read(byteBuffer)) != -1)) {
            outStream.write(byteBuffer, 0, length);
        }

        in.close();
        outStream.close();
    }
}
