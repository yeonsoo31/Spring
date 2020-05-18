package com.icia.lastproject.dto;

import lombok.Data;

@Data
public class PagingDTO {
	private int page;
	private int maxPage;
	private int startPage;
	private int endPage;
	private int startRow;
	private int endRow;
	private int a_number;

}
