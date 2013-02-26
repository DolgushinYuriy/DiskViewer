package ru.diskviewer.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author Yuriy.Dolgushin
 */
@Controller
public class PathviewerController {
    // Сформировать данные для отображения.
    private boolean getParam(String path, Model model) {
        File filePath = new File(path);

        if (filePath.isDirectory()) {
            List<String> folders = new ArrayList<String>();
            List<HashMap> files = new ArrayList<HashMap>();

            // Приводим путь к номальному виду.
            path = filePath.getAbsolutePath() + "\\";

            String parent = filePath.getParent();
            if (null != parent && !parent.isEmpty()) {
                model.addAttribute("parent", "yes");
            }

            File[] fs = filePath.listFiles();
            if (null != fs) {
                for (File fileF : fs) {
                    fileF.length();
                    if (fileF.isDirectory()) {
                        folders.add(fileF.getName());
                    } else {
                        HashMap szFile = new HashMap();
                        szFile.put("name", fileF.getName());
                        szFile.put("size", fileF.length());
                        szFile.put("date", new SimpleDateFormat("dd.MM.yyyy HH:mm:ss").format(
                                new Date(fileF.lastModified())));
                        files.add(szFile);
                    }
                }
            }

            model.addAttribute("path", path);
            model.addAttribute("folders", folders);
            model.addAttribute("files", files);
        } else {
            return true;
        }

        return false;
    }

    @RequestMapping(value = "/pathviewer.htm", method = RequestMethod.POST)
    public String pathViewer(@RequestParam("path") String path, Model model) {
        if (path.isEmpty()) {
            model.addAttribute("message", "Не задан начальный путь!");
            return "home";
        }

        path = path.trim();
        model.addAttribute("path", path);

        return "pathviewer";
    }

    // Показать содержимое папки.
    @RequestMapping(value = "/viewfolder.htm", method = RequestMethod.POST)
    public String viewFolder(@RequestParam("path") String path, Model model) {
        if (getParam(path, model)) {
            model.addAttribute("message", "Неверная директория! " + path);
            return "home";
        }

        return "view_folder";
    }

    // Подняться в родительскую папку.
    @RequestMapping(value = "/viewfolderup.htm", method = RequestMethod.POST)
    public String viewFolderUp(@RequestParam("path") String path, Model model) {
        File filePath = new File(path);
        String parent = filePath.getParent();

        if (null != parent && !parent.isEmpty()) {
            if (getParam(parent, model)) {
                model.addAttribute("message", "Неверная директория! " + parent);
                return "home";
            }
        }

        return "view_folder";
    }

}
