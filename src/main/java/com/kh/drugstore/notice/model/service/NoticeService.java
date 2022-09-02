package com.kh.drugstore.notice.model.service;

import java.util.List;

import com.kh.drugstore.notice.model.dto.Notice;

public interface NoticeService {

	List<Notice> selectNoticeList();

	int insertNotice(Notice notice);

	Notice oneNotice(int no);

	int updateNotice(Notice notice);

	int deleteNotice(int no);

}
