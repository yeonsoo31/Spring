package com.icia.lastproject.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.JsonObject;
import com.icia.lastproject.dao.ProductDAO;
import com.icia.lastproject.dto.CartDTO;
import com.icia.lastproject.dto.MemberDTO;
import com.icia.lastproject.dto.PageDTO;
import com.icia.lastproject.dto.ProductDTO;
import com.icia.lastproject.dto.ProductListDTO;
import com.icia.lastproject.dto.ProductListTempDTO;

@Service
public class ProductListService {
	@Autowired
	private HttpSession session;

	@Autowired
	private ProductDAO pdao;
	
	private ModelAndView mav;
	
	
	public static final int PAGE_LIMIT = 8;
	public static final int BLOCK_LIMIT = 5;
	public static final String PREFIX_URL = "C:\\Users\\7\\git\\springgit\\Spring\\LastProject\\src\\main\\webapp\\resources\\fileupload\\";
	


	public String ListInsert(ProductListTempDTO plist) {
		int checkResult = pdao.Listinsert(plist);
		String resultMsg = null;
		if(checkResult==1) {
			resultMsg = "OK";
		} else {
			resultMsg = "NO";
		}
		return resultMsg;
		
	}



	public ModelAndView productAdd(ProductDTO product, MultipartHttpServletRequest mtfRequest) {
		mav = new ModelAndView();
		List<String> filesName = new ArrayList<String>();
		MultipartFile fileName = mtfRequest.getFile("photo4");
		List<MultipartFile> fileList = mtfRequest.getFiles("photo5");
		String realFileName = System.currentTimeMillis()+fileName.getOriginalFilename();
		String savePath = PREFIX_URL+realFileName;
		try {
			fileName.transferTo(new File(savePath));
		} catch (IllegalStateException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		for(MultipartFile mf: fileList) {
			String originFileName = System.currentTimeMillis()+mf.getOriginalFilename();
			long fileSize = mf.getSize();
			
			System.out.println("진짜파일네임>>>>>>>>>>>>>>"+originFileName);
			System.out.println("파일 사이즈 >>>>>>>>>>>>>>>" + fileSize);
			
			String saveFile = PREFIX_URL+originFileName;
			filesName.add(originFileName);
			try {
				mf.transferTo(new File(saveFile));
			} catch(IllegalStateException e){
				e.printStackTrace();
			} catch(IOException e) {
				e.printStackTrace();
			}
		}
		if(filesName.size()==2) {
			product.setPhoto2(filesName.get(0));
			product.setPhoto3(filesName.get(1));
		}else if(filesName.size()==1){
			product.setPhoto2(filesName.get(0));
		}else {
			mav.setViewName("redirect:/productlistpage");
		}
		
		product.setPhoto1(realFileName);
		
		
		int addResult = pdao.productAdd(product);
		int listinsert = pdao.productListAdd();
		if(addResult > 0) {
			int deleteTemp = pdao.deleteList();
			mav.setViewName("redirect:/productlistpage");
		}
		return mav;
	}


	// 한 페이지에 몇 개씩?
	private static final int PAGE_LIMIT1 = 4;
	// 이전 1~5 다음
	private static final int BLOCK_LIMIT1 = 5;
	
	public ModelAndView productList(int page) {
		mav = new ModelAndView();
		//1p 1~3
		int startRow = (page-1) * PAGE_LIMIT1 + 1;
		//2p 4~5
		int endRow = page * PAGE_LIMIT1;
		PageDTO paging = new PageDTO();
		paging.setStartrow(startRow);
		paging.setEndrow(endRow);
		
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		
		list = pdao.productList(paging);
		int listCount = pdao.listCount();
		int maxPage = (int) (Math.ceil((double) listCount / PAGE_LIMIT1));
		
		// 현재 페이지에 보여줄 시작 페이지 번호
		int startPage =
		(((int)(Math.ceil((double) page / BLOCK_LIMIT1))) - 1) * BLOCK_LIMIT1 + 1;

		// 현재 페이지에 보여줄 끝 페이지 번호(10, 20, 30, 40 ~~~)
		int endPage = startPage + BLOCK_LIMIT1 - 1;

		if (endPage > maxPage) {
				endPage = maxPage;
		}

		paging.setMaxpage(maxPage);
		paging.setStartpage(startPage);
		paging.setEndpage(endPage);
		paging.setPage(page);
		List<ProductDTO> list1 = pdao.productList1();
		List<ProductDTO> list2 = pdao.productList2();
		List<ProductDTO> list3 = pdao.productList3();
		
		
		mav.addObject("paging", paging);
		mav.addObject("productList", list);
		mav.addObject("productList1", list1);
		mav.addObject("productList2", list2);
		mav.addObject("productList3", list3);
		mav.setViewName("product/ProductsList");

		return mav;
		
	}



	public ModelAndView productView(int number, String userid) {
		mav = new ModelAndView();
		int hitCount = pdao.hitCount(number);
		ProductDTO product = pdao.SelectProduct(number);
		List<String> filesName = new ArrayList<String>();
		List<ProductListTempDTO> productlist = new ArrayList<ProductListTempDTO>();
		productlist = pdao.SelectProductList(number);
		String userid1 = (String) session.getAttribute("loginId");
		System.out.println(userid1);
		mav.addObject("userid", userid1);
		mav.addObject("product", product);
		mav.addObject("productList", productlist);
		mav.setViewName("product/productView");

		
		return mav;
	}



	public int ProductPriceAjax(int num) {
		int price = pdao.ProductPriceAjax(num);
		return price;
	}



	public int CartInsert(Map<String, Object> map) {
		int result = pdao.CartInsert(map);
		return result;
	}



	public ModelAndView CartView(String userid) {
		List<CartDTO> cart = new ArrayList<CartDTO>();
		cart = pdao.CartView(userid);
		mav.addObject("cart", cart);
		mav.setViewName("product/CartView");
		return mav;
	}



	public ModelAndView productModifyForm(int productno) {
		ProductDTO product = new ProductDTO();
		List<ProductListDTO> list = new ArrayList<ProductListDTO>();
		product = pdao.productModifyForm(productno);
		list = pdao.productlistModifyForm(productno);
		mav.addObject("product", product);
		mav.addObject("list",list);
		mav.setViewName("product/productModifyForm");
		return mav;
	}



	public JsonObject SummerNoteImageFile(MultipartFile file) {
		JsonObject jsonObject = new JsonObject();
		String fileRoot = "C:\\summernoteImg\\";
		String originalFileName = file.getOriginalFilename();
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));
		
		String saveFileName = UUID.randomUUID()+extension;
			
		File targetFile = new File(fileRoot+saveFileName);
		
		try {
			InputStream fileStream = file.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);
			jsonObject.addProperty("url", "/summernoteImg/"+saveFileName);
			jsonObject.addProperty("responseCode", "succcess");
		} catch(IOException e) {
			FileUtils.deleteQuietly(targetFile);
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}	
		return jsonObject;
	}



	public ModelAndView productModify(ProductDTO product) {
		mav=  new ModelAndView();
		String savePath = null;
		List<String> filesName = new ArrayList<String>();
		MultipartFile fileName = product.getPhoto4();
		System.out.println("어떻게 이게 있어 ????????????????????>>>>>>>>>"+fileName.getOriginalFilename());
		
		if(!fileName.isEmpty()) {
			String realFileName = System.currentTimeMillis() + fileName.getOriginalFilename();
			savePath = PREFIX_URL + realFileName;
			try {
				fileName.transferTo(new File(savePath));
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			product.setPhoto1(realFileName);
			System.out.println("바뀐파일 >>>>>>>>>>>>>>>>>>>>>>>>>>" + realFileName);
		} else {
			product.setPhoto1(product.getPhoto7());
		}
		
		List<MultipartFile> filesList = product.getPhoto5();
		
		if(filesList.size() == 1) {
			for(MultipartFile mf: filesList) {
				String originFileName = System.currentTimeMillis() + mf.getOriginalFilename();
				if(originFileName.contains(".")) {
					String saveFile = PREFIX_URL + originFileName;
					filesName.add(originFileName);
					try {
						mf.transferTo(new File(saveFile));
					} catch (IllegalStateException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					} catch (IOException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					product.setPhoto2(originFileName);
					System.out.println("여기로왔나ㅏㅏㅏㅏㅏ11111111111?" + originFileName);
					
				}else {
					if(product.getPhoto9() != null) {
					product.setPhoto2(product.getPhoto8());
					product.setPhoto3(product.getPhoto9());
					} else {
						product.setPhoto2(product.getPhoto8());
					}
				}
				
			}
		}else{
			for(MultipartFile mf:filesList) {
				String OriginFileName = System.currentTimeMillis() + mf.getOriginalFilename();
				String saveFile = PREFIX_URL + OriginFileName;
				filesName.add(OriginFileName);
				try {
					mf.transferTo(new File(saveFile));
				} catch (IllegalStateException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			product.setPhoto2(filesName.get(0));
			product.setPhoto3(filesName.get(1));
		}
		int modifyResult = pdao.productModify(product);
		
		if(modifyResult > 0) {
			mav.setViewName("redirect:/productlistpage");
		}
		
		return mav;
	}



	public ModelAndView productDelete(int productno) {
		mav = new ModelAndView();
		int result = pdao.productDelete(productno);
		int listresult = pdao.productListDelete(productno);
		if(result>0) {
			mav.setViewName("redirect:/productlistpage");
		}
		return mav;
	}



	public ModelAndView order(List<Integer> list) {
		String userid = (String) session.getAttribute("loginId");
		mav = new ModelAndView();
		List<CartDTO> cart = new ArrayList<CartDTO>();
		MemberDTO member = new MemberDTO();
		cart = pdao.Order(list);
		member = pdao.OrderUserid(userid);
		mav.addObject("cart", cart);
		mav.addObject("member", member);
		mav.setViewName("product/Order");
		return mav;
	}


	private static final int PAGE_LIMIT2 = 8;
	// 이전 1~5 다음
	private static final int BLOCK_LIMIT2 = 5;
	public ModelAndView productScroll(int categoryno, int page) {
		// 한 페이지에 몇 개씩?

		mav = new ModelAndView();
		//1p 1~3
		int startRow = (page-1) * PAGE_LIMIT2 + 1;
		//2p 4~5
		int endRow = page * PAGE_LIMIT2;
		PageDTO paging = new PageDTO();
		paging.setStartrow(startRow);
		paging.setEndrow(endRow);
		paging.setCategoryno(categoryno);
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
			
		list = pdao.productScorll(paging);
		int listCount = pdao.ScrollListCount(categoryno);
		int maxPage = (int) (Math.ceil((double) listCount / PAGE_LIMIT2));
		
		// 현재 페이지에 보여줄 시작 페이지 번호
		int startPage =
		(((int)(Math.ceil((double) page / BLOCK_LIMIT2))) - 1) * BLOCK_LIMIT2 + 1;

		// 현재 페이지에 보여줄 끝 페이지 번호(10, 20, 30, 40 ~~~)
		int endPage = startPage + BLOCK_LIMIT2 - 1;

		if (endPage > maxPage) {
				endPage = maxPage;
		}

		paging.setMaxpage(maxPage);
		paging.setStartpage(startPage);
		paging.setEndpage(endPage);
		paging.setPage(page);

		mav.addObject("categoryno", categoryno);
		mav.addObject("paging", paging);
		mav.addObject("productList", list);
		mav.setViewName("product/ProductScroll");

		return mav;
	}



	public List<ProductDTO> ScrollPage(int categoryno, int page) {
		int startRow = (page-1) * PAGE_LIMIT2 + 1;
		//2p 4~5
		int endRow = page * PAGE_LIMIT2;
		
		PageDTO paging = new PageDTO();
		paging.setStartrow(startRow);
		paging.setEndrow(endRow);
		paging.setCategoryno(categoryno);
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		
		list = pdao.productScorll(paging);
		
		return list;
	}



	public ModelAndView Serch(String serch) {
		mav = new ModelAndView(serch);
		List<ProductDTO> list = pdao.serch(serch);
		
		mav.addObject("list", list);
		mav.setViewName("product/serchList");
		return mav;
	}
	
	
}
