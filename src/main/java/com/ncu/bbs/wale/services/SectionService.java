package com.ncu.bbs.wale.services;

import com.ncu.bbs.bean.Section;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;

import java.util.List;

@Service("SectionService")
@ContextConfiguration("classpath:applicationContext.xml")
public interface SectionService {

    public List<Section> findAllSections();

    Section findSectionBySectionId(Integer sectionId);
}
