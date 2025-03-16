package com.spring.app.mail.model;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.app.mail.domain.MailVO;

@Repository
public abstract class MailDAO_imple implements MailDAO {
	
    @Autowired
    private SqlSessionTemplate sqlsession;

    @Override
    public int updateCheckDeleteStatus(List<Integer> mailNoList) {
        return sqlsession.update("com.spring.app.mail.model.MailDAO.updateDeleteStatus", mailNoList);
    }
    
    @Override
    public List<MailVO> selectSentMail(Map<String, String> paraMap) {
        return sqlsession.selectList("com.spring.app.mail.model.MailDAO.selectSentMail", paraMap);
    }

    
}