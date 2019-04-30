/*
 * Copyright 2011-2020 wuxia.tech All right reserved.
 */
package cn.wuxia.project.admin.view.config;

import cn.wuxia.common.util.StringUtil;
import cn.wuxia.project.basic.mvc.controller.BaseController;
import cn.wuxia.project.scheduler.AllPushJobScheduler;
import cn.wuxia.project.scheduler.core.entity.ScheduleJob;
import cn.wuxia.project.scheduler.core.service.ScheduleJobService;
import cn.wuxia.project.security.core.enums.SystemType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.PostConstruct;
import java.util.List;

/**
 * songlin.li
 */
@Controller
@RequestMapping("/system/scheduler")
public class SchedulerController extends BaseController {

    @Autowired
    private AllPushJobScheduler jobScheduler;

    @Autowired
    private ScheduleJobService scheduleJobService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) {
        List<ScheduleJob> jobList = scheduleJobService.findAll();
        model.addAttribute("list", jobList);
        return "scheduler/list";
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String create(Model model) {
        return edit(model, null);
    }

    @RequestMapping(value = "/edit/{id}", method = RequestMethod.GET)
    public String edit(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            ScheduleJob job = scheduleJobService.findById(id);
            model.addAttribute("job", job);
        }
        model.addAttribute("systems", SystemType.values());
        return "scheduler/edit";
    }

    @RequestMapping(value = "/del/{id}", method = RequestMethod.GET)
    //    @ResponseBody
    public String configDel(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            scheduleJobService.delete(id);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "/save", method = RequestMethod.POST)
    public String configSave(Model model, ScheduleJob job) {
        scheduleJobService.save(job);
        return "redirect:list";
    }

    @RequestMapping(value = "/startup/{id}", method = RequestMethod.GET)
    //    @ResponseBody
    public String startup(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            scheduleJobService.startTask(id);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "/paul/{id}", method = RequestMethod.GET)
    //    @ResponseBody
    public String paul(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            scheduleJobService.paulTask(id);
        }
        return "redirect:../list";
    }

    @RequestMapping(value = "/runonce/{id}", method = RequestMethod.GET)
    @ResponseBody
    public String runOnce(Model model, @PathVariable String id) {
        if (StringUtil.isNotBlank(id)) {
            scheduleJobService.runonceTask(id);
        }
        return "redirect:../list";
    }

    /**
     * 项目启动时初始化
     */
    @PostConstruct
    public void init() {
        scheduleJobService.init();
    }
}
